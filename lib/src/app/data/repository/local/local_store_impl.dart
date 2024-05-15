part of '../data_repositories.dart';

class MiUpcLocalStoreImpl extends MiUpcLocalStorageRepository {
  final MiUpcLocalStoreProviderImpl _localStoreProviderImpl = Get.find();

  @override
  Future<String> getDatosAcuerdo() {
    return _localStoreProviderImpl.getDatosAcuerdo();
  }

  @override
  Future<bool> setDatosAcuerdo(String value) {
    return _localStoreProviderImpl.setDatosAcuerdo(value);
  }

  @override
  Future<String> getDatosMail() {
    return _localStoreProviderImpl.getDatosMail();
  }

  @override
  Future<String> getDatosUsuario() {
    return _localStoreProviderImpl.getDatosUsuario();
  }

  @override
  Future<bool> setDatosMail(String value) {
    return _localStoreProviderImpl.setDatosMail(value);
  }

  @override
  Future<bool> setDatosUsuario(String value) {
    return _localStoreProviderImpl.setDatosUsuario(value);
  }
}
