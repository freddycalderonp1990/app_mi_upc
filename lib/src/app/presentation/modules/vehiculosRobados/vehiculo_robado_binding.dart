part of '../bindings.dart';

class VehiculoRobadoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VehiculoRobadoController>(
      () => VehiculoRobadoController(VehiculoRobadoLocalRepository()),
    );
  }
}
