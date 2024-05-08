part of '../providers_impl.dart';
class MapaUpcApiProviderImpl extends MapaUpcRepository {
  @override
  Future<List<Upc>> buscaDatosUpc({required double la, required double lo}) async {
    try {
      String segmento="polco/index.php?opc=e6fd0cbbb095b3cb1cee0ed2ea89658a0c3fa4be&modulo=ddced13c854fb2c03d6e01ce5bfd7e08&la=$la&lo=$lo";
      String json = await UrlApiProvider.get(segmento: segmento);
      List<Upc> data= datosUpcFromJson(json).genUpc.upc;
      return data;
    } catch (e) {
      throw ExceptionHelper.captureError(e);
    }
  }



}
