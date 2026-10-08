part of '../controllers.dart';

class SplashControllerMiUpc extends GetxController {


// ...


  @override
  void onInit() {
    _cargarPantallaLogin_InicioRapido();
    _init();
    // TODO: el contolloler se ha creado pero la vista no se ha renderizado
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: Donde la vista ya se presento

  }

  _init() async {

    print(Get.deviceLocale.toString());
  }

  _cargarPantallaLogin_InicioRapido() async {
    await Future.delayed(const Duration(seconds: 2)).then((_) {
    });
      Get.offAllNamed(AppRoutesMiUpc.MENU);
  }
}
