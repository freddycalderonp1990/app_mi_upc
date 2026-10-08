part of 'models.dart';
DinListaAlertasModel dinListaAlertasModelFromJson(String str) => DinListaAlertasModel.fromJson(json.decode(str));

String dinListaAlertasModelToJson(DinListaAlertasModel data) => json.encode(data.toJson());

class DinListaAlertasModel {
  DinListaAlertaApp dinListaAlertaApp;

  DinListaAlertasModel({
    required this.dinListaAlertaApp,
  });

  factory DinListaAlertasModel.fromJson(Map<String, dynamic> json) => DinListaAlertasModel(
    dinListaAlertaApp: DinListaAlertaApp.fromJson(json["dinListaAlertaApp"]),
  );

  Map<String, dynamic> toJson() => {
    "dinListaAlertaApp": dinListaAlertaApp.toJson(),
  };
}

class DinListaAlertaApp {
  int codeError;
  String msj;
  List<ListaAlerta> listaAlertas;

  DinListaAlertaApp({
    required this.codeError,
    required this.msj,
    required this.listaAlertas,
  });

  factory DinListaAlertaApp.fromJson(Map<String, dynamic> json) => DinListaAlertaApp(
    codeError: json["codeError"],
    msj: json["msj"],
    listaAlertas: List<ListaAlerta>.from(json["datos"].map((x) => ListaAlerta.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "codeError": codeError,
    "msj": msj,
    "datos": List<dynamic>.from(listaAlertas.map((x) => x.toJson())),
  };
}

class ListaAlerta {
  int idDinAlertaApp;
  String reporta;
  String estadoAlerta;
  String fechaRegistroAlerta;
  String observacion;
  String imagenAlerta;
  double latitud;
  double longitud;
  int idGenGeoSenplades;
  String tipoAlerta;
  String distrito;
  String fechaInicioTurno;
  String policia;
  String funcion;
  dynamic imgBase64;

  ListaAlerta({
    required this.idDinAlertaApp,
    required this.reporta,
    required this.estadoAlerta,
    required this.fechaRegistroAlerta,
    required this.observacion,
    required this.imagenAlerta,
    required this.latitud,
    required this.longitud,
    required this.idGenGeoSenplades,
    required this.tipoAlerta,
    required this.distrito,
    required this.fechaInicioTurno,
    required this.policia,
    required this.funcion,
    required this.imgBase64,
  });

  factory ListaAlerta.fromJson(Map<String, dynamic> json) => ListaAlerta(
    idDinAlertaApp: ParseModel.parseToInt(json["idDinAlertaApp"]),
    reporta: ParseModel.parseToString(json["reporta"]),
    estadoAlerta: ParseModel.parseToString(json["estadoAlerta"]),
    fechaRegistroAlerta: ParseModel.parseToString(json["fechaRegistroAlerta"]),
    observacion: ParseModel.parseToString(json["observacion"]),
    imagenAlerta: ParseModel.parseToString(json["imagenAlerta"]),
    latitud: ParseModel.parseToDouble(json["latitud"]),
    longitud: ParseModel.parseToDouble(json["longitud"]),
    idGenGeoSenplades: json["idGenGeoSenplades"],
    tipoAlerta: ParseModel.parseToString(json["tipoAlerta"]),
    distrito: ParseModel.parseToString(json["distrito"]),
    fechaInicioTurno: ParseModel.parseToString(json["fechaInicioTurno"]),
    policia: ParseModel.parseToString(json["policia"]),
    funcion: ParseModel.parseToString(json["funcion"]),
    imgBase64: ParseModel.parseToString(json["imgBase64"]),
  );

  Map<String, dynamic> toJson() => {
    "idDinAlertaApp": idDinAlertaApp,
    "reporta": reporta,
    "estadoAlerta": estadoAlerta,
    "fechaRegistroAlerta": fechaRegistroAlerta,
    "observacion": observacion,
    "imagenAlerta": imagenAlerta,
    "latitud": latitud,
    "longitud": longitud,
    "idGenGeoSenplades": idGenGeoSenplades,
    "tipoAlerta": tipoAlerta,
    "distrito": distrito,
    "fechaInicioTurno": fechaInicioTurno,
    "policia": policia,
    "funcion": funcion,
    "imgBase64": imgBase64,
  };
}