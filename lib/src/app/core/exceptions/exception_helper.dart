import 'exceptions.dart';

class ExceptionHelper {
  static captureError(Object e) {
    if (e is ServerException) {
      throw ServerException(cause: e.cause);
    } else {
      throw ServerException.msj(e.toString());
    }

  }

  static String getError(Object e) {
    if (e is ServerException) {
      throw ServerException(cause: e.cause);
    } else {
      throw ServerException.msj(e.toString());
    }

  }
}
