part of '../providers_impl.dart';

const _PREF_USUARIO = 'MI_UPC_USER';
const _PREF_MAIL = 'MI_UPC_MAIL';
const _PREF_ACUERDO = 'MI_UPC_ACUERDO';

class MiUpcLocalStoreProviderImpl extends MiUpcLocalStorageRepository {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  @override
  Future<void> clearAllData() async => await _storage.deleteAll();

  @override
  Future<String> getDatosAcuerdo() async => await _storage.read(key: _PREF_ACUERDO) ?? '';

  @override
  Future<bool> setDatosAcuerdo(String value) async {
    if (value.isEmpty) {
      await _storage.delete(key: _PREF_ACUERDO);
      return true;
    }
    await _storage.write(key: _PREF_ACUERDO, value: value);
    return true;
  }

  @override
  Future<String> getDatosMail() async => await _storage.read(key: _PREF_MAIL) ?? '';

  @override
  Future<String> getDatosUsuario() async => await _storage.read(key: _PREF_USUARIO) ?? '';

  @override
  Future<bool> setDatosMail(String value) async {
    if (value.isEmpty) {
      await _storage.delete(key: _PREF_MAIL);
      return true;
    }
    await _storage.write(key: _PREF_MAIL, value: value);
    return true;
  }

  @override
  Future<bool> setDatosUsuario(String value) async {
    if (value.isEmpty) {
      await _storage.delete(key: _PREF_USUARIO);
      return true;
    }
    await _storage.write(key: _PREF_USUARIO, value: value);
    return true;
  }
}