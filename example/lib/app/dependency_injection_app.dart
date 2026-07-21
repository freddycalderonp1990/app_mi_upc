import 'package:app_mi_upc/app_mi_upc.dart';
import 'package:get/get.dart';

class DependencyInjectionApp extends Bindings {
  static ini() {
      DependencyInjectionMiUpc.ini();


  }

  @override
  void dependencies() {
    print('DependencyInjection');
    ini();
  }
}
