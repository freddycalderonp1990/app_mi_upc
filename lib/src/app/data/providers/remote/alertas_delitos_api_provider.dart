part of '../providers_impl.dart';

class AlertasDelitosApiProviderImpl extends AlertasDelitosRepository {
  @override
  Future<List<CatalogoModel>> consultaCatalogos(int idVariable) async {
    try {
      final segmento = "catalogos/v2/variables/$idVariable/atributos";

      final jsonResponse = await UrlApiProvider.getFullUrl(
        url: Host.gethostApis() + segmento,
      );

      final model = catalogosAlertaModelFromJson(jsonResponse);
      return model.result;
    } catch (e) {
      throw ExceptionHelper.captureError(e);
    }
  }

  @override
  Future<EventoEntity> crearEvento(EventoEntity evento) async {
    try {
      if (evento.archivoAdjunto != null) {
        return await _crearEventoConArchivo(evento);
      } else {
        return await _crearEventoSinArchivo(evento);
      }
    } catch (e) {
      throw ExceptionHelper.captureError(e);
    }
  }

  Future<EventoEntity> _crearEventoConArchivo(EventoEntity evento) async {
    try {
      final segmento = "v1/eventos";
      final url = Host.gethostApis() + segmento;

      final request = http.MultipartRequest("POST", Uri.parse(url));
      final headers = await UrlApiProvider.getheaders();

      headers.remove('Content-Type');
      headers['User-Agent'] = await _getUserAgent(); // ✅ HEADER REAL
      request.headers.addAll(headers);

      request.fields['idDispositivo'] = evento.idDispositivo;
      request.fields['tipoEvento'] = evento.tipoEvento;
      request.fields['fechaEvento'] = evento.fechaEvento;
      request.fields['descripcionEvento'] = evento.descripcionEvento;
      request.fields['referenciaLugar'] = evento.referenciaLugar;
      request.fields['latitudDispositivo'] =
          evento.latitudDispositivo.toString();
      request.fields['longitudDispositivo'] =
          evento.longitudDispositivo.toString();
      request.fields['latitudEvento'] = evento.latitudEvento.toString();
      request.fields['longitudEvento'] = evento.longitudEvento.toString();
      request.fields['nombreSeudonimo'] = evento.nombreSeudonimo;
      request.fields['numeroTelefono'] = evento.numeroTelefono;
      request.fields['correoElectronico'] = evento.correoElectronico;
      request.fields['estado'] = evento.estado;

      // Opcional: también mandarlo en campo body si tu API lo guarda
      request.fields['agenteUsuario'] = await _getUserAgent();

      final mimeType =
          lookupMimeType(evento.archivoAdjunto!.path) ?? 'application/octet-stream';

      if (!mimeType.startsWith('image/') && !mimeType.startsWith('video/')) {
        throw Exception('Solo se permiten archivos de imagen o video');
      }

      final mimeParts = mimeType.split('/');

      request.files.add(
        await http.MultipartFile.fromPath(
          'file',
          evento.archivoAdjunto!.path,
          contentType: MediaType(mimeParts[0], mimeParts[1]),
        ),
      );

      final streamedResponse = await request.send();
      final responseBody = await streamedResponse.stream.bytesToString();

      print("crearEventoMultipart-url: $url");
      print("crearEventoMultipart-statusCode: ${streamedResponse.statusCode}");
      print("crearEventoMultipart-responseBody: $responseBody");
      print("crearEventoMultipart-User-Agent: ${request.headers['User-Agent']}");

      if (streamedResponse.statusCode == 200 ||
          streamedResponse.statusCode == 201) {
        final Map<String, dynamic> jsonMap = jsonDecode(responseBody);
        final model = EventoModel.fromJson(jsonMap);
        return model;
      } else {
        throw ServerException.StatusCode(
          statusCode: streamedResponse.statusCode,
        );
      }
    } catch (e) {
      throw ExceptionHelper.captureError(e);
    }
  }
  Future<EventoEntity> _crearEventoSinArchivo(EventoEntity evento) async {
    try {
      final segmento = "v1/eventos";
      final url = Host.gethostApis() + segmento;

      final headers = await UrlApiProvider.getheaders();
      headers['User-Agent'] = await _getUserAgent(); // ✅ HEADER REAL

      final body = {
        "idDispositivo": evento.idDispositivo,
        "tipoEvento": evento.tipoEvento,
        "fechaEvento": evento.fechaEvento,
        "descripcionEvento": evento.descripcionEvento,
        "referenciaLugar": evento.referenciaLugar,
        "latitudDispositivo": evento.latitudDispositivo,
        "longitudDispositivo": evento.longitudDispositivo,
        "latitudEvento": evento.latitudEvento,
        "longitudEvento": evento.longitudEvento,
        "nombreSeudonimo": evento.nombreSeudonimo,
        "numeroTelefono": evento.numeroTelefono,
        "correoElectronico": evento.correoElectronico,
        "urlArchivoRespaldo": evento.urlArchivoRespaldo,
        "nombreArchivoRespaldo": evento.nombreArchivoRespaldo,
        "tipoMimeArchivoRespaldo": evento.tipoMimeArchivoRespaldo,
        "tamanioArchivoRespaldo": evento.tamanioArchivoRespaldo,
        "direccionIp": evento.direccionIp,
        "agenteUsuario": _getUserAgent(), // ✅ también en body si quieres guardar
        "estado": evento.estado,
        "fechaCreacion": evento.fechaCreacion,
        "fechaActualizacion": evento.fechaActualizacion,
      };

      final response = await http
          .post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(body),
      )
          .timeout(
        Duration(
          seconds: AppConfig.AmbienteUrl == Ambiente.produccion ? 8 : 30,
        ),
      );

      print("crearEventoJson-url: $url");
      print("crearEventoJson-statusCode: ${response.statusCode}");
      print("crearEventoJson-responseBody: ${response.body}");
      print("crearEventoJson-User-Agent: ${headers['User-Agent']}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonMap = jsonDecode(response.body);
        final model = EventoModel.fromJson(jsonMap);
        return model;
      } else {
        throw ServerException.StatusCode(statusCode: response.statusCode);
      }
    } catch (e) {
      throw ExceptionHelper.captureError(e);
    }
  }
  Future<String> _getUserAgent() async {
    String modeloCelular='';
    try {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        modeloCelular = 'App Android-''${androidInfo.manufacturer}-${androidInfo.model}';
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        modeloCelular = 'App iOS-''${iosInfo.utsname.machine}-${iosInfo.systemVersion}';
      }
      return modeloCelular;
    } catch (e) {
      return "Desconocido-App-Movil";
    }
  }

}
