part of '../providers_impl.dart';

const _PREF_TOKEN = 'MI_UPC_TOKEN';
const _PREF_USUARIO = 'MI_UPC_USER';

const _PREF_MAIL = 'MI_UPC_MAIL';
const _PREF_ACUERDO = 'MI_UPC_ACUERDO';

const _PREF_PASS = 'MI_UPC_PASS';

const _PREF_APP_INICIAL =
    'MI_UPC_APP_INICIAL'; // sirve para controlar si el usuario recien instalo la aplicacion y mostrarle directamente el login
const _PREF_TIENE_HUELLA = 'MI_UPC_TIENE_HUELLA';
const _PREF_USER_NAME = 'MI_UPC_USER_NAME';
const _PREF_THEME = 'MI_UPC_THEME_DARK';
const _PREF_CONTADOR_FALLIDO =
    'MI_UPC_CONTADOR_FALLIDO'; //Cuando el usuario a cambiado la clave y al precionar la huella por segunda  vez y no ingresa tiene que reiniciarse
//para que se loguee con su nueva cuenta

class MiUpcLocalStoreProviderImpl extends MiUpcLocalStorageRepository {
  @override
  Future<void> clearAllData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  @override
  Future<String> getDatosAcuerdo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_PREF_ACUERDO) ?? '';
  }

  @override
  Future<bool> setDatosAcuerdo(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_PREF_ACUERDO, value);
    return true;
  }

  @override
  Future<String> getDatosMail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_PREF_MAIL) ?? '';
  }

  @override
  Future<String> getDatosUsuario() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_PREF_USUARIO) ?? '';
  }

  @override
  Future<bool> setDatosMail(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_PREF_MAIL, value);
    return true;
  }

  @override
  Future<bool> setDatosUsuario(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_PREF_USUARIO, value);
    return true;
  }
}
