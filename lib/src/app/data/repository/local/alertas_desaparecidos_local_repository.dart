import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/alerta_desaparecido_registro.dart';

class AlertasDesaparecidosLocalRepository {
  static const _storageKey = 'ALERTAS_DESAPARECIDOS_SECURE_V1';
  static const _legacyStorageKey = 'ALERTAS_DESAPARECIDOS_LOCAL';
  static final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  Future<List<AlertaDesaparecidoRegistro>> obtenerTodos() async {
    var source = await _secureStorage.read(key: _storageKey);
    if (source == null) {
      final preferences = await SharedPreferences.getInstance();
      final legacyData = preferences.getString(_legacyStorageKey);
      if (legacyData != null && legacyData.isNotEmpty) {
        _decode(legacyData);
        await _secureStorage.write(key: _storageKey, value: legacyData);
        await preferences.remove(_legacyStorageKey);
        source = legacyData;
      }
    }
    if (source == null || source.isEmpty) return [];
    return _decode(source);
  }

  List<AlertaDesaparecidoRegistro> _decode(String source) {
    final decoded = jsonDecode(source);
    if (decoded is! List) {
      throw const FormatException('Formato de registros locales inválido.');
    }
    return decoded
        .map((item) => AlertaDesaparecidoRegistro.fromJson(
              Map<String, dynamic>.from(item as Map),
            ))
        .toList();
  }

  Future<void> guardarTodos(List<AlertaDesaparecidoRegistro> registros) async {
    await _secureStorage.write(
      key: _storageKey,
      value: jsonEncode(registros.map((item) => item.toJson()).toList()),
    );
  }
}
