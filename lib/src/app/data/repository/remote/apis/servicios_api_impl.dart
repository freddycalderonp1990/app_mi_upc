part of '../../data_repositories.dart';

class MiUpcServiciosApiImpl extends MiUpcServiciosRepository {
  final MiUpcServiciosApiProviderImpl _serviciosApiProviderImpl;
  MiUpcServiciosApiImpl(this._serviciosApiProviderImpl);

  @override
  Future<List<Servicio>> buscaListaServicios(int id) async {
    try {
      return await _serviciosApiProviderImpl.buscaListaServicios(id);
    } catch (e) {
      throw ExceptionHelper.captureError(e);
    }
  }
}
