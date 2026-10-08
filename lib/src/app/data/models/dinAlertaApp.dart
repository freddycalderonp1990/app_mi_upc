part of 'models.dart';

DinAlertaAppModel dinAlertaAppModelFromJson(String str) => DinAlertaAppModel.fromJson(json.decode(str));

String dinAlertaAppModelToJson(DinAlertaAppModel data) => json.encode(data.toJson());

class DinAlertaAppModel {
  DinAlertaApp dinAlertaApp;

  DinAlertaAppModel({
    required this.dinAlertaApp,
  });

  factory DinAlertaAppModel.fromJson(Map<String, dynamic> json) => DinAlertaAppModel(
    dinAlertaApp: DinAlertaApp.fromJson(json["dinAlertaApp"]),
  );

  Map<String, dynamic> toJson() => {
    "dinAlertaApp": dinAlertaApp.toJson(),
  };
}

class DinAlertaApp {
  int codeError;
  String msj;
  Alertas alertas;

  DinAlertaApp({
    required this.codeError,
    required this.msj,
    required this.alertas,
  });

  factory DinAlertaApp.fromJson(Map<String, dynamic> json) => DinAlertaApp(
    codeError: json["codeError"],
    msj: json["msj"],
    alertas: Alertas.fromJson(json["datos"]),
  );

  Map<String, dynamic> toJson() => {
    "codeError": codeError,
    "msj": msj,
    "datos": alertas.toJson(),
  };
}

class Alertas {
  String idDinAlertaApp;

  Alertas({
    required this.idDinAlertaApp,
  });

  factory Alertas.fromJson(Map<String, dynamic> json) => Alertas(
    idDinAlertaApp: json["idDinAlertaApp"],
  );

  Map<String, dynamic> toJson() => {
    "idDinAlertaApp": idDinAlertaApp,
  };
}
