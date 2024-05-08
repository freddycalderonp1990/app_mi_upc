part of '../../data_repositories.dart';

class RegistroUsuarioApiImpl extends RegistroUsuarioRepository {
  final RegistroUsuarioApiProviderImpl   _registroUsuarioApiProviderImpl ;
  RegistroUsuarioApiImpl(this._registroUsuarioApiProviderImpl);

  @override
  Future<String> insertarUsuario({required String tipoUsuario, required double latitud, required double longitud,
    required String mail, required String fechaRegistro, required String tipoConexion, required String ssIDConexion,
    required String numCelular, required String versionAndroid, required String modeloCelular, required String cedula,
    required String ip, required String primerNombre, required String primerApellido, required String segundoApellido}) async {
    try {
      return  await _registroUsuarioApiProviderImpl.insertarUsuario(tipoUsuario: tipoUsuario, latitud: latitud,
          longitud: longitud, mail: mail, fechaRegistro: fechaRegistro, tipoConexion: tipoConexion, ssIDConexion: ssIDConexion,
          numCelular: numCelular, versionAndroid: versionAndroid, modeloCelular: modeloCelular, cedula: cedula, ip: ip,
          primerNombre: primerNombre, primerApellido: primerApellido, segundoApellido: segundoApellido);
    }  catch (e){
      throw ExceptionHelper.captureError(e);
    }
  }









}
