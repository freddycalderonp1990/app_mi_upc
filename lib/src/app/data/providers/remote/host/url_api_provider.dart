part of '../../providers_impl.dart';

class UrlApiProvider {
  static int _secondsTimeout =
      AppConfig.AmbienteUrl == Ambiente.produccion ? 8 : 30;

  static Future<Map<String, String>> getheaders() async {

    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      "charset": "UTF-8",
      'Authorization': 'Bearer ',
    };
  }

  static Future<String> post(
      {String segmento = '',
      Object? body,
      bool isLogin = false,
      bool onlyUrl = false}) async {
    try {
      http.Client client = http.Client();

      if (isLogin) {
        onlyUrl = true;
      }

      final String url = Host.gethost(onlyUrl: onlyUrl);

      var uri = Uri.parse(url);

      if (segmento != '') {
        uri = Uri.parse(url + segmento);
      }

      print("post-uri: ${uri.toString()}");
      print("post-body: ${body.toString()}");

      Map<String, String> headers = await getheaders();


      final response = await client
          .post(uri, body: jsonEncode(body), headers: headers)
          .timeout(Duration(seconds: _secondsTimeout));

      print("post-statusCode: ${response.statusCode}");
      print("post-responsebody: ${response.body}");

      if (response.statusCode == 200) {
        if (!isLogin) {
          log(response.body);
        }
        return response.body;
      } else if (response.statusCode == 401 && isLogin) {
        throw ServerException(cause: "El Usuario o clave es incorrecta");
      } else if (response.statusCode == 423 && isLogin) {
        throw ServerException(cause: "No se encuentra activo");
      } else {
        throw ServerException.StatusCode(statusCode: response.statusCode);
      }
    } catch (e) {
      throw ExceptionHelper.captureError(e);
    }
  }

  static Future<String> get({
    required String segmento,
    bool onlyUrl = false,
  }) async {
    try {
      http.Client client = http.Client();

      String url = Host.gethost(onlyUrl: onlyUrl);

      var uri = Uri.parse(url);
      if (segmento != '') {
        url = url + segmento;
        uri = Uri.parse(url);
      }

      print("la url: $url");
      Map<String, String> headers = await getheaders();
      final response = await client.get(uri, headers: headers).timeout(
            Duration(seconds: _secondsTimeout),
          );

      print("response.statusCode: ${response.statusCode}");

      if (response.statusCode == 200) {
        print("bodyTrasnformeee ${response.body.toString()}");
              return response.body;
      } else {
        throw ServerException.StatusCode(statusCode: response.statusCode);
      }
    } catch (e) {
      throw ExceptionHelper.captureError(e);
    }
  }

  static Future<String> delete({required String segmento, Object? body}) async {
    try {
      http.Client client = http.Client();

      String url = Host.gethost();

      var uri = Uri.parse(url);
      if (segmento != '') {
        url = url + segmento;
        uri = Uri.parse(url);
      }

      print("la url: $url");
      Map<String, String> headers = await getheaders();
      final response = await client
          .delete(uri, headers: headers, body: jsonEncode(body))
          .timeout(
            Duration(seconds: _secondsTimeout),
          );

      print("response.statusCode: ${response.statusCode}");

      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw ServerException.StatusCode(statusCode: response.statusCode);
      }
    } catch (e) {
      throw ExceptionHelper.captureError(e);
    }
  }

//Modifica toda la data
  static Future<String> put(
      {String segmento = '', Object? body, bool onlyUrl = false}) async {
    try {
      http.Client client = http.Client();

      final String url = Host.gethost(onlyUrl: onlyUrl);

      var uri = Uri.parse(url);
      if (segmento != '') {
        uri = Uri.parse(url + segmento);
      }
      print("post-uri: ${uri.toString()}");
      print("post-body: ${body.toString()}");
      Map<String, String> headers = await getheaders();
      final response = await client
          .put(uri, body: jsonEncode(body), headers: headers)
          .timeout(Duration(seconds: _secondsTimeout));

      print("post-statusCode: ${response.statusCode}");
      print("post-responsebody: ${response.body}");

      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw ServerException.StatusCode(statusCode: response.statusCode);
      }
    } catch (e) {
      throw ExceptionHelper.captureError(e);
    }
  }

  //Modifica parte de la data
  static Future<String> patch(
      {String segmento = '', Object? body, bool onlyUrl = false}) async {
    try {
      http.Client client = http.Client();

      final String url = Host.gethost(onlyUrl: onlyUrl);

      var uri = Uri.parse(url);
      if (segmento != '') {
        uri = Uri.parse(url + segmento);
      }
      print("post-uri: ${uri.toString()}");
      print("post-body: ${body.toString()}");
      Map<String, String> headers = await getheaders();
      final response = await client
          .patch(uri, body: jsonEncode(body), headers: headers)
          .timeout(Duration(seconds: _secondsTimeout));

      print("post-statusCode: ${response.statusCode}");
      print("post-responsebody: ${response.body}");

      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw ServerException.StatusCode(statusCode: response.statusCode);
      }
    } catch (e) {
      throw ExceptionHelper.captureError(e);
    }
  }

  static Future<String> postUploadFile(
      {required doc.File file, required String segmento}) async {
    try {
      String? parsed = null;

      String url = Host.gethost();

      var uri = Uri.parse(url);
      if (segmento != '') {
        url = url + segmento;
        uri = Uri.parse(url);
      }

      print("la url: $url");

      var stream = new http.ByteStream(DelegatingStream.typed(file.openRead()));
      var length = await file.length();

      var request = new http.MultipartRequest("POST", uri);

      var multipartFile = new http.MultipartFile("file", stream, length,
          filename: basename(file.path),
          contentType: MediaType("text", "plain"));

      request.files.add(multipartFile);

      Map<String, String> headers = await getheaders();

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      parsed = await response.stream.transform(utf8.decoder).first;

      print("response.statusCode= ${response.statusCode}");
      print("parsed recibio= ${parsed}");

      if (response.statusCode == 200) {
        return parsed.toString();
      } else {
        throw ServerException.StatusCode(statusCode: response.statusCode);
      }
    } catch (e) {
      throw ExceptionHelper.captureError(e);
    }
  }
  static Future getUrlUploadFile({required File file}) async {
    try {
      String? parsed = null;
      String url = Host.gethost();
      Uri uri = await Uri.parse(url + "comandoGeneral/index.php?opc=" + AppConfig.SAVE_IMG + "&modulo="+AppConfig.MODULO);
      print("uriuriuriuriuriuriuriuri ${uri}");
    //  Uri uri = await Uri.parse(url);

      var stream = new http.ByteStream(DelegatingStream.typed(file.openRead()));
      var length = await file.length();
      var request = new http.MultipartRequest("POST", uri);
      request.fields['opc'] = AppConfig.SAVE_IMG ;
      request.fields['modulo'] = AppConfig.MODULO ;
      var multipartFile = new http.MultipartFile("file", stream, length,
          filename: basename(file.path),contentType: MediaType("text","plain") );
      request.files.add(multipartFile);
      http.StreamedResponse response = await request.send();
      parsed = await response.stream.transform(utf8.decoder).first;
      print("upload img json ${parsed}");
      return parsed;
    } catch (e) {
      print(e.toString());
    }
  }
}
