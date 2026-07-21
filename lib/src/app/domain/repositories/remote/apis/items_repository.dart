part of '../../domain_repositories.dart';

abstract class MiUpcItemsRepository {
  Future<List<Item>> buscaDatosItem(int id);
}
