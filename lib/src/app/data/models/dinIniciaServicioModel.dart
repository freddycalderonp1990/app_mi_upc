part of 'models.dart';

DinTurnosUsuariosModel dinTurnosUsuariosModelFromJson(String str) => DinTurnosUsuariosModel.fromJson(json.decode(str));

String dinTurnosUsuariosModelToJson(DinTurnosUsuariosModel data) => json.encode(data.toJson());

class DinTurnosUsuariosModel {
  DinUsuarioTurnosApp dinUsuarioTurnosApp;

  DinTurnosUsuariosModel({
    required this.dinUsuarioTurnosApp,
  });

  factory DinTurnosUsuariosModel.fromJson(Map<String, dynamic> json) => DinTurnosUsuariosModel(
    dinUsuarioTurnosApp: DinUsuarioTurnosApp.fromJson(json["dinUsuarioApp"]),
  );

  Map<String, dynamic> toJson() => {
    "dinUsuarioApp": dinUsuarioTurnosApp.toJson(),
  };
}

class DinUsuarioTurnosApp {
  int codeError;
  String msj;
  Turnos turnos;

  DinUsuarioTurnosApp({
    required this.codeError,
    required this.msj,
    required this.turnos,
  });

  factory DinUsuarioTurnosApp.fromJson(Map<String, dynamic> json) {
int code=ParseModel.parseToInt(json["codeError"]);
  return  DinUsuarioTurnosApp(
      codeError: code,
      msj: json["msj"],
      turnos:code==0? Turnos.fromJson(json["datos"]):Turnos(idDinUsuarioApp: 0),
    );

  }

  Map<String, dynamic> toJson() => {
    "codeError": codeError,
    "msj": msj,
    "datos": turnos.toJson(),
  };
}

class Turnos {
  int idDinUsuarioApp;

  Turnos({
    required this.idDinUsuarioApp,
  });

  factory Turnos.fromJson(Map<String, dynamic> json) => Turnos(
    idDinUsuarioApp:ParseModel.parseToInt( json["idDinUsuarioApp"]),
  );

  Map<String, dynamic> toJson() => {
    "idDinUsuarioApp": idDinUsuarioApp,
  };
}