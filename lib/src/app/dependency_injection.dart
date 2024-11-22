import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';



import 'data/providers/providers_impl.dart';
import 'data/repository/data_repositories.dart';
import 'domain/repositories/domain_repositories.dart';

class DependencyInjectionMiUpc extends Bindings {
  static ini() {
    Get.lazyPut<MiUpcLocalStorageRepository>(
        () => MiUpcLocalStoreProviderImpl(),
        fenix: true);
    Get.lazyPut<MiUpcLocalStoreProviderImpl>(
        () => MiUpcLocalStoreProviderImpl(),
        fenix: true);
    Get.lazyPut<MiUpcLocalStoreImpl>(() => MiUpcLocalStoreImpl(), fenix: true);
    Get.lazyPut<MiUpcModulosApiImpl>(
        () => MiUpcModulosApiImpl(MiUpcModulosApiProviderImpl()),
        fenix: true);
    Get.lazyPut<MiUpcServiciosApiImpl>(
        () => MiUpcServiciosApiImpl(MiUpcServiciosApiProviderImpl()),
        fenix: true);
    Get.lazyPut<MiUpcItemsApiImpl>(
        () => MiUpcItemsApiImpl(MiUpcItemsApiProviderImpl()),
        fenix: true);
    Get.lazyPut<MiUpcMapaUpcApiImpl>(
        () => MiUpcMapaUpcApiImpl(MiUpcMapaUpcApiProviderImpl()),
        fenix: true);
    Get.lazyPut<MiUpcRegistroUsuarioApiImpl>(
        () =>
            MiUpcRegistroUsuarioApiImpl(MiUpcRegistroUsuarioApiProviderImpl()),
        fenix: true);

  }

  @override
  void dependencies() {
    ini();
  }
}
