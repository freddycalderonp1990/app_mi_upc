part of '../providers_impl.dart';
class ModulosApiProviderImpl extends ModulosRepository {

  @override
  Future<List<Modulo>> buscaListaModulos() async {
    try {
      String segmento="polco/index.php?opc=9206073e6ac2a05d16b18901f8fa3a8eb386b176&modulo=ddced13c854fb2c03d6e01ce5bfd7e08";
      String json = await UrlApiProvider.get(segmento: segmento);
      List<Modulo> data= modulosMiupcFromJson(json).upcModulosMovil.modulos;

      return data;
    } catch (e) {
     throw ExceptionHelper.captureError(e);
   }
  }

}
