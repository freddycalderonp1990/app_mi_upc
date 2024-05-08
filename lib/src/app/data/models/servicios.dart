// To parse this JSON data, do
//
//     final serviciosMiupc = serviciosMiupcFromJson(jsonString);

import 'dart:convert';

import 'models.dart';

ServiciosMiupc serviciosMiupcFromJson(String str) => ServiciosMiupc.fromJson(json.decode(str));

String serviciosMiupcToJson(ServiciosMiupc data) => json.encode(data.toJson());

class ServiciosMiupc {
  final UpcServicio upcServicio;

  ServiciosMiupc({
    required this.upcServicio,
  });

  factory ServiciosMiupc.fromJson(Map<String, dynamic> json) => ServiciosMiupc(
    upcServicio: UpcServicio.fromJson(json["upcServicio"]),
  );

  Map<String, dynamic> toJson() => {
    "upcServicio": upcServicio.toJson(),
  };
}

class UpcServicio {
  final int codeError;
  final String msj;
  final List<Servicio> servicios;

  UpcServicio({
    required this.codeError,
    required this.msj,
    required this.servicios,
  });

  factory UpcServicio.fromJson(Map<String, dynamic> json) => UpcServicio(
    codeError: json["codeError"],
    msj: json["msj"],
    servicios: List<Servicio>.from(json["datos"].map((x) => Servicio.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "codeError": codeError,
    "msj": msj,
    "datos": List<dynamic>.from(servicios.map((x) => x.toJson())),
  };
}

class Servicio {
  final int idUpcServicio;
  final String descTiposervicio;
  final String descripcion;
  final String resumen;
  final String urlImagen;
  final String imgBase64;

  Servicio({
    required this.idUpcServicio,
    required this.descTiposervicio,
    required this.descripcion,
    required this.resumen,
    required this.urlImagen,
    required this.imgBase64,
  });

  factory Servicio.fromJson(Map<String, dynamic> json) => Servicio(
    idUpcServicio: ParseModel.parseToInt(json["idUpcServicio"]),
    descTiposervicio: json["descTiposervicioValues"] == null ? '' : json["descTiposervicioValues"],
    descripcion: json["descripcion"] == null ? '' : json["descripcion"],
    resumen: json["resumen"] == null ? '' : json["resumen"],
    urlImagen: json["urlImagen"] == null ? '' : json["urlImagen"],
    imgBase64: json["imgBase64"] == null ? '' : json["imgBase64"],
  );

  Map<String, dynamic> toJson() => {
    "idUpcServicio": idUpcServicio,
    "descTiposervicio": descTiposervicio,
    "descripcion": descripcion,
    "resumen": resumen,
    "urlImagen": urlImagen,
    "imgBase64": imgBase64,
  };
}


