part of 'models.dart';


UcpReportaEventoModel ucpReportaEventoModelFromJson(String str) => UcpReportaEventoModel.fromJson(json.decode(str));

String ucpReportaEventoModelToJson(UcpReportaEventoModel data) => json.encode(data.toJson());

class UcpReportaEventoModel {
  final UpcReportaEvento upcReportaEvento;

  UcpReportaEventoModel({
    required this.upcReportaEvento,
  });

  factory UcpReportaEventoModel.fromJson(Map<String, dynamic> json) => UcpReportaEventoModel(
    upcReportaEvento: UpcReportaEvento.fromJson(json["upcReportaEvento"]),
  );

  Map<String, dynamic> toJson() => {
    "upcReportaEvento": upcReportaEvento.toJson(),
  };
}

class UpcReportaEvento {
  final int codeError;
  final String msj;
  final DatosAddEvento datosAddEvento;

  UpcReportaEvento({
    required this.codeError,
    required this.msj,
    required this.datosAddEvento,
  });

  factory UpcReportaEvento.fromJson(Map<String, dynamic> json) => UpcReportaEvento(
    codeError: json["codeError"],
    msj: json["msj"],
    datosAddEvento: DatosAddEvento.fromJson(json["datos"]),
  );

  Map<String, dynamic> toJson() => {
    "codeError": codeError,
    "msj": msj,
    "datos": datosAddEvento.toJson(),
  };
}

class DatosAddEvento {
  final String idUpcReportaEvento;

  DatosAddEvento({
    required this.idUpcReportaEvento,
  });

  factory DatosAddEvento.fromJson(Map<String, dynamic> json) => DatosAddEvento(
    idUpcReportaEvento: json["idUpcReportaEvento"],
  );

  Map<String, dynamic> toJson() => {
    "idUpcReportaEvento": idUpcReportaEvento,
  };
}
