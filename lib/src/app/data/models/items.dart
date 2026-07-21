
import 'dart:convert';

import 'models.dart';

ItemsServiciosMiupc itemsServiciosMiupcFromJson(String str) => ItemsServiciosMiupc.fromJson(json.decode(str));

String itemsServiciosMiupcToJson(ItemsServiciosMiupc data) => json.encode(data.toJson());

class ItemsServiciosMiupc {
  final UpcServitems upcServitems;

  ItemsServiciosMiupc({
    required this.upcServitems,
  });

  factory ItemsServiciosMiupc.fromJson(Map<String, dynamic> json) => ItemsServiciosMiupc(
    upcServitems: UpcServitems.fromJson(json["upcServitems"]),
  );

  Map<String, dynamic> toJson() => {
    "upcServitems": upcServitems.toJson(),
  };
}

class UpcServitems {
  final int codeError;
  final String msj;
  final List<Item> items;

  UpcServitems({
    required this.codeError,
    required this.msj,
    required this.items,
  });

  factory UpcServitems.fromJson(Map<String, dynamic> json) => UpcServitems(
    codeError: json["codeError"],
    msj: json["msj"],
    items: List<Item>.from(json["datos"].map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "codeError": codeError,
    "msj": msj,
    "datos": List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class Item {
  final String descripcion;
  final int idUpcServitems;

  Item({
    required this.descripcion,
    required this.idUpcServitems,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    descripcion: json["descripcion"],
    idUpcServitems: ParseModel.parseToInt(json["idUpcServitems"]),
  );

  Map<String, dynamic> toJson() => {
    "descripcion": descripcion,
    "idUpcServitems": idUpcServitems,
  };
}
