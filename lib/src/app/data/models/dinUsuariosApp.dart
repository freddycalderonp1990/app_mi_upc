part of 'models.dart';
DinUsuarioAppModel dinUsuarioAppModelFromJson(String str) => DinUsuarioAppModel.fromJson(json.decode(str));

String dinUsuarioAppModelToJson(DinUsuarioAppModel data) => json.encode(data.toJson());

class DinUsuarioAppModel {
  DinUsuarioApp dinUsuarioApp;

  DinUsuarioAppModel({
    required this.dinUsuarioApp,
  });

  factory DinUsuarioAppModel.fromJson(Map<String, dynamic> json) => DinUsuarioAppModel(
    dinUsuarioApp: DinUsuarioApp.fromJson(json["dinUsuarioApp"]),
  );

  Map<String, dynamic> toJson() => {
    "dinUsuarioApp": dinUsuarioApp.toJson(),
  };
}

class DinUsuarioApp {
  int codeError;
  String msj;
  List<Permiso> permisos;

  DinUsuarioApp({
    required this.codeError,
    required this.msj,
    required this.permisos,
  });

  factory DinUsuarioApp.fromJson(Map<String, dynamic> json) => DinUsuarioApp(
    codeError: json["codeError"],
    msj: json["msj"],
    permisos: List<Permiso>.from(json["datos"].map((x) => Permiso.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "codeError": codeError,
    "msj": msj,
    "datos": List<dynamic>.from(permisos.map((x) => x.toJson())),
  };
}

class Permiso {
  int idDinUsuariosApp;
  int idGenGeoSenplades;
  String apenom;
  String servicio;

  Permiso({
    required this.idDinUsuariosApp,
    required this.idGenGeoSenplades,
    required this.apenom,
    required this.servicio,
  });

  factory Permiso.fromJson(Map<String, dynamic> json) => Permiso(
    idDinUsuariosApp: ParseModel.parseToInt(json["idDinUsuariosApp"]),
    idGenGeoSenplades: ParseModel.parseToInt(json["idGenGeoSenplades"]),
    apenom: json["apenom"],
    servicio: json["servicio"],
  );

  Map<String, dynamic> toJson() => {
    "idDinUsuariosApp": idDinUsuariosApp,
    "idGenGeoSenplades": idGenGeoSenplades,
    "apenom": apenom,
    "servicio": servicio,
  };
}
