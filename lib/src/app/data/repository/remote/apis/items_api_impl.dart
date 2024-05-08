part of '../../data_repositories.dart';
class ItemsApiImpl extends ItemsRepository {
  final ItemsApiProviderImpl   _itemsApiProviderImpl ;
  ItemsApiImpl(this._itemsApiProviderImpl);

  @override
  Future<List<Item>> buscaDatosItem(int id) async {
    try {
      return  await _itemsApiProviderImpl.buscaDatosItem(id);
    }  catch (e){
      throw ExceptionHelper.captureError(e);
    }
  }

}


