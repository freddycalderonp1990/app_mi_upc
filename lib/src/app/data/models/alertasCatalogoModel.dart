part of 'models.dart';

CatalogosAlertaModel catalogosAlertaModelFromJson(String str) =>
    CatalogosAlertaModel.fromJson(json.decode(str));

String catalogosAlertaModelToJson(CatalogosAlertaModel data) =>
    json.encode(data.toJson());

class CatalogosAlertaModel {
  final List<CatalogoModel> result;
  final List<dynamic> errors;

  CatalogosAlertaModel({
    required this.result,
    required this.errors,
  });

  factory CatalogosAlertaModel.fromJson(Map<String, dynamic> json) =>
      CatalogosAlertaModel(
        result: json["result"] == null
            ? []
            : List<CatalogoModel>.from(
          json["result"].map((x) => CatalogoModel.fromJson(x)),
        ),
        errors: json["errors"] == null
            ? []
            : List<dynamic>.from(json["errors"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
    "errors": List<dynamic>.from(errors.map((x) => x)),
  };
}

class CatalogoModel {
  final int id;
  final String descripcion;

  CatalogoModel({
    required this.id,
    required this.descripcion,
  });

  factory CatalogoModel.fromJson(Map<String, dynamic> json) => CatalogoModel(
    id: ParseModel.parseToInt(json["id"]),
    descripcion: ParseModel.parseToString(json["descripcion"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "descripcion": descripcion,
  };
}