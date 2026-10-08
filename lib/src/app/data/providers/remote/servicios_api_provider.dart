part of '../providers_impl.dart';
abstract class ServiciosApiProvider {
  Future<List<Servicio>> buscaListaServicios(int id) ;

  Future<bool> registrarEvento({required String tipoEvento,
    required String descripcion,
    required String imagen}) ;

}

class ServiciosApiProviderImpl extends ServiciosApiProvider {

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

  @override
  Future<bool> registrarEvento({required String tipoEvento, required String descripcion, required String imagen}) async {
    try {
      String segmento="polco/index.php";

      Map<String, String>? body = {
        "opc" :"add-evento",
        "modulo" :"ddced13c854fb2c03d6e01ce5bfd7e08",
        "tipoEvento" :tipoEvento,
        "descripcion" : descripcion,
        "imagen" : imagen
      };


      String json = await UrlApiProvider.post(segmento: segmento,body: body);


      UcpReportaEventoModel resul=  ucpReportaEventoModelFromJson(json);


      return  resul.upcReportaEvento.msj=="true"?true:false;
    } catch (e) {
      throw ExceptionHelper.captureError(e);
    }
  }




}
