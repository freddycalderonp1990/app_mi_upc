part of '../data_repositories.dart';

class LocalStoreImpl extends LocalStorageRepository {
  final LocalStoreProviderImpl _localStoreProviderImpl = Get.find();

  @override
  Future<String> getDatosAcuerdo() => _localStoreProviderImpl.getDatosAcuerdo();

  @override
  Future<bool> setDatosAcuerdo(String value) =>
      _localStoreProviderImpl.setDatosAcuerdo(value);

  @override
  Future<String> getDatosMail() => _localStoreProviderImpl.getDatosMail();

  @override
  Future<String> getDatosUsuario() => _localStoreProviderImpl.getDatosUsuario();

  @override
  Future<bool> setDatosMail(String value) =>
      _localStoreProviderImpl.setDatosMail(value);

  @override
  Future<bool> setDatosUsuario(String value) =>
      _localStoreProviderImpl.setDatosUsuario(value);

  @override
  Future<bool> setIdUser(int value) => _localStoreProviderImpl.setIdUsuer(value);

  @override
  Future<int> getIdUser() => _localStoreProviderImpl.getIdUser();

  @override
  Future<bool> setTelefono(String value) =>
      _localStoreProviderImpl.setTelefono(value);

  @override
  Future<String> getTelefono() => _localStoreProviderImpl.getTelefono();

  @override
  Future<List<Modulo>> getListModulos() =>
      _localStoreProviderImpl.getListModulos();

  @override
  Future<bool> setDatosListaModulos({required List<Modulo> listModulos}) =>
      _localStoreProviderImpl.setDatosListaModulos(listModulos: listModulos);

  @override
  Future<List<Servicio>> getListServicios() =>
      _localStoreProviderImpl.getListServicios();

  @override
  Future<bool> setDatosListaServicios({required List<Servicio> listServicios}) =>
      _localStoreProviderImpl.setDatosListaServicios(
        listServicios: listServicios,
      );

  @override
  Future<List<ItemOffLine>> getListItems() =>
      _localStoreProviderImpl.getListItems();

  @override
  Future<bool> setDatosListaItems({required List<ItemOffLine> listItems}) =>
      _localStoreProviderImpl.setDatosListaItems(listItems: listItems);

  @override
  Future<List<ItemOffLine>> getListItemsPoli() =>
      _localStoreProviderImpl.getListItemsPoli();

  @override
  Future<List<Servicio>> getListServiciosPoli() =>
      _localStoreProviderImpl.getListServiciosPoli();

  @override
  Future<bool> setDatosListaItemsPoli({required List<ItemOffLine> listItemsPoli}) =>
      _localStoreProviderImpl.setDatosListaItemsPoli(
        listItemsPoli: listItemsPoli,
      );

  @override
  Future<bool> setDatosListaServiciosPoli({
    required List<Servicio> listServiciosPoli,
  }) =>
      _localStoreProviderImpl.setDatosListaServiciosPoli(
        listServiciosPoli: listServiciosPoli,
      );

  @override
  Future<Uint8List?> getFoto() => _localStoreProviderImpl.getFoto();

  @override
  Future<void> setFoto(Uint8List imageBytes) =>
      _localStoreProviderImpl.setFoto(imageBytes);

  Future<void> clearFoto() => _localStoreProviderImpl.clearFoto();

  @override
  Future<void> setDatosUsuarioCompleto({
    required String nombre,
    required String apellido1,
    required String apellido2,
    required String cedula,
    required String telefono,
    required String correo,
    dynamic foto,
  }) async {
    Uint8List? fotoBytes;

    if (foto is Uint8List) {
      fotoBytes = foto;
    } else if (foto is String && foto.isNotEmpty) {
      try {
        fotoBytes = base64Decode(foto);
      } catch (_) {}
    }

    await _localStoreProviderImpl.setDatosUsuarioCompleto(
      nombre: nombre,
      apellido1: apellido1,
      apellido2: apellido2,
      cedula: cedula,
      telefono: telefono,
      correo: correo,
      foto: fotoBytes,
    );
  }
  Future<String> getUserName() async {
    return _localStoreProviderImpl.getUserName();
  }
  @override
  Future<Map<String, dynamic>?> getDatosUsuarioCompleto() =>
      _localStoreProviderImpl.getDatosUsuarioCompleto();

  Future<void> setMetodoRegistro(String metodo) =>
      _localStoreProviderImpl.setMetodoRegistro(metodo);

  Future<String?> getMetodoRegistro() =>
      _localStoreProviderImpl.getMetodoRegistro();

  Future<void> clearMetodoRegistro() =>
      _localStoreProviderImpl.clearMetodoRegistro();
}