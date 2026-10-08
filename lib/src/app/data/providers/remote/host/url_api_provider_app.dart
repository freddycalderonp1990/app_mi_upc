
part of '../../providers_impl.dart';
//se elimina la variable secondsTimeout, XQ NO SE ESTABA ASIGANDO EL TIEMPO

class UrlApiProviderApp {
  String tag = "UrlProvider";


  Future<Map<String, String>> getheaders() async {
    String token= await getToken();


    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  static Future<String> getToken() async {

    final token =  "";
    print("getToken = ${token}");
    return token;
  }
  Future<String> post(
      {String segmento = '',
        Object? body,
        required String url,
        bool isLogin = false}) async {
    late final response;
    try {
      http.Client client = http.Client();

      print("la url es ${url}");
      var uri = Uri.parse(url);
      if (segmento != '') {
        uri = Uri.parse(url + segmento);
      }

      String _tag = tag + " POST ";
      PrintsMsj.myLog(tag: _tag, title: "uri:", detalle: uri.toString());

      Map<String, String> headers= await getheaders();

      response = await client
          .post(uri,
          body: jsonEncode(body), headers: headers)
          .timeout(Duration(seconds: AppConfig.secondsTimeout));

      PrintsMsj.myLog(
          tag: _tag, title: "body-request:", detalle: body.toString());
      PrintsMsj.myLog(
          tag: _tag,
          title: "statusCode:",
          detalle: response.statusCode.toString());
      PrintsMsj.myLog(
          tag: _tag,
          title: "body-response:",
          detalle: response.body.toString());
    } catch (e, stackTrace) {
      throw ExceptionHelper.captureError(e);
    }

    if (response.statusCode == 200) {
      return response.body.toString();
    } else if (response.statusCode == 401 && isLogin) {
      throw ServerException(cause: "Usuario / Clave incorrecta");
    } else {
      throw ServerException.StatusCode(statusCode: response.statusCode );
    }
  }

  Future<String> get({
    required String segmento,
    required String url,

  }) async {
    final response;
    try {
      http.Client client = http.Client();

      var uri = Uri.parse(url);
      if (segmento != '') {
        url = url + segmento;
        uri = Uri.parse(url);
      }

      Map<String, String> headers= await getheaders();
      response =
      await client.get(uri, headers: headers).timeout(
        Duration(seconds: AppConfig.secondsTimeout),
      );

      String _tag = tag + " GET ";

      PrintsMsj.myLog(tag: _tag, title: "-uri:", detalle: uri.toString());
      PrintsMsj.myLog(tag: _tag, title: "-body-request:", detalle: "NO BODY");
      PrintsMsj.myLog(
          tag: _tag,
          title: "-statusCode:",
          detalle: response.statusCode.toString());
      PrintsMsj.myLog(
          tag: _tag,
          title: "-body-response:",
          detalle: response.body.toString());
    } catch (e, stackTrace) {
      throw ExceptionHelper.captureError(e,);
    }

    if (response.statusCode == 200) {
      return response.body.toString();
    } else {
      throw ServerException.StatusCode(statusCode: response.statusCode);
    }
  }

  Future<String> delete(
      {required String segmento, Object? body, required String url}) async {
    final response;
    try {
      http.Client client = http.Client();

      var uri = Uri.parse(url);
      if (segmento != '') {
        url = url + segmento;
        uri = Uri.parse(url);
      }

      Map<String, String> headers= await getheaders();
      response = await client
          .delete(uri,
          headers: headers, body: jsonEncode(body))
          .timeout(
        Duration(seconds: AppConfig.secondsTimeout),
      );
      String _tag = tag + " DELETE ";
      PrintsMsj.myLog(tag: _tag, title: "-uri:", detalle: uri.toString());
      PrintsMsj.myLog(
          tag: _tag, title: "-body-request:", detalle: body.toString());
      PrintsMsj.myLog(
          tag: _tag,
          title: "-statusCode:",
          detalle: response.statusCode.toString());
      PrintsMsj.myLog(
          tag: _tag,
          title: "-body-response:",
          detalle: response.body.toString());
    } catch (e, stackTrace) {
      throw ExceptionHelper.captureError(e,);
    }

    if (response.statusCode == 200) {
      return response.body.toString();
    } else {
      throw ServerException.StatusCode(statusCode: response.statusCode);
    }
  }

  //Modifica toda la data
  Future<String> put(
      {String segmento = '', Object? body, required String url}) async {
    final response;
    try {
      http.Client client = http.Client();

      var uri = Uri.parse(url);
      if (segmento != '') {
        uri = Uri.parse(url + segmento);
      }
      Map<String, String> headers= await getheaders();
      response = await client
          .put(uri,
          body: jsonEncode(body), headers: headers)
          .timeout(Duration(seconds: AppConfig.secondsTimeout));

      String _tag = tag + " PUT ";
      PrintsMsj.myLog(tag: _tag, title: "-uri:", detalle: uri.toString());
      PrintsMsj.myLog(
          tag: _tag, title: "-body-request:", detalle: body.toString());
      PrintsMsj.myLog(
          tag: _tag,
          title: "-statusCode:",
          detalle: response.statusCode.toString());
      PrintsMsj.myLog(
          tag: _tag,
          title: "-body-response:",
          detalle: response.body.toString());
    } catch (e, stackTrace) {
      throw ExceptionHelper.captureError(e,);
    }
    if (response.statusCode == 200) {
      return response.body.toString();
    } else {
      throw ServerException.StatusCode(statusCode: response.statusCode);
    }
  }

  //Modifica Parte de la data

  Future<String> patch(
      {String segmento = '', Object? body, required String url}) async {
    final response;
    try {
      http.Client client = http.Client();

      var uri = Uri.parse(url);
      if (segmento != '') {
        uri = Uri.parse(url + segmento);
      }

      Map<String, String> headers= await getheaders();
      response = await client
          .patch(uri,
          body: jsonEncode(body), headers: headers)
          .timeout(Duration(seconds: AppConfig.secondsTimeout));
      String _tag = tag + " PATCH ";
      PrintsMsj.myLog(tag: _tag, title: "-uri:", detalle: uri.toString());
      PrintsMsj.myLog(
          tag: _tag, title: "-body-request:", detalle: body.toString());
      PrintsMsj.myLog(
          tag: _tag,
          title: "-statusCode:",
          detalle: response.statusCode.toString());
      PrintsMsj.myLog(
          tag: _tag,
          title: "-body-response:",
          detalle: response.body.toString());
    } catch (e, stackTrace) {
      throw ExceptionHelper.captureError(e, );
    }
    if (response.statusCode == 200) {
      return response.body.toString();
    } else {
      throw ServerException.StatusCode(statusCode: response.statusCode);
    }
  }

  Future<String> postUploadFile(
      {required doc.File file,
        required String segmento,
        required String url,
        Map<String, String>? body}) async {
    http.StreamedResponse response;
    String? parsed = null;
    try {

      Map<String, String> headers= await getheaders();

      var uri = Uri.parse(url);

      var stream = http.ByteStream(file.openRead().cast());
      var length = await file.length();
      var request = new http.MultipartRequest("POST", uri);
      var multipartFile = new http.MultipartFile("file", stream, length,
          filename: basename(file.path),
          contentType: MediaType("text", "plain"));

      request.files.add(multipartFile);
      request.headers.addAll(headers);
      if (body != null) {
        request.fields.addAll(body);
      }

      response = await request.send();
      parsed = await response.stream.transform(utf8.decoder).first;
      String _tag = tag + " POST-UPDATE-FILE ";
      PrintsMsj.myLog(
          tag: _tag, title: "postUploadFile-uri:", detalle: uri.toString());
      PrintsMsj.myLog(
          tag: _tag, title: "postUploadFile-body-request:", detalle: "IS FILE");
      PrintsMsj.myLog(
          tag: _tag,
          title: "postUploadFile-statusCode:",
          detalle: response.statusCode.toString());
      PrintsMsj.myLog(
          tag: _tag,
          title: "postUploadFile-body-response:",
          detalle: parsed.toString());
    } catch (e, stackTrace) {
      throw ExceptionHelper.captureError(e, );
    }
    if (response.statusCode == 200) {
      return parsed.toString();
    } else {
      throw ServerException.StatusCode(statusCode: response.statusCode);
    }
  }
}
