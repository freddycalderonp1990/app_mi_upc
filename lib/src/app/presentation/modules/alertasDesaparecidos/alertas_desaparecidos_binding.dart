part of '../bindings.dart';

class AlertasDesaparecidosBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AlertasDesaparecidosController>(
      () => AlertasDesaparecidosController(
        AlertasDesaparecidosLocalRepository(),
      ),
    );
  }
}
