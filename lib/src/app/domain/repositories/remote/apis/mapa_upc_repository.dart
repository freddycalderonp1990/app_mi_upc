part of '../../domain_repositories.dart';

abstract class MiUpcMapaUpcRepository {
  Future<List<Upc>> buscaDatosUpc({required double la, required double lo});
}
