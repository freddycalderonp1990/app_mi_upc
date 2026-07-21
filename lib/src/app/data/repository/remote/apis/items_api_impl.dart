part of '../../data_repositories.dart';

class MiUpcItemsApiImpl extends MiUpcItemsRepository {
  final MiUpcItemsApiProviderImpl _itemsApiProviderImpl;
  MiUpcItemsApiImpl(this._itemsApiProviderImpl);

  @override
  Future<List<Item>> buscaDatosItem(int id) async {
    try {
      return await _itemsApiProviderImpl.buscaDatosItem(id);
    } catch (e) {
      throw ExceptionHelper.captureError(e);
    }
  }
}
