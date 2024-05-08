import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import '../app/presentation/gps/gps_impl_helper.dart';

import 'data/providers/providers_impl.dart';
import 'data/repository/data_repositories.dart';
import 'domain/repositories/domain_repositories.dart';

class DependencyInjectionMiUpc extends Bindings {
  static ini() {
    Get.lazyPut<LocalStorageRepository>(() => LocalStoreProviderImpl(),
        fenix: true);
    Get.lazyPut<LocalStoreProviderImpl>(() => LocalStoreProviderImpl(),
        fenix: true);
    Get.lazyPut<LocalStoreImpl>(() => LocalStoreImpl(), fenix: true);
    Get.lazyPut<ModulosApiImpl>(() => ModulosApiImpl(ModulosApiProviderImpl()),
        fenix: true);
    Get.lazyPut<ServiciosApiImpl>(
        () => ServiciosApiImpl(ServiciosApiProviderImpl()),
        fenix: true);
    Get.lazyPut<ItemsApiImpl>(() => ItemsApiImpl(ItemsApiProviderImpl()),
        fenix: true);
    Get.lazyPut<MapaUpcApiImpl>(() => MapaUpcApiImpl(MapaUpcApiProviderImpl()),
        fenix: true);
    Get.lazyPut<RegistroUsuarioApiImpl>(
        () => RegistroUsuarioApiImpl(RegistroUsuarioApiProviderImpl()),
        fenix: true);
    Get.put(GpsController());
  }

  @override
  void dependencies() {
    ini();
  }
}
