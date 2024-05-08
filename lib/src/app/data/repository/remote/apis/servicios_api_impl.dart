part of '../../data_repositories.dart';
class ServiciosApiImpl extends ServiciosRepository {
  final ServiciosApiProviderImpl   _serviciosApiProviderImpl ;
  ServiciosApiImpl(this._serviciosApiProviderImpl);

  @override
  Future<List<Servicio>> buscaListaServicios(int id) async{
    try {
      return  await _serviciosApiProviderImpl.buscaListaServicios(id);
    }  catch (e){
      throw ExceptionHelper.captureError(e);
    }
  }



}
