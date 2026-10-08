part of "models.dart";

EventoModel eventoModelFromJson(String str) =>
    EventoModel.fromJson(json.decode(str));

String eventoModelToJson(EventoModel data) => json.encode(data.toJson());

class EventoModel extends EventoEntity {
  EventoModel({
    super.id,
    required super.idDispositivo,
    required super.tipoEvento,
    required super.fechaEvento,
    required super.descripcionEvento,
    required super.referenciaLugar,
    required super.latitudDispositivo,
    required super.longitudDispositivo,
    required super.latitudEvento,
    required super.longitudEvento,
    required super.nombreSeudonimo,
    required super.numeroTelefono,
    required super.correoElectronico,
    super.urlArchivoRespaldo,
    super.nombreArchivoRespaldo,
    super.tipoMimeArchivoRespaldo,
    super.tamanioArchivoRespaldo,
    required super.direccionIp,
    required super.agenteUsuario,
    required super.estado,
    required super.fechaCreacion,
    required super.fechaActualizacion,
    super.archivoAdjunto,
  });

  factory EventoModel.fromJson(Map<String, dynamic> json) {
    return EventoModel(
      id: json["id"],
      idDispositivo: json["idDispositivo"] ?? '',
      tipoEvento: json["tipoEvento"] ?? '',
      fechaEvento: json["fechaEvento"],
      descripcionEvento: json["descripcionEvento"] ?? '',
      referenciaLugar: json["referenciaLugar"] ?? '',
      latitudDispositivo:
      double.tryParse(json["latitudDispositivo"].toString()) ?? 0.0,
      longitudDispositivo:
      double.tryParse(json["longitudDispositivo"].toString()) ?? 0.0,
      latitudEvento:
      double.tryParse(json["latitudEvento"].toString()) ?? 0.0,
      longitudEvento:
      double.tryParse(json["longitudEvento"].toString()) ?? 0.0,
      nombreSeudonimo: json["nombreSeudonimo"] ?? '',
      numeroTelefono: json["numeroTelefono"] ?? '',
      correoElectronico: json["correoElectronico"] ?? '',
      urlArchivoRespaldo: json["urlArchivoRespaldo"],
      nombreArchivoRespaldo: json["nombreArchivoRespaldo"],
      tipoMimeArchivoRespaldo: json["tipoMimeArchivoRespaldo"],
      tamanioArchivoRespaldo: json["tamanioArchivoRespaldo"] != null
          ? int.tryParse(json["tamanioArchivoRespaldo"].toString())
          : null,
      direccionIp: json["direccionIp"] ?? '',
      agenteUsuario: json["agenteUsuario"] ?? '',
      estado: json["estado"] ?? '',
      fechaCreacion: json["fechaCreacion"],
      fechaActualizacion: json["fechaActualizacion"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "idDispositivo": idDispositivo,
      "tipoEvento": tipoEvento,
      "fechaEvento": fechaEvento,
      "descripcionEvento": descripcionEvento,
      "referenciaLugar": referenciaLugar,
      "latitudDispositivo": latitudDispositivo,
      "longitudDispositivo": longitudDispositivo,
      "latitudEvento": latitudEvento,
      "longitudEvento": longitudEvento,
      "nombreSeudonimo": nombreSeudonimo,
      "numeroTelefono": numeroTelefono,
      "correoElectronico": correoElectronico,
      "urlArchivoRespaldo": urlArchivoRespaldo,
      "nombreArchivoRespaldo": nombreArchivoRespaldo,
      "tipoMimeArchivoRespaldo": tipoMimeArchivoRespaldo,
      "tamanioArchivoRespaldo": tamanioArchivoRespaldo,
      "direccionIp": direccionIp,
      "agenteUsuario": agenteUsuario,
      "estado": estado,
      "fechaCreacion": fechaCreacion,
      "fechaActualizacion": fechaActualizacion,
    };
  }

  factory EventoModel.fromEntity(EventoEntity entity) {
    return EventoModel(
      id: entity.id,
      idDispositivo: entity.idDispositivo,
      tipoEvento: entity.tipoEvento,
      fechaEvento: entity.fechaEvento,
      descripcionEvento: entity.descripcionEvento,
      referenciaLugar: entity.referenciaLugar,
      latitudDispositivo: entity.latitudDispositivo,
      longitudDispositivo: entity.longitudDispositivo,
      latitudEvento: entity.latitudEvento,
      longitudEvento: entity.longitudEvento,
      nombreSeudonimo: entity.nombreSeudonimo,
      numeroTelefono: entity.numeroTelefono,
      correoElectronico: entity.correoElectronico,
      urlArchivoRespaldo: entity.urlArchivoRespaldo,
      nombreArchivoRespaldo: entity.nombreArchivoRespaldo,
      tipoMimeArchivoRespaldo: entity.tipoMimeArchivoRespaldo,
      tamanioArchivoRespaldo: entity.tamanioArchivoRespaldo,
      direccionIp: entity.direccionIp,
      agenteUsuario: entity.agenteUsuario,
      estado: entity.estado,
      fechaCreacion: entity.fechaCreacion,
      fechaActualizacion: entity.fechaActualizacion,
      archivoAdjunto: entity.archivoAdjunto,
    );
  }
}
