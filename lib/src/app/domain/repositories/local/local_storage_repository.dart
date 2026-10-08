//Para Guardar informacion en local

part of '../domain_repositories.dart';
abstract class LocalStorageRepository{
  //Se define que cosas quiero hacer
  //se definen los contartos

  Future<String> getDatosAcuerdo();
  Future<bool> setDatosAcuerdo(String value);

  Future<String> getDatosUsuario();
  Future<bool> setDatosUsuario(String value);

  Future<String> getDatosMail();
  Future<bool> setDatosMail(String value);

  Future<List<Modulo>> getListModulos();
  Future<bool> setDatosListaModulos( {required List<Modulo>  listModulos});


  Future<List<Servicio>> getListServicios();
  Future<bool> setDatosListaServicios( {required List<Servicio>  listServicios});

  Future<List<ItemOffLine>> getListItems();
  Future<bool> setDatosListaItems( {required List<ItemOffLine>  listItems});

  Future<void> setFoto(Uint8List imageBytes);
  Future<Uint8List?> getFoto();

  Future<List<Servicio>> getListServiciosPoli();
  Future<bool> setDatosListaServiciosPoli( {required List<Servicio>  listServiciosPoli});

  Future<List<ItemOffLine>> getListItemsPoli();
  Future<bool> setDatosListaItemsPoli( {required List<ItemOffLine>  listItemsPoli});


}