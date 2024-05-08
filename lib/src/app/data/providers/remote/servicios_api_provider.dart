part of '../providers_impl.dart';
class ServiciosApiProviderImpl extends ServiciosRepository {

  @override
  Future<List<Servicio>> buscaListaServicios(int id) async {
    try {
      String segmento="polco/index.php?opc=e71783b8bd0839724a0a671d8bc90b6c4c9d7069&modulo=ddced13c854fb2c03d6e01ce5bfd7e08&id="+id.toString();
      String json = await UrlApiProvider.get(segmento: segmento);
      List<Servicio> data= serviciosMiupcFromJson(json).upcServicio.servicios;
      return data;
    } catch (e) {
      throw ExceptionHelper.captureError(e);
    }
  }




}
