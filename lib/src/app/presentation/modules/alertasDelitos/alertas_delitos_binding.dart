part of '../bindings.dart';

class AlertasDelitosBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AlertasDelitosController>(
          () => AlertasDelitosController(),
      fenix: true,
    );
  }
}
