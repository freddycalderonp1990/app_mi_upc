import 'dart:convert';

AuditoriaModel auditoriaModelFromJson(String str) => AuditoriaModel.fromJson(json.decode(str));

String auditoriaModelToJson(AuditoriaModel data) => json.encode(data.toJson());

class AuditoriaModel {
  AuditoriaModel({
    required this.code,
    required this.msj,
  });

  bool code;
  String msj;

  factory AuditoriaModel.fromJson(Map<String, dynamic> json) => AuditoriaModel(
    code: json["code"],
    msj: json["msj"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "msj": msj,
  };
}
