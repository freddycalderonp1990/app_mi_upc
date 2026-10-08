part of '../providers_impl.dart';

class AlertaViolenciaApiProviderImpl extends AlertaViolenciaRepository {
  @override
  Future<List<Permiso>> consultaPermisosPolicia(int idGenPersona) async{
    try {
      String segmento="polco/index.php";
      Map<String, dynamic> body = {
        "idGenPersona":idGenPersona,
        "opc":"v1-get-permiso-policia",
        "modulo":"ddced13c854fb2c03d6e01ce5bfd7e08"
      };
      String json = await UrlApiProvider.post(segmento: segmento,body: body);
      return dinUsuarioAppModelFromJson(json).dinUsuarioApp.permisos;
    } catch (e) {
      throw ExceptionHelper.captureError(e);
    }
  }

  @override
  Future <DinAlertaApp> registrarEvento({required int idGenPersona, required int idDinCatalogosApp, required double latitud,
    required double longitud, required String observacion, required String imagenAlerta, required int usuario, required String ip}) async{
    try {
      String segmento="polco/index.php";
      Map<String, dynamic> body = {
        "idGenPersona":idGenPersona,
        "idDinCatalogosApp":idDinCatalogosApp,
        "latitud":latitud,
        "longitud":longitud,
        "observacion":observacion,
        "imagenAlerta":imagenAlerta,
        "usuario":usuario,
        "ip":ip,
        "opc":"v1-post-evento-violencia",
        "modulo":"ddced13c854fb2c03d6e01ce5bfd7e08"
      };
      String json = await UrlApiProvider.post(segmento: segmento,body: body);
      return dinAlertaAppModelFromJson(json).dinAlertaApp;
    } catch (e) {
      throw ExceptionHelper.captureError(e);
    }
  }

  @override
  Future<List<Catalogo>> consultaCatalogos(int din_idDinCatalogosApp) async{
    try {
      String segmento="polco/index.php";
      Map<String, dynamic> body = {
        "din_idDinCatalogosApp":din_idDinCatalogosApp,
        "opc":"v1-get-datos-catalogos",
        "modulo":"ddced13c854fb2c03d6e01ce5bfd7e08"
      };
      String json = await UrlApiProvider.post(segmento: segmento,body: body);
      return dinCatalogosAppModelFromJson(json).dinCatalogosApp.catalogos;
    } catch (e) {
      throw ExceptionHelper.captureError(e);
    }
  }

  @override
  Future<List<ListaAlerta>> consultaListaAlertasUsuario(int idGenPersona) async{
    try {
      String segmento="polco/index.php";
      Map<String, dynamic> body = {
        "idGenPersona":idGenPersona,
        "opc":"v1-get-alertas-violencia",
        "modulo":"ddced13c854fb2c03d6e01ce5bfd7e08"
      };
      String json = await UrlApiProvider.post(segmento: segmento,body: body);
      return dinListaAlertasModelFromJson(json).dinListaAlertaApp.listaAlertas;
    } catch (e) {
      throw ExceptionHelper.captureError(e);
    }
  }

  @override
  Future<ActualizaAlertaViolencia> actualizaAlertasUsuario({required int idDinAlertaApp, required int idDinTurnosUsuariosAppAntedio,
    required int idDinCatalogosAppAntendio, required String observacionAntendio, required String estadoAlerta,
    required String ip}) async{
    try {
      String segmento="polco/index.php";
      Map<String, dynamic> body = {
        "idDinAlertaApp":idDinAlertaApp,
        "idDinTurnosUsuariosAppAntedio":idDinTurnosUsuariosAppAntedio,
        "idDinCatalogosAppAntendio":idDinCatalogosAppAntendio,
        "observacionAntendio":observacionAntendio,
        "estadoAlerta":estadoAlerta,
        "ip":ip,
        "opc":"v1-put-verifica-alerta",
        "modulo":"ddced13c854fb2c03d6e01ce5bfd7e08"
      };
      String json = await UrlApiProvider.put(segmento: segmento,body: body);
      return dinActualizaAlertaModelFromJson(json).actualizaAlertaViolencia;
    } catch (e) {
      throw ExceptionHelper.captureError(e);
    }
  }

  @override
  Future<DinUsuarioTurnosApp> inicioServicio({required int idDinUsuariosApp, required double latitud,
    required double longitud, required String token, required String ip}) async{
    try {
      String segmento="polco/index.php";
      Map<String, dynamic> body = {
        "idDinUsuariosApp":idDinUsuariosApp,
        "latitud":latitud,
        "longitud":longitud,
        "token":token,
        "ip":ip,
        "opc":"v1-post-servicio",
        "modulo":"ddced13c854fb2c03d6e01ce5bfd7e08"
      };
      String json = await UrlApiProvider.post(segmento: segmento,body: body);
      return dinTurnosUsuariosModelFromJson(json).dinUsuarioTurnosApp;
    } catch (e) {
      throw ExceptionHelper.captureError(e);
    }
  }

  @override
  Future<ActualizaAlertaViolencia> actualizaTokenUsuario({required int idDinUsuariosApp, required String tokenNotificacion}) async{
    try {
      String segmento="polco/index.php";
      Map<String, dynamic> body = {
        "idDinUsuariosApp":idDinUsuariosApp,
        "tokenNotificacion":tokenNotificacion,
        "opc":"v1-put-token-turno-policia",
        "modulo":"ddced13c854fb2c03d6e01ce5bfd7e08"
      };
      String json = await UrlApiProvider.put(segmento: segmento,body: body);
      return dinActualizaAlertaModelFromJson(json).actualizaAlertaViolencia;
    } catch (e) {
      throw ExceptionHelper.captureError(e);
    }
  }






}
