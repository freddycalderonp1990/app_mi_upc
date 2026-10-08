part of '../bindings.dart';

class VehiculosBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<VehiculosController>(() => VehiculosController(), fenix: true);

  }

}