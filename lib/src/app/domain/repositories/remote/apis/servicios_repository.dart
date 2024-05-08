part of '../../domain_repositories.dart';

abstract class ServiciosRepository {
  Future<List<Servicio>> buscaListaServicios(int id) ;

}