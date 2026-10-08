part of '../bindings.dart';

class RegistroUsuarioBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => RegistroUsuarioController(), fenix: true);
    Get.lazyPut<GoogleAuthService>(() => GoogleAuthService(), fenix: true);

  }
}