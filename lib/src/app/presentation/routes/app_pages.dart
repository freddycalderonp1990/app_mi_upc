import 'package:flutter/animation.dart';
import 'package:get/get.dart';

import '../modules/bindings.dart';
import '../modules/pages.dart';
import '../routes/app_routes.dart';

class AppPagesMiUpc {
  static final _transition = Transition.rightToLeft;
  static final _transitionDuration = const Duration(milliseconds: 400);
  static final _curve = Curves.fastOutSlowIn;

  static GetPage getPageConfig(
      {required String name,
      required GetPageBuilder page,
      required Bindings binding}) {
    return GetPage(
        transition: _transition,
        transitionDuration: _transitionDuration,
        curve: _curve,
        name: name,
        page: page,
        binding: binding);
  }

  static final List<GetPage> pages = [
    getPageConfig(
        name: AppRoutesMiUpc.SPLASH,
        page: () => SplashPage(),
        binding: SplashBinding()),
    getPageConfig(
        name: AppRoutesMiUpc.SERVICIOS,
        page: () => ServiciosPage(),
        binding: ServiciosBinding()),
    getPageConfig(
        name: AppRoutesMiUpc.ITEMSSERVICIOS,
        page: () => MenuPrincipalPage(),
        binding: MenuPrincipalBinding()),
    getPageConfig(
        name: AppRoutesMiUpc.ACUERDO,
        page: () => AcuerdoPage(),
        binding: AcuerdoBinding()),
    getPageConfig(
        name: AppRoutesMiUpc.ITEMSTIPS,
        page: () => MenuPrincipalPage(),
        binding: MenuPrincipalBinding()),
    getPageConfig(
        name: AppRoutesMiUpc.MENU,
        page: () => MenuPrincipalPage(),
        binding: MenuPrincipalBinding()),
    getPageConfig(
        name: AppRoutesMiUpc.MAPAUPC,
        page: () => MapaUpcPage(),
        binding: MapaUpcBinding()),
    getPageConfig(
        name: AppRoutesMiUpc.REGISTROUSUARIO,
        page: () => RegistroUsuarioPage(),
        binding: RegistroUsuarioBinding()),
  ];
}
