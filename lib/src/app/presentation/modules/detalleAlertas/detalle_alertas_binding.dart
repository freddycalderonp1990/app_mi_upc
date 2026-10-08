part of '../bindings.dart';

class DetalleAlertasBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => DetalleAlertasController(), fenix: true);

  }

}