

part  of '../bindings.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    //Inyeccion de dependencias
    Get.lazyPut(() => SplashControllerMiUpc(), fenix: true);


  }
}
