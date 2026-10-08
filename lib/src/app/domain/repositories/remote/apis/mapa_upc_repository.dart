part of '../../domain_repositories.dart';
abstract class MapaUpcRepository {
  Future<List<Upc>> buscaDatosUpc({required double la,required double lo}) ;

}