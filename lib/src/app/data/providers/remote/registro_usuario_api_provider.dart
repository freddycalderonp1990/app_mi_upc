part of '../providers_impl.dart';

abstract class RegistroUsuarioApiProvider {
  Future<String> insertarUsuario({
    required String tipoUsuario,
    required double latitud,
    required double longitud,
    required String mail,
    required String fechaRegistro,
    required String tipoConexion,
    required String ssIDConexion,
    required String numCelular,
    required String versionAndroid,
    required String modeloCelular,
    required String cedula,
    required String ip,
    required String primerNombre,
    required String primerApellido,
    required String segundoApellido,
  });
}

class RegistroUsuarioApiProviderImpl extends RegistroUsuarioApiProvider {
  @override
  Future<String> insertarUsuario({
    required String tipoUsuario,
    required double latitud,
    required double longitud,
    required String mail,
    required String fechaRegistro,
    required String tipoConexion,
    required String ssIDConexion,
    required String numCelular,
    required String versionAndroid,
    required String modeloCelular,
    required String cedula,
    required String ip,
    required String primerNombre,
    required String primerApellido,
    required String segundoApellido,
  }) async {
    try {
      String segmento = "polco/index.php";
      Map<String, dynamic> body = {
        "latitud": latitud,
        "longitud": longitud,
        "tipoUsuario": tipoUsuario,
        "mail": mail,
        "fechaRegistro": fechaRegistro,
        "tipoConexion": tipoConexion,
        "ssIDConexion": ssIDConexion,
        "numCelular": numCelular,
        "versionAndroid": versionAndroid,
        "modeloCelular": modeloCelular,
        "cedula": cedula,
        "primerNombre": primerNombre,
        "primerApellido": primerApellido,
        "segundoApellido": segundoApellido,
        "ip": ip,
        "opc": "82713fab56ccb1010531b972ba3f3c4d",
        "modulo": "ddced13c854fb2c03d6e01ce5bfd7e08",
      };

      String json = await UrlApiProvider.post(segmento: segmento, body: body);
      return insertModelFromJson(json).insert.msj;
    } catch (e) {
      throw ExceptionHelper.captureError(e);
    }
  }
}
