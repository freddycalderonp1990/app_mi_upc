part of '../providers_impl.dart';

const _PREF_TOKEN = 'TOKEN';
const _PREF_USUARIO = 'USER';
const _PREF_MAIL = 'MAIL';
const _PREF_ACUERDO = 'ACUERDO';
const _PREF_ID_USER = 'IDUSER';
const _PREF_ITEMS = 'ITEMS';
const _PREF_TELEFONO = 'TELEFONO';
const _PREF_FOTO = 'FOTO';
const _PREF_LIST_MODULOS = 'LIST_MODULO';
const _PREF_LIST_SERVICIOS = 'LIST_SERVICIOS';
const _PREF_LIST_SERVICIOSPOLI = 'LIST_SERVICIOSPOLI';
const _PREF_ITEMSPOLI = 'ITEMSPOLI';
const _PREF_PASS = 'PASS';
const _PREF_APP_INICIAL = 'APP_INICIAL';
const _PREF_TIENE_HUELLA = 'TIENE_HUELLA';
const _PREF_USER_NAME = 'USER_NAME';
const _PREF_THEME = 'THEME_DARK';
const _PREF_CONTADOR_FALLIDO = 'CONTADOR_FALLIDO';

// NUEVAS CLAVES UNIFICADAS
const _PREF_USER_NOMBRE = 'USER_NOMBRE';
const _PREF_USER_APELLIDO1 = 'USER_APELLIDO1';
const _PREF_USER_APELLIDO2 = 'USER_APELLIDO2';
const _PREF_USER_CEDULA = 'USER_CEDULA';
const _PREF_USER_TELEFONO = 'USER_TELEFONO';
const _PREF_USER_CORREO = 'USER_CORREO';
const _PREF_USER_FOTO = 'USER_FOTO';
const _PREF_METODO_REGISTRO = 'METODO_REGISTRO';

