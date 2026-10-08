
import 'dart:convert';
import 'models.dart';
ItemsServiciosMiupcOffLine itemsServiciosMiupcOffLineFromJson(String str) => ItemsServiciosMiupcOffLine.fromJson(json.decode(str));
String itemsServiciosMiupcOffLineToJson(ItemsServiciosMiupcOffLine data) => json.encode(data.toJson());
class ItemsServiciosMiupcOffLine {
  final UpcServitemsOffLine upcServitemsOffLine;
  ItemsServiciosMiupcOffLine({
    required this.upcServitemsOffLine,
  });

  factory ItemsServiciosMiupcOffLine.fromJson(Map<String, dynamic> json) => ItemsServiciosMiupcOffLine(
    upcServitemsOffLine: UpcServitemsOffLine.fromJson(json["upcServitems"]),
  );

  Map<String, dynamic> toJson() => {
    "upcServitems": upcServitemsOffLine.toJson(),
  };
}

class UpcServitemsOffLine {
  final int codeError;
  final String msj;
  final List<ItemOffLine> items;

  UpcServitemsOffLine({
    required this.codeError,
    required this.msj,
    required this.items,
  });

  factory UpcServitemsOffLine.fromJson(Map<String, dynamic> json) => UpcServitemsOffLine(
    codeError: json["codeError"],
    msj: json["msj"],
    items: List<ItemOffLine>.from(json["datos"].map((x) => ItemOffLine.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "codeError": codeError,
    "msj": msj,
    "datos": List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class ItemOffLine {
  final String descripcion;
  final int idUpcServitems;
  final int idUpcServicio;

  ItemOffLine({
    required this.descripcion,
    required this.idUpcServitems,
    required this.idUpcServicio
  });

  factory ItemOffLine.fromJson(Map<String, dynamic> json) => ItemOffLine(
    descripcion: json["descripcion"],
    idUpcServitems: ParseModel.parseToInt(json["idUpcServitems"]),
    idUpcServicio: ParseModel.parseToInt(json["idUpcServicio"]),
  );

  Map<String, dynamic> toJson() => {
    "descripcion": descripcion,
    "idUpcServitems": idUpcServitems,
    "idUpcServicio":idUpcServicio
  };
}
