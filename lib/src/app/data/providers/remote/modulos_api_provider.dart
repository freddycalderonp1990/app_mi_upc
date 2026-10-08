part of '../providers_impl.dart';

abstract class ModulosApiProvider {
  Future<List<Modulo>> buscaListaModulos() ;
  Future<DgoUsuariosAlertaApp>buscaPermisoBoton({required int idGenPersona,required String nomApp});

}

class ModulosApiProviderImpl extends ModulosApiProvider {

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

  @override
  Future<DgoUsuariosAlertaApp> buscaPermisoBoton({required int idGenPersona, required String nomApp}) async{
    try {
      String segmento="polco/index.php";
      Map<String, dynamic> body = {
        "idGenPersona":idGenPersona,
        "nomApp":nomApp,
        "opc":"v1-get-permiso-boton",
        "modulo":"ddced13c854fb2c03d6e01ce5bfd7e08"
      };
      String json = await UrlApiProvider.post(segmento: segmento,body: body);
      return permisoBotonModelFromJson(json).dgoUsuariosAlertaApp;
    } catch (e) {
      throw ExceptionHelper.captureError(e);
    }
  }

}
