import 'package:flutter/animation.dart';
import 'package:get/get.dart';

import '../modules/bindings.dart';
import '../modules/pages.dart';
import '../routes/app_routes.dart';

class AppRoutesMiUpc {
  static final _transition = Transition.rightToLeft;
  static final _transitionDuration = const Duration(milliseconds: 400);
  static final _curve = Curves.fastOutSlowIn;

  static GetPage getPageConfig({required String name,required GetPageBuilder page, required  Bindings binding} ) {
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
        name: AppRoutes.SPLASH,
        page: () => SplashPage(),
        binding: SplashBinding()),

    getPageConfig(
        name: AppRoutes.SERVICIOS,
        page: () => ServiciosPage(),
        binding: ServiciosBinding()),
    getPageConfig(
        name: AppRoutes.ITEMSSERVICIOS,
        page: () => MenuPrincipalPage(),
        binding: MenuPrincipalBinding()),
    getPageConfig(
        name: AppRoutes.ACUERDO,
        page: () => AcuerdoPage(),
        binding: AcuerdoBinding()),
    getPageConfig(
        name: AppRoutes.ITEMSTIPS,
        page: () => MenuPrincipalPage(),
        binding: MenuPrincipalBinding()),
    getPageConfig(
        name: AppRoutes.MENU,
        page: () => MenuPrincipalPage(),
        binding: MenuPrincipalBinding()),
    getPageConfig(
        name: AppRoutes.MAPAUPC,
        page: () => MapaUpcPage(),
        binding: MapaUpcBinding()),
    getPageConfig(
        name: AppRoutes.REGISTROUSUARIO,
        page: () => RegistroUsuarioPage(),
        binding: RegistroUsuarioBinding()),

    getPageConfig(
        name: AppRoutes.REGISTRAR_EVENTO,
        page: () => EventosPage(),
        binding: EventosBinding()),
    getPageConfig(
        name: AppRoutes.CONSULTAVEHICULO,
        page: () => VehiculosPage(),
        binding: VehiculosBinding()),
    getPageConfig(
        name: AppRoutes.DETALLEALERTAS,
        page: () => DetalleAlertasPage(),
        binding: DetalleAlertasBinding()),
    getPageConfig(
        name: AppRoutes.ALERTASDELITOS,
        page: () => AlertasDelitosPage(),
        binding: AlertasDelitosBinding()),
  ];
}
