part of '../providers_impl.dart';

class MiUpcItemsApiProviderImpl extends MiUpcItemsRepository {
  @override
  Future<List<Item>> buscaDatosItemOld(int id) async {
    try {
      String segmento =
          "polco/index.php?opc=a5ef8f60cf849b2edb66370f01be08a89b7e2b5f&modulo=ddced13c854fb2c03d6e01ce5bfd7e08&id=" +
              id.toString();
      String json = await UrlApiProvider.get(segmento: segmento);
      List<Item> data = itemsServiciosMiupcFromJson(json).upcServitems.items;
      return data;
    } catch (e) {
      throw ExceptionHelper.captureError(e);
    }
  }

  @override
  Future<List<Item>> buscaDatosItem(int id) async {
    try {
      final json = await UrlApiProvider.leerJsonLocal(  AppJson.JSONItems + "${id}.json",);
      return itemsServiciosMiupcFromJson(json).upcServitems.items;
    } catch (e) {
      return await buscaDatosItemOld( id);
    }
  }
}
