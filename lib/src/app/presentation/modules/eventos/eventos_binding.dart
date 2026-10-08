part of '../bindings.dart';

class EventosBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<EventosController>(() => EventosController(), fenix: true);

  }

}