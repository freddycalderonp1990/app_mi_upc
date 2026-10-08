import 'dart:io';

class EventoEntity {
  final int? id;
  final String idDispositivo;
  final String tipoEvento;
  final String fechaEvento;
  final String descripcionEvento;
  final String referenciaLugar;
  final double latitudDispositivo;
  final double longitudDispositivo;
  final double latitudEvento;
  final double longitudEvento;
  final String nombreSeudonimo;
  final String numeroTelefono;
  final String correoElectronico;
  final String? urlArchivoRespaldo;
  final String? nombreArchivoRespaldo;
  final String? tipoMimeArchivoRespaldo;
  final int? tamanioArchivoRespaldo;
  final String direccionIp;
  final String agenteUsuario;
  final String estado;
  final String fechaCreacion;
  final String fechaActualizacion;

  /// NUEVO: archivo local para multipart
  final File? archivoAdjunto;

  EventoEntity({
    this.id,
    required this.idDispositivo,
    required this.tipoEvento,
    required this.fechaEvento,
    required this.descripcionEvento,
    required this.referenciaLugar,
    required this.latitudDispositivo,
    required this.longitudDispositivo,
    required this.latitudEvento,
    required this.longitudEvento,
    required this.nombreSeudonimo,
    required this.numeroTelefono,
    required this.correoElectronico,
    this.urlArchivoRespaldo,
    this.nombreArchivoRespaldo,
    this.tipoMimeArchivoRespaldo,
    this.tamanioArchivoRespaldo,
    required this.direccionIp,
    required this.agenteUsuario,
    required this.estado,
    required this.fechaCreacion,
    required this.fechaActualizacion,
    this.archivoAdjunto,
  });
}
