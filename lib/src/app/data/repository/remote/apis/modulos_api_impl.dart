part of '../../data_repositories.dart';
class ModulosApiImpl extends ModulosRepository {
  final ModulosApiProvider   _modulosApiProviderImpl ;
  ModulosApiImpl(this._modulosApiProviderImpl);

  @override
  Future<List<Modulo>> buscaListaModulos() async {
    try {
      return  await _modulosApiProviderImpl.buscaListaModulos();
    }  catch (e){
     throw ExceptionHelper.captureError(e);
    }
  }

  @override
  Future<DgoUsuariosAlertaApp> buscaPermisoBoton({required int idGenPersona, required String nomApp}) async {
    try {
      return  await _modulosApiProviderImpl.buscaPermisoBoton(idGenPersona: idGenPersona, nomApp: nomApp);
    }  catch (e){
      throw ExceptionHelper.captureError(e);
    }
  }


}
