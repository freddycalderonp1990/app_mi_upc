import 'package:app_mi_upc/src/app/dependency_injection.dart';
import 'package:app_mi_upc/src/app/presentation/routes/app_pages.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class MiUpc {
  static get getDependencyInjection => DependencyInjectionMiUpc.ini();
  static List<GetPage> get getPages => AppPagesMiUpc.pages;
}
