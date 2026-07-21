// To parse this JSON data, do
//
//     final modulosMiupc = modulosMiupcFromJson(jsonString);

import 'dart:convert';

import 'models.dart';

ModulosMiupc modulosMiupcFromJson(String str) => ModulosMiupc.fromJson(json.decode(str));

String modulosMiupcToJson(ModulosMiupc data) => json.encode(data.toJson());

class ModulosMiupc {
  final UpcModulosMovil upcModulosMovil;

  ModulosMiupc({
    required this.upcModulosMovil,
  });

  factory ModulosMiupc.fromJson(Map<String, dynamic> json) => ModulosMiupc(
    upcModulosMovil: UpcModulosMovil.fromJson(json["upcModulosMovil"]),
  );

  Map<String, dynamic> toJson() => {
    "upcModulosMovil": upcModulosMovil.toJson(),
  };
}

class UpcModulosMovil {
  final int codeError;
  final String msj;
  final List<Modulo> modulos;

  UpcModulosMovil({
    required this.codeError,
    required this.msj,
    required this.modulos,
  });

  factory UpcModulosMovil.fromJson(Map<String, dynamic> json) => UpcModulosMovil(
    codeError: json["codeError"],
    msj: json["msj"],
    modulos: List<Modulo>.from(json["datos"].map((x) => Modulo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "codeError": codeError,
    "msj": msj,
    "datos": List<dynamic>.from(modulos.map((x) => x.toJson())),
  };
}

class Modulo {
  final int idUpcModulosMovil;
  final String tituloModulo;
  final String descripcionModulo;
  final String imagenModulo;
  final int ordenModulo;
  final int idGenEstado;
  final String imgBase64;

  Modulo({
    required this.idUpcModulosMovil,
    required this.tituloModulo,
    required this.descripcionModulo,
    required this.imagenModulo,
    required this.ordenModulo,
    required this.idGenEstado,
    required this.imgBase64,
  });

  factory Modulo.fromJson(Map<String, dynamic> json) => Modulo(
    idUpcModulosMovil: ParseModel.parseToInt(json["idUpcModulosMovil"]),
    tituloModulo: json["tituloModulo"],
    descripcionModulo: json["descripcionModulo"],
    imagenModulo: json["imagenModulo"],
    ordenModulo: ParseModel.parseToInt(json["ordenModulo"]),
    idGenEstado: ParseModel.parseToInt(json["idGenEstado"]),
    imgBase64: json["imgBase64"],
  );

  Map<String, dynamic> toJson() => {
    "idUpcModulosMovil": idUpcModulosMovil,
    "tituloModulo": tituloModulo,
    "descripcionModulo": descripcionModulo,
    "imagenModulo": imagenModulo,
    "ordenModulo": ordenModulo,
    "idGenEstado": idGenEstado,
    "imgBase64": imgBase64,
  };
}
