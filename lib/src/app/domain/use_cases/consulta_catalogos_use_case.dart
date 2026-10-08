import '../../data/models/models.dart';
import '../repositories/domain_repositories.dart';

class ConsultaCatalogosUseCase {
  final AlertasDelitosRepository repository;

  ConsultaCatalogosUseCase(this.repository);

  Future<List<CatalogoModel>> call(int idVariable) {
    return repository.consultaCatalogos(idVariable);
  }
}