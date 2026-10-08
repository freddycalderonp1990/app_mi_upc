part of '../bindings.dart';

class MenuPrincipalBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => MenuPrincipalController(), fenix: true);
    Get.lazyPut<MenuPrincipalController>(() => MenuPrincipalController(), fenix: true);

  }

}