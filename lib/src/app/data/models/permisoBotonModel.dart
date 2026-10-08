part of 'models.dart';
PermisoBotonModel permisoBotonModelFromJson(String str) => PermisoBotonModel.fromJson(json.decode(str));

String permisoBotonModelToJson(PermisoBotonModel data) => json.encode(data.toJson());

class PermisoBotonModel {
  final DgoUsuariosAlertaApp dgoUsuariosAlertaApp;

  PermisoBotonModel({
    required this.dgoUsuariosAlertaApp,
  });

  factory PermisoBotonModel.fromJson(Map<String, dynamic> json) => PermisoBotonModel(
    dgoUsuariosAlertaApp: DgoUsuariosAlertaApp.fromJson(json["dgoUsuariosAlertaApp"]),
  );

  Map<String, dynamic> toJson() => {
    "dgoUsuariosAlertaApp": dgoUsuariosAlertaApp.toJson(),
  };
}

class DgoUsuariosAlertaApp {
  final int codeError;
  final String msj;
  final List<Dato> datos;

  DgoUsuariosAlertaApp({
    required this.codeError,
    required this.msj,
    required this.datos,
  });

  factory DgoUsuariosAlertaApp.fromJson(Map<String, dynamic> json) => DgoUsuariosAlertaApp(
    codeError: json["codeError"],
    msj: json["msj"],
    datos: List<Dato>.from(json["datos"].map((x) => Dato.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "codeError": codeError,
    "msj": msj,
    "datos": List<dynamic>.from(datos.map((x) => x.toJson())),
  };
}

class Dato {
  final int idDgoUsuariosAlertaApp;
  final String apenom;

  Dato({
    required this.idDgoUsuariosAlertaApp,
    required this.apenom,
  });

  factory Dato.fromJson(Map<String, dynamic> json) => Dato(
    idDgoUsuariosAlertaApp: ParseModel.parseToInt(json["idDgoUsuariosAlertaApp"]),
    apenom:ParseModel.parseToString( json["apenom"]),
  );

  Map<String, dynamic> toJson() => {
    "idDgoUsuariosAlertaApp": idDgoUsuariosAlertaApp,
    "apenom": apenom,
  };
}