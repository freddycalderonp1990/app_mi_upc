part of '../../domain_repositories.dart';

abstract class ServiciosRepository {
  Future<List<Servicio>> buscaListaServicios(int id) ;

  Future<bool> registrarEvento({required String tipoEvento,
    required String descripcion,
    required String imagen}) ;

}