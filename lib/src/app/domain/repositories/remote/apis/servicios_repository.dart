part of '../../domain_repositories.dart';

abstract class MiUpcServiciosRepository {
  Future<List<Servicio>> buscaListaServicios(int id);
}
