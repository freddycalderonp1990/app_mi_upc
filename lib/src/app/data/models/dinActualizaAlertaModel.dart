part of 'models.dart';

DinActualizaAlertaModel dinActualizaAlertaModelFromJson(String str) => DinActualizaAlertaModel.fromJson(json.decode(str));

String dinActualizaAlertaModelToJson(DinActualizaAlertaModel data) => json.encode(data.toJson());

class DinActualizaAlertaModel {
  ActualizaAlertaViolencia actualizaAlertaViolencia;

  DinActualizaAlertaModel({
    required this.actualizaAlertaViolencia,
  });

  factory DinActualizaAlertaModel.fromJson(Map<String, dynamic> json) => DinActualizaAlertaModel(
    actualizaAlertaViolencia: ActualizaAlertaViolencia.fromJson(json["actualizaAlertaViolencia"]),
  );

  Map<String, dynamic> toJson() => {
    "actualizaAlertaViolencia": actualizaAlertaViolencia.toJson(),
  };
}

class ActualizaAlertaViolencia {
  int codeError;
  String msj;

  ActualizaAlertaViolencia({
    required this.codeError,
    required this.msj,
  });

  factory ActualizaAlertaViolencia.fromJson(Map<String, dynamic> json) => ActualizaAlertaViolencia(
    codeError: json["codeError"],
    msj: json["msj"],
  );

  Map<String, dynamic> toJson() => {
    "codeError": codeError,
    "msj": msj,
  };
}