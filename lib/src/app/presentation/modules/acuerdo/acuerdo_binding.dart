part of '../bindings.dart';

class AcuerdoBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => AcuerdoController(), fenix: true);

  }

}