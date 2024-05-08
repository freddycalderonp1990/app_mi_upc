part of '../bindings.dart';

class MapaUpcBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => MapaUpcController(), fenix: true);

  }
}