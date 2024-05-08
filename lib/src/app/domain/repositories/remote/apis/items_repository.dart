part of '../../domain_repositories.dart';

abstract class ItemsRepository {
  Future<List<Item>> buscaDatosItem(int id) ;

}