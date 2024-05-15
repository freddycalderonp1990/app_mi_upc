part of '../bindings.dart';

class MiUpcSplashBinding extends Bindings {
  @override
  void dependencies() {
    //Inyeccion de dependencias
    Get.lazyPut(() => MiUpcSplashController(), fenix: true);
  }
}
