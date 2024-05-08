

import '../../core/app_config.dart';

abstract class Failure implements Exception {
  final String message;

  Failure({
    required this.message,
  });

  get msj=>message;


}

class ServerException implements Exception {
  final String cause;

  ServerException({ required this.cause});


  factory ServerException.msj(msjException
   ) {
    String mesage = 'No es posible conectar con el servidor. Contacte con el administrador';

    if (AppConfig.AmbienteUrl != Ambiente.produccion) {
      mesage = mesage + ' Exception: ' + msjException;
    }

    return ServerException(cause:mesage);
  }

  factory ServerException.StatusCode(
      {int statusCode = 0,

      String msjException = ''}) {
    String mesage = 'No definido';

    switch (statusCode) {
      case 404: //HTTP_NOT_FOUND
        mesage =
            "No es posible conectar con el servidor. Pagina no encontrada.";
        break;

      case 400: //HTTP_Bad_Request
        mesage = "No es posible conectar con el servidor. Solicitud incorrecta";
        break;

      case 401: //HTTP_No_autorizado
        mesage = "No es posible conectar con el servidor. Acceso no Autorizado";
        break;

      case 500: //HTTP_No_autorizado
        mesage = 'Problema con el servidor'
            '\n\nPor favor revise su conexión a internet y vuelve a ejecutar la acción. '
            'Si el problema persiste contacte con el administrador.  ';
        break;

      default:
        mesage = 'No  es posible conectar con el servidor.'
            '\n\nPor favor revise su conexión a internet y vuelve a ejecutar la acción. '
            'Si el problema persiste contacte con el administrador.  ';
        break;
    }

    if (AppConfig.AmbienteUrl != Ambiente.produccion) {
      mesage = mesage + ' Exception: ' + msjException;
    }


    return ServerException(cause:mesage);
  }
}

class CacheException implements Exception {}
