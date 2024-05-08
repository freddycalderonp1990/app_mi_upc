part of '../../data_repositories.dart';
class ModulosApiImpl extends ModulosRepository {
  final ModulosApiProviderImpl   _modulosApiProviderImpl ;
  ModulosApiImpl(this._modulosApiProviderImpl);

  @override
  Future<List<Modulo>> buscaListaModulos() async {
    try {
      return  await _modulosApiProviderImpl.buscaListaModulos();
    }  catch (e){
     throw ExceptionHelper.captureError(e);
    }
  }


}
