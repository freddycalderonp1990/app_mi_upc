import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PreferenciasUsuario {
  static final PreferenciasUsuario _instancia = PreferenciasUsuario._internal();

  factory PreferenciasUsuario() => _instancia;

  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  PreferenciasUsuario._internal();

  Future<void> initPrefs() async {}

  Future<String> getIdUsuario() async => await _storage.read(key: 'idUsuario') ?? '0';

  Future<void> setIdUsuario(String value) async => await _storage.write(key: 'idUsuario', value: value);

  Future<String> getIdGenPersona() async => await _storage.read(key: 'idGenPersona') ?? '0';

  Future<void> setIdGenPersona(String value) async => await _storage.write(key: 'idGenPersona', value: value);

  Future<String> getNombreUsuario() async => await _storage.read(key: 'nombreUsuario') ?? '';

  Future<void> setNombreUsuario(String value) async => await _storage.write(key: 'nombreUsuario', value: value);

  Future<String> getCedula() async => await _storage.read(key: 'cedula') ?? '';

  Future<void> setCedula(String value) async => await _storage.write(key: 'cedula', value: value);

  Future<String> getCelular() async => await _storage.read(key: 'celular') ?? '';

  Future<void> setCelular(String value) async => await _storage.write(key: 'celular', value: value);

  Future<String> getNombres() async => await _storage.read(key: 'nombres') ?? '';

  Future<void> setNombres(String value) async => await _storage.write(key: 'nombres', value: value);

  Future<String> getEmail() async => await _storage.read(key: 'email') ?? '';

  Future<void> setEmail(String value) async => await _storage.write(key: 'email', value: value);

  Future<bool> getIsNacional() async => (await _storage.read(key: 'nacional')) == 'SI';

  Future<void> setIsNacional(bool valor) async => await _storage.write(key: 'nacional', value: valor ? 'SI' : 'NO');

  Future<String> getToken1() async => await _storage.read(key: 'token1') ?? '';

  Future<void> setToken1(String value) async {
    if (value.isEmpty) {
      await _storage.delete(key: 'token1');
      return;
    }
    await _storage.write(key: 'token1', value: value);
  }

  Future<String> getToken2() async => await _storage.read(key: 'token2') ?? '';

  Future<void> setToken2(String value) async {
    if (value.isEmpty) {
      await _storage.delete(key: 'token2');
      return;
    }
    await _storage.write(key: 'token2', value: value);
  }

  Future<String> getImei() async => await _storage.read(key: 'imei') ?? '';

  Future<void> setImei(String value) async => await _storage.write(key: 'imei', value: value);

  Future<void> setDatosUser({
    required String idGenPersona,
    required String nombreUser,
    required String cedulaV,
    required String emailV,
    required String nombresV,
    required String celular,
    required String idUsuario,
    required bool isNacional,
    required String imei,
  }) async {
    await setIdGenPersona(idGenPersona);
    await setNombreUsuario(nombreUser);
    await setCedula(cedulaV);
    await setEmail(emailV);
    await setNombres(nombresV);
    await setCelular(celular);
    await setIdUsuario(idUsuario);
    await setIsNacional(isNacional);
    await setImei(imei);
  }

  Future<void> clearDatosUser() async {
    await _storage.delete(key: 'idGenPersona');
    await _storage.delete(key: 'nombreUsuario');
    await _storage.delete(key: 'cedula');
    await _storage.delete(key: 'email');
    await _storage.delete(key: 'nombres');
    await _storage.delete(key: 'celular');
    await _storage.delete(key: 'idUsuario');
    await _storage.delete(key: 'nacional');
    await _storage.delete(key: 'token1');
    await _storage.delete(key: 'token2');
    await _storage.delete(key: 'imei');
  }
}