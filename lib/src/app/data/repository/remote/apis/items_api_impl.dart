part of '../../data_repositories.dart';
class ItemsApiImpl extends ItemsRepository {
  final ItemsApiProvider   itemsApiProviderImpl ;
  ItemsApiImpl( {required this.itemsApiProviderImpl});

  @override
  Future<List<Item>> buscaDatosItem(int id) async {
    try {
      return  await itemsApiProviderImpl.buscaDatosItem(id);
    }  catch (e){
      throw ExceptionHelper.captureError('No tiene Acceso a Internet');
    }
  }

  @override
  Future<List<ItemOffLine>> buscaDatosItemsOffline() async{
    try {
      return  await itemsApiProviderImpl.buscaDatosItemsOffline();
    }  catch (e){
      throw ExceptionHelper.captureError(e);
    }
  }

}