class LocalStoreProviderImpl extends LocalStorageRepository {
  @override
  Future<void> clearAllData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  @override
  Future<String> getDatosAcuerdo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_PREF_ACUERDO) ?? '';
  }

  @override
  Future<bool> setDatosAcuerdo(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_PREF_ACUERDO, value);
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
    await prefs.setString(_PREF_MAIL, value);
    await prefs.setString(_PREF_USER_CORREO, value);
    return true;
  }

  @override
  Future<bool> setIdUsuer(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_PREF_ID_USER, value);
    return true;
  }

  @override
  Future<int> getIdUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_PREF_ID_USER) ?? 0;
  }

  @override
  Future<bool> setTelefono(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_PREF_TELEFONO, value);
    await prefs.setString(_PREF_USER_TELEFONO, value);
    return true;
  }

  @override
  Future<String> getTelefono() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_PREF_TELEFONO) ?? "";
  }

  @override
  Future<bool> setDatosUsuario(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_PREF_USUARIO, value);
    return true;
  }

  @override
  Future<Uint8List?> getFoto() async {
    final prefs = await SharedPreferences.getInstance();
    String? base64String =
        prefs.getString(_PREF_FOTO) ?? prefs.getString(_PREF_USER_FOTO);

    if (base64String != null && base64String.isNotEmpty) {
      try {
        return base64Decode(base64String);
      } catch (_) {
        return null;
      }
    }
    return null;
  }

  @override
  Future<void> setFoto(Uint8List imageBytes) async {
    final prefs = await SharedPreferences.getInstance();
    final base64String = base64Encode(imageBytes);
    await prefs.setString(_PREF_FOTO, base64String);
    await prefs.setString(_PREF_USER_FOTO, base64String);
  }

  Future<void> clearFoto() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_PREF_FOTO);
    await prefs.remove(_PREF_USER_FOTO);
  }

  @override
  Future<bool> setDatosListaModulos({required List<Modulo> listModulos}) async {
    Map<String, dynamic> toJson() => {
      "datos": List<dynamic>.from(listModulos.map((x) => x.toJson())),
    };
    String datos = json.encode(toJson());

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_PREF_LIST_MODULOS, datos);
    return true;
  }

  @override
  Future<List<Modulo>> getListModulos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonData = prefs.getString(_PREF_LIST_MODULOS) ?? '';
    if (jsonData.isEmpty) return [];

    Map<String, dynamic> datos = json.decode(jsonData);
    return List<Modulo>.from(datos["datos"].map((x) => Modulo.fromJson(x)));
  }

  @override
  Future<List<Servicio>> getListServicios() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonData = prefs.getString(_PREF_LIST_SERVICIOS) ?? '';
    if (jsonData.isEmpty) return [];

    Map<String, dynamic> datos = json.decode(jsonData);
    return List<Servicio>.from(datos["datos"].map((x) => Servicio.fromJson(x)));
  }

  @override
  Future<bool> setDatosListaServicios({
    required List<Servicio> listServicios,
  }) async {
    Map<String, dynamic> toJson() => {
      "datos": List<dynamic>.from(listServicios.map((x) => x.toJson())),
    };

    String datos = json.encode(toJson());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_PREF_LIST_SERVICIOS, datos);
    return true;
  }

  @override
  Future<List<ItemOffLine>> getListItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonData = prefs.getString(_PREF_ITEMS) ?? '';
    if (jsonData.isEmpty) return [];

    Map<String, dynamic> datos = json.decode(jsonData);
    return List<ItemOffLine>.from(
      datos["datos"].map((x) => ItemOffLine.fromJson(x)),
    );
  }

  @override
  Future<bool> setDatosListaItems({required List<ItemOffLine> listItems}) async {
    Map<String, dynamic> toJson() => {
      "datos": List<dynamic>.from(listItems.map((x) => x.toJson())),
    };

    String datos = json.encode(toJson());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_PREF_ITEMS, datos);
    return true;
  }

  @override
  Future<List<ItemOffLine>> getListItemsPoli() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonData = prefs.getString(_PREF_ITEMSPOLI) ?? '';
    if (jsonData.isEmpty) return [];

    Map<String, dynamic> datos = json.decode(jsonData);
    return List<ItemOffLine>.from(
      datos["datos"].map((x) => ItemOffLine.fromJson(x)),
    );
  }

  @override
  Future<bool> setDatosListaItemsPoli({
    required List<ItemOffLine> listItemsPoli,
  }) async {
    Map<String, dynamic> toJson() => {
      "datos": List<dynamic>.from(listItemsPoli.map((x) => x.toJson())),
    };

    String datos = json.encode(toJson());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_PREF_ITEMSPOLI, datos);
    return true;
  }

  @override
  Future<bool> setDatosListaServiciosPoli({
    required List<Servicio> listServiciosPoli,
  }) async {
    Map<String, dynamic> toJson() => {
      "datos": List<dynamic>.from(listServiciosPoli.map((x) => x.toJson())),
    };

    String datos = json.encode(toJson());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_PREF_LIST_SERVICIOSPOLI, datos);
    return true;
  }

  @override
  Future<List<Servicio>> getListServiciosPoli() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonData = prefs.getString(_PREF_LIST_SERVICIOSPOLI) ?? '';
    if (jsonData.isEmpty) return [];

    Map<String, dynamic> datos = json.decode(jsonData);
    return List<Servicio>.from(datos["datos"].map((x) => Servicio.fromJson(x)));
  }

  @override
  Future<void> setDatosUsuarioCompleto({
    required String nombre,
    required String apellido1,
    required String apellido2,
    required String cedula,
    required String telefono,
    required String correo,
    Uint8List? foto,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    final nombreCompleto =
    '$nombre $apellido1 $apellido2'.replaceAll(RegExp(r'\s+'), ' ').trim();

    await prefs.setString(_PREF_USER_NOMBRE, nombre);
    await prefs.setString(_PREF_USER_APELLIDO1, apellido1);
    await prefs.setString(_PREF_USER_APELLIDO2, apellido2);
    await prefs.setString(_PREF_USER_CEDULA, cedula);
    await prefs.setString(_PREF_USER_TELEFONO, telefono);
    await prefs.setString(_PREF_USER_CORREO, correo);

    await prefs.setString(_PREF_USER_NAME, nombreCompleto);
    await prefs.setString(_PREF_TELEFONO, telefono);
    await prefs.setString(_PREF_MAIL, correo);

    if (foto != null) {
      final fotoBase64 = base64Encode(foto);
      await prefs.setString(_PREF_USER_FOTO, fotoBase64);
      await prefs.setString(_PREF_FOTO, fotoBase64);
    } else {
      await prefs.remove(_PREF_USER_FOTO);
      await prefs.remove(_PREF_FOTO);
    }
  }

  @override
  Future<Map<String, dynamic>?> getDatosUsuarioCompleto() async {
    final prefs = await SharedPreferences.getInstance();

    final nombre = prefs.getString(_PREF_USER_NOMBRE) ?? '';
    final apellido1 = prefs.getString(_PREF_USER_APELLIDO1) ?? '';
    final apellido2 = prefs.getString(_PREF_USER_APELLIDO2) ?? '';
    final cedula = prefs.getString(_PREF_USER_CEDULA) ?? '';
    final telefono = prefs.getString(_PREF_USER_TELEFONO) ?? '';
    final correo = prefs.getString(_PREF_USER_CORREO) ?? '';
    final foto = prefs.getString(_PREF_USER_FOTO) ?? '';

    final bool tieneDatos = nombre.isNotEmpty ||
        apellido1.isNotEmpty ||
        apellido2.isNotEmpty ||
        cedula.isNotEmpty ||
        telefono.isNotEmpty ||
        correo.isNotEmpty ||
        foto.isNotEmpty;

    if (!tieneDatos) return null;

    return {
      'nombre': nombre,
      'apellido1': apellido1,
      'apellido2': apellido2,
      'cedula': cedula,
      'telefono': telefono,
      'correo': correo,
      'foto': foto,
    };
  }

  Future<void> setMetodoRegistro(String metodo) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_PREF_METODO_REGISTRO, metodo);
  }

  Future<String?> getMetodoRegistro() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_PREF_METODO_REGISTRO);
  }

  Future<void> clearMetodoRegistro() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_PREF_METODO_REGISTRO);
  }
  Future<String> getUserName() async {
    final prefs = await SharedPreferences.getInstance();

    final userNameDirecto = prefs.getString('USER_NAME') ?? '';
    if (userNameDirecto.trim().isNotEmpty) {
      return userNameDirecto.trim();
    }

    final nombre = prefs.getString('USER_NOMBRE') ?? '';
    final apellido1 = prefs.getString('USER_APELLIDO1') ?? '';
    final apellido2 = prefs.getString('USER_APELLIDO2') ?? '';

    return '$nombre $apellido1 $apellido2'
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }
}