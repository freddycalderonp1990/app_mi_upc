part of '../../domain_repositories.dart';

abstract class AlertaViolenciaRepository {
  Future<List<Permiso>>consultaPermisosPolicia(int idGenPersona) ;
  Future <DinAlertaApp> registrarEvento({
  required int idGenPersona,
  required int idDinCatalogosApp,
  required double latitud,
  required double longitud,
  required String observacion,
  required String imagenAlerta,
  required int usuario,
  required String ip });

  Future<List<Catalogo>>consultaCatalogos(int din_idDinCatalogosApp);

  Future<List<ListaAlerta>>consultaListaAlertasUsuario(int idGenPersona);

  Future <DinUsuarioTurnosApp> inicioServicio({
    required int idDinUsuariosApp,
    required double latitud,
    required double longitud,
    required String token,
    required String ip });


  Future<ActualizaAlertaViolencia>actualizaAlertasUsuario({
    required int idDinAlertaApp,
    required int idDinTurnosUsuariosAppAntedio,
    required int idDinCatalogosAppAntendio,
    required String observacionAntendio,
    required String estadoAlerta,
    required String ip });

  Future<ActualizaAlertaViolencia>actualizaTokenUsuario({
    required int idDinUsuariosApp,
    required String tokenNotificacion
 });
}