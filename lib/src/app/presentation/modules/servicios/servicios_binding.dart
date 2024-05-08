part of '../bindings.dart';

class ServiciosBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ServiciosController(), fenix: true);

  }

}