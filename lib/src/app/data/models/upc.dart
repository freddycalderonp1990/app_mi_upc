// To parse this JSON data, do
//
//     final datosUpc = datosUpcFromJson(jsonString);

import 'dart:convert';

import 'models.dart';

DatosUpc datosUpcFromJson(String str) => DatosUpc.fromJson(json.decode(str));

String datosUpcToJson(DatosUpc data) => json.encode(data.toJson());

class DatosUpc {
  final GenUpc genUpc;

  DatosUpc({
    required this.genUpc,
  });

  factory DatosUpc.fromJson(Map<String, dynamic> json) => DatosUpc(
    genUpc: GenUpc.fromJson(json["genUpc"]),
  );

  Map<String, dynamic> toJson() => {
    "genUpc": genUpc.toJson(),
  };
}

class GenUpc {
  final int codeError;
  final String msj;
  final List<Upc> upc;

  GenUpc({
    required this.codeError,
    required this.msj,
    required this.upc,
  });

  factory GenUpc.fromJson(Map<String, dynamic> json) => GenUpc(
    codeError: json["codeError"],
    msj: json["msj"],
    upc: List<Upc>.from(json["datos"].map((x) => Upc.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "codeError": codeError,
    "msj": msj,
    "datos": List<dynamic>.from(upc.map((x) => x.toJson())),
  };
}

class Upc {
  final int idGenUpc;
  final String descripcionUpc;
  final String latitudUpc;
  final String longitudUpc;
  final String fonoUpc;
  final String fotoUpc;
  final String dirUpc;
  final String mailUpc;
  final String distance;

  Upc({
    required this.idGenUpc,
    required this.descripcionUpc,
    required this.latitudUpc,
    required this.longitudUpc,
    required this.fonoUpc,
    required this.fotoUpc,
    required this.dirUpc,
    required this.mailUpc,
    required this.distance,
  });

  factory Upc.fromJson(Map<String, dynamic> json) => Upc(
    idGenUpc: ParseModel.parseToInt(json["idGenUpc"]),
    descripcionUpc: json["descripcionUpc"],
    latitudUpc: json["latitudUpc"],
    longitudUpc: json["longitudUpc"],
    fonoUpc: json["fonoUpc"],
    fotoUpc: json["fotoUpc"],
    dirUpc: json["dirUpc"],
    mailUpc: json["mailUpc"],
    distance: json["distance"],
  );

  Map<String, dynamic> toJson() => {
    "idGenUpc": idGenUpc,
    "descripcionUpc": descripcionUpc,
    "latitudUpc": latitudUpc,
    "longitudUpc": longitudUpc,
    "fonoUpc": fonoUpc,
    "fotoUpc": fotoUpc,
    "dirUpc": dirUpc,
    "mailUpc": mailUpc,
    "distance": distance,
  };
}
