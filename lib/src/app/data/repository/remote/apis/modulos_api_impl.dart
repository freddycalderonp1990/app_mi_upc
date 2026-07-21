part of '../../data_repositories.dart';

class MiUpcModulosApiImpl extends MiUpcModulosRepository {
  final MiUpcModulosApiProviderImpl _modulosApiProviderImpl;
  MiUpcModulosApiImpl(this._modulosApiProviderImpl);

  @override
  Future<List<Modulo>> buscaListaModulos() async {
    try {
      return await _modulosApiProviderImpl.buscaListaModulos();
    } catch (e) {
      throw ExceptionHelper.captureError(e);
    }
  }
}
