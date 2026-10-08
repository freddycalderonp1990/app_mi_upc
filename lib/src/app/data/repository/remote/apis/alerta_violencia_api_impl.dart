part of '../../data_repositories.dart';
class AlertaViolenciaApiImpl extends AlertaViolenciaRepository {
  final AlertaViolenciaApiProviderImpl   alertaViolenciaApiProviderImpl ;
  AlertaViolenciaApiImpl( {required this.alertaViolenciaApiProviderImpl});

  @override
  Future<List<Permiso>> consultaPermisosPolicia(int idGenPersona) async{
    try {
      return  await alertaViolenciaApiProviderImpl.consultaPermisosPolicia(idGenPersona);
    }  catch (e){
      throw ExceptionHelper.captureError('No tiene Acceso a Internet');
    }
  }

  @override
  Future<DinAlertaApp> registrarEvento({required int idGenPersona, required int idDinCatalogosApp, required double latitud,
    required double longitud, required String observacion, required String imagenAlerta, required int usuario, required String ip}) async{
    try {
      return  await alertaViolenciaApiProviderImpl.registrarEvento(idGenPersona: idGenPersona,
          idDinCatalogosApp: idDinCatalogosApp, latitud: latitud, longitud: longitud,
          observacion: observacion, imagenAlerta: imagenAlerta, usuario: usuario, ip: ip);
    }  catch (e){
      throw ExceptionHelper.captureError('No tiene Acceso a Internet');
    }
  }

  @override
  Future<List<Catalogo>> consultaCatalogos(int din_idDinCatalogosApp) async{
    try {
      return  await alertaViolenciaApiProviderImpl.consultaCatalogos(din_idDinCatalogosApp);
    }  catch (e){
      throw ExceptionHelper.captureError('No tiene Acceso a Internet');
    }
  }

  @override
  Future<List<ListaAlerta>> consultaListaAlertasUsuario(int idGenPersona) async{
    try {
      return  await alertaViolenciaApiProviderImpl.consultaListaAlertasUsuario(idGenPersona);
    }  catch (e){
      throw ExceptionHelper.captureError('No tiene Acceso a Internet');
    }
  }

  @override
  Future<ActualizaAlertaViolencia> actualizaAlertasUsuario({required int idDinAlertaApp,
    required int idDinTurnosUsuariosAppAntedio,
    required int idDinCatalogosAppAntendio, required String observacionAntendio,
    required String estadoAlerta, required String ip}) async{
    try {
      return  await alertaViolenciaApiProviderImpl.actualizaAlertasUsuario(idDinAlertaApp: idDinAlertaApp, idDinTurnosUsuariosAppAntedio: idDinTurnosUsuariosAppAntedio,
          idDinCatalogosAppAntendio: idDinCatalogosAppAntendio, observacionAntendio: observacionAntendio, estadoAlerta: estadoAlerta, ip: ip);
    }  catch (e){
      throw ExceptionHelper.captureError('No tiene Acceso a Internet');
    }
  }

  @override
  Future<DinUsuarioTurnosApp> inicioServicio({required int idDinUsuariosApp, required double latitud,
    required double longitud, required String token, required String ip}) async{
    try {
      return  await alertaViolenciaApiProviderImpl.inicioServicio(idDinUsuariosApp: idDinUsuariosApp,
          latitud: latitud, longitud: longitud, token: token, ip: ip);
    }  catch (e){
      throw ExceptionHelper.captureError('No tiene Acceso a Internet');
    }
  }

  @override
  Future<ActualizaAlertaViolencia> actualizaTokenUsuario({required int idDinUsuariosApp, required String tokenNotificacion}) async{
    try {
      return  await alertaViolenciaApiProviderImpl.actualizaTokenUsuario(idDinUsuariosApp: idDinUsuariosApp, tokenNotificacion:tokenNotificacion);
    }  catch (e){
      throw ExceptionHelper.captureError('No tiene Acceso a Internet');
    }
  }



}


