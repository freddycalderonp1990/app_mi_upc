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

}