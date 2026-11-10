import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/vehiculo_robado_registro.dart';

class VehiculoRobadoLocalRepository {
  static const _storageKey = 'ALERTAS_VEHICULOS_ROBADOS_SECURE_V1';
  static const _legacyStorageKey = 'ALERTAS_VEHICULOS_ROBADOS_LOCAL';
  static final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  Future<List<VehiculoRobadoRegistro>> obtenerTodos() async {
    var encoded = await _secureStorage.read(key: _storageKey);
    if (encoded == null) {
      final preferences = await SharedPreferences.getInstance();
      final legacyData = preferences.getString(_legacyStorageKey);
      if (legacyData != null && legacyData.isNotEmpty) {
        // Migrar los registros existentes una sola vez, sin perderlos al actualizar.
        VehiculoRobadoRegistro.decodeList(legacyData);
        await _secureStorage.write(key: _storageKey, value: legacyData);
        await preferences.remove(_legacyStorageKey);
        encoded = legacyData;
      }
    }
    if (encoded == null || encoded.isEmpty) return [];
    return VehiculoRobadoRegistro.decodeList(encoded);
  }

  Future<void> guardarTodos(List<VehiculoRobadoRegistro> items) async {
    await _secureStorage.write(
      key: _storageKey,
      value: VehiculoRobadoRegistro.encodeList(items),
    );
  }
}
