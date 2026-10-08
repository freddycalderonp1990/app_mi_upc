import '../entities/evento_entity.dart';
import '../repositories/domain_repositories.dart';

class CrearEventoUseCase {
  final AlertasDelitosRepository repository;

  CrearEventoUseCase(this.repository);

  Future<EventoEntity> call(EventoEntity evento) {
    return repository.crearEvento(evento);
  }
}
