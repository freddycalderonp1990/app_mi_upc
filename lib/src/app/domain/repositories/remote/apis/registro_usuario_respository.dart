part of '../../domain_repositories.dart';

abstract class RegistroUsuarioRepository {
  Future<String> insertarUsuario({ required String tipoUsuario, required double latitud,required double longitud,
    required String mail, required String fechaRegistro,required String tipoConexion,required String ssIDConexion,required String numCelular,
    required String versionAndroid,required String modeloCelular,
    required String cedula,required String ip,required String primerNombre,required String primerApellido,required String segundoApellido}) ;


}