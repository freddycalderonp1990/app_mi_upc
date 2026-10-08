part of 'models.dart';
DinCatalogosAppModel dinCatalogosAppModelFromJson(String str) => DinCatalogosAppModel.fromJson(json.decode(str));
String dinCatalogosAppModelToJson(DinCatalogosAppModel data) => json.encode(data.toJson());
class DinCatalogosAppModel {
  DinCatalogosApp dinCatalogosApp;
  DinCatalogosAppModel({
    required this.dinCatalogosApp,
  });

  factory DinCatalogosAppModel.fromJson(Map<String, dynamic> json) => DinCatalogosAppModel(
    dinCatalogosApp: DinCatalogosApp.fromJson(json["dinCatalogosApp"]),
  );

  Map<String, dynamic> toJson() => {
    "dinCatalogosApp": dinCatalogosApp.toJson(),
  };
}

class DinCatalogosApp {
  int codeError;
  String msj;
  List<Catalogo> catalogos;

  DinCatalogosApp({
    required this.codeError,
    required this.msj,
    required this.catalogos,
  });

  factory DinCatalogosApp.fromJson(Map<String, dynamic> json) => DinCatalogosApp(
    codeError: json["codeError"],
    msj: json["msj"],
    catalogos: List<Catalogo>.from(json["datos"].map((x) => Catalogo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "codeError": codeError,
    "msj": msj,
    "datos": List<dynamic>.from(catalogos.map((x) => x.toJson())),
  };
}

class Catalogo {
  int idDinCatalogosApp;
  String descripcion;

  Catalogo({
    required this.idDinCatalogosApp,
    required this.descripcion,
  });

  factory Catalogo.fromJson(Map<String, dynamic> json) => Catalogo(
    idDinCatalogosApp: json["idDinCatalogosApp"],
    descripcion: json["descripcion"],
  );

  Map<String, dynamic> toJson() => {
    "idDinCatalogosApp": idDinCatalogosApp,
    "descripcion": descripcion,
  };
}
