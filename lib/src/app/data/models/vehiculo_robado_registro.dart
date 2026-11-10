import 'dart:convert';

class VehiculoRobadoRegistro {
  const VehiculoRobadoRegistro({
    required this.id,
    required this.tipo,
    required this.placa,
    required this.marca,
    required this.modelo,
    required this.anio,
    required this.color,
    required this.descripcion,
    required this.fechaRobo,
    required this.horaRobo,
    required this.provincia,
    required this.ciudad,
    required this.lugar,
    required this.contactoNombre,
    required this.contactoTelefono,
    required this.estado,
    required this.fechaCreacion,
    this.latitud,
    this.longitud,
    this.fotoPath,
  });

  final String id;
  final String tipo;
  final String placa;
  final String marca;
  final String modelo;
  final String anio;
  final String color;
  final String descripcion;
  final String fechaRobo;
  final String horaRobo;
  final String provincia;
  final String ciudad;
  final String lugar;
  final String contactoNombre;
  final String contactoTelefono;
  final String estado;
  final String fechaCreacion;
  final double? latitud;
  final double? longitud;
  final String? fotoPath;

  String get ubicacionTexto => [provincia, ciudad, lugar]
      .where((item) => item.trim().isNotEmpty)
      .join(', ');

  Map<String, dynamic> toJson() => {
        'id': id,
        'tipo': tipo,
        'placa': placa,
        'marca': marca,
        'modelo': modelo,
        'anio': anio,
        'color': color,
        'descripcion': descripcion,
        'fechaRobo': fechaRobo,
        'horaRobo': horaRobo,
        'provincia': provincia,
        'ciudad': ciudad,
        'lugar': lugar,
        'contactoNombre': contactoNombre,
        'contactoTelefono': contactoTelefono,
        'estado': estado,
        'fechaCreacion': fechaCreacion,
        'latitud': latitud,
        'longitud': longitud,
        'fotoPath': fotoPath,
      };

  factory VehiculoRobadoRegistro.fromJson(Map<String, dynamic> json) =>
      VehiculoRobadoRegistro(
        id: json['id']?.toString() ?? '',
        tipo: json['tipo']?.toString() ?? '',
        placa: json['placa']?.toString() ?? '',
        marca: json['marca']?.toString() ?? '',
        modelo: json['modelo']?.toString() ?? '',
        anio: json['anio']?.toString() ?? '',
        color: json['color']?.toString() ?? '',
        descripcion: json['descripcion']?.toString() ?? '',
        fechaRobo: json['fechaRobo']?.toString() ?? '',
        horaRobo: json['horaRobo']?.toString() ?? '',
        provincia: json['provincia']?.toString() ?? '',
        ciudad: json['ciudad']?.toString() ?? '',
        lugar: json['lugar']?.toString() ?? '',
        contactoNombre: json['contactoNombre']?.toString() ?? '',
        contactoTelefono: json['contactoTelefono']?.toString() ?? '',
        estado: json['estado']?.toString() ?? 'Registro local',
        fechaCreacion: json['fechaCreacion']?.toString() ?? '',
        latitud: (json['latitud'] as num?)?.toDouble(),
        longitud: (json['longitud'] as num?)?.toDouble(),
        fotoPath: json['fotoPath']?.toString(),
      );

  static String encodeList(List<VehiculoRobadoRegistro> items) =>
      jsonEncode(items.map((item) => item.toJson()).toList());

  static List<VehiculoRobadoRegistro> decodeList(String source) {
    final decoded = jsonDecode(source);
    if (decoded is! List) return [];
    return decoded
        .whereType<Map>()
        .map((item) => VehiculoRobadoRegistro.fromJson(
              Map<String, dynamic>.from(item),
            ))
        .toList();
  }

  VehiculoRobadoRegistro copyWith({
    String? id,
    String? tipo,
    String? placa,
    String? marca,
    String? modelo,
    String? anio,
    String? color,
    String? descripcion,
    String? fechaRobo,
    String? horaRobo,
    String? provincia,
    String? ciudad,
    String? lugar,
    String? contactoNombre,
    String? contactoTelefono,
    String? estado,
    String? fechaCreacion,
    double? latitud,
    double? longitud,
    String? fotoPath,
    bool quitarFoto = false,
    bool quitarUbicacion = false,
  }) =>
      VehiculoRobadoRegistro(
        id: id ?? this.id,
        tipo: tipo ?? this.tipo,
        placa: placa ?? this.placa,
        marca: marca ?? this.marca,
        modelo: modelo ?? this.modelo,
        anio: anio ?? this.anio,
        color: color ?? this.color,
        descripcion: descripcion ?? this.descripcion,
        fechaRobo: fechaRobo ?? this.fechaRobo,
        horaRobo: horaRobo ?? this.horaRobo,
        provincia: provincia ?? this.provincia,
        ciudad: ciudad ?? this.ciudad,
        lugar: lugar ?? this.lugar,
        contactoNombre: contactoNombre ?? this.contactoNombre,
        contactoTelefono: contactoTelefono ?? this.contactoTelefono,
        estado: estado ?? this.estado,
        fechaCreacion: fechaCreacion ?? this.fechaCreacion,
        latitud: quitarUbicacion ? null : (latitud ?? this.latitud),
        longitud: quitarUbicacion ? null : (longitud ?? this.longitud),
        fotoPath: quitarFoto ? null : (fotoPath ?? this.fotoPath),
      );
}
