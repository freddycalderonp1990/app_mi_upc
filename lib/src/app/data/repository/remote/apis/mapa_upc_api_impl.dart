part of '../../data_repositories.dart';
class MapaUpcApiImpl extends MapaUpcRepository {
  final MapaUpcApiProviderImpl   _mapaUpcApiProviderImpl ;
  MapaUpcApiImpl(this._mapaUpcApiProviderImpl);

  @override
  Future<List<Upc>> buscaDatosUpc({required double la, required double lo}) async {
    try {
      return  await _mapaUpcApiProviderImpl.buscaDatosUpc(la:la,lo:lo);
    }  catch (e){
      throw ExceptionHelper.captureError(e);
    }
  }





}


