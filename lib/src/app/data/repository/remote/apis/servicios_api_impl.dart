part of '../../data_repositories.dart';
class ServiciosApiImpl extends ServiciosRepository {
  final ServiciosApiProvider   _serviciosApiProviderImpl ;
  ServiciosApiImpl(this._serviciosApiProviderImpl);

  @override
  Future<List<Servicio>> buscaListaServicios(int id) async{
    try {
      return  await _serviciosApiProviderImpl.buscaListaServicios(id);
    }  catch (e){
      throw ExceptionHelper.captureError('No tiene Acceso a Internet');
    }
  }

  @override
  Future<bool> registrarEvento({required String tipoEvento, required String descripcion, required String imagen}) async {
    try {
      return  await _serviciosApiProviderImpl.registrarEvento(tipoEvento: tipoEvento, descripcion: descripcion, imagen: imagen);
    }  catch (e){
      throw ExceptionHelper.captureError(e);
    }
  }



}
