part of '../../domain_repositories.dart';

abstract class ModulosRepository {
  Future<List<Modulo>> buscaListaModulos();
  Future<DgoUsuariosAlertaApp>buscaPermisoBoton({required int idGenPersona,required String nomApp});
}