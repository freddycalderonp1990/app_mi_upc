part of '../../domain_repositories.dart';

abstract class AlertasDelitosRepository {
  Future<List<CatalogoModel>> consultaCatalogos(int id);
  Future<EventoEntity> crearEvento(EventoEntity evento);
}