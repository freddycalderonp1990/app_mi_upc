part of '../providers_impl.dart';

abstract class ItemsApiProvider {
  Future<List<Item>> buscaDatosItem(int id) ;
  Future<List<ItemOffLine>> buscaDatosItemsOffline() ;

}

class ItemsApiProviderImpl extends ItemsApiProvider {

  @override
  Future<List<Item>> buscaDatosItem(int id) async {
    try {
      String segmento="polco/index.php?opc=a5ef8f60cf849b2edb66370f01be08a89b7e2b5f&modulo=ddced13c854fb2c03d6e01ce5bfd7e08&id="+id.toString();
      String json = await UrlApiProvider.get(segmento: segmento);
      List<Item> data= itemsServiciosMiupcFromJson(json).upcServitems.items;
      return data;
    } catch (e) {
      throw ExceptionHelper.captureError(e);
    }
  }

  @override
  Future<List<ItemOffLine>> buscaDatosItemsOffline() async {
    try {
      String segmento="polco/index.php?opc=79455fc0aa4fa00402e1d4f8160eb21e&modulo=ddced13c854fb2c03d6e01ce5bfd7e08";
      String json = await UrlApiProvider.get(segmento: segmento);
      List<ItemOffLine> data= itemsServiciosMiupcOffLineFromJson(json).upcServitemsOffLine.items;
      return data;
    } catch (e) {
      throw ExceptionHelper.captureError(e);
    }
  }




}
