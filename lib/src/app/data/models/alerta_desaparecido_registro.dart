class AlertaDesaparecidoRegistro {
  const AlertaDesaparecidoRegistro({
    required this.id,
    required this.categoria,
    required this.nombre,
    required this.edad,
    required this.genero,
    required this.tipo,
    required this.raza,
    required this.color,
    required this.tamano,
    required this.detalles,
    required this.vestimenta,
    required this.fecha,
    required this.hora,
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
  final String categoria;
  final String nombre;
  final String edad;
  final String genero;
  final String tipo;
  final String raza;
  final String color;
  final String tamano;
  final String detalles;
  final String vestimenta;
  final String fecha;
  final String hora;
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

  bool get esPersona => categoria == 'personas';
  String get ubicacion => [provincia, ciudad, lugar]
      .where((value) => value.trim().isNotEmpty)
      .join(', ');

  Map<String, dynamic> toJson() => {
        'id': id,
        'categoria': categoria,
        'nombre': nombre,
        'edad': edad,
        'genero': genero,
        'tipo': tipo,
        'raza': raza,
        'color': color,
        'tamano': tamano,
        'detalles': detalles,
        'vestimenta': vestimenta,
        'fecha': fecha,
        'hora': hora,
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

  factory AlertaDesaparecidoRegistro.fromJson(Map<String, dynamic> json) =>
      AlertaDesaparecidoRegistro(
        id: json['id']?.toString() ?? '',
        categoria: json['categoria']?.toString() ?? 'personas',
        nombre: json['nombre']?.toString() ?? '',
        edad: json['edad']?.toString() ?? '',
        genero: json['genero']?.toString() ?? '',
        tipo: json['tipo']?.toString() ?? '',
        raza: json['raza']?.toString() ?? '',
        color: json['color']?.toString() ?? '',
        tamano: json['tamano']?.toString() ?? '',
        detalles: json['detalles']?.toString() ?? '',
        vestimenta: json['vestimenta']?.toString() ?? '',
        fecha: json['fecha']?.toString() ?? '',
        hora: json['hora']?.toString() ?? '',
        provincia: json['provincia']?.toString() ?? '',
        ciudad: json['ciudad']?.toString() ?? '',
        lugar: json['lugar']?.toString() ?? '',
        contactoNombre: json['contactoNombre']?.toString() ?? '',
        contactoTelefono: json['contactoTelefono']?.toString() ?? '',
        estado: json['estado']?.toString() ?? 'Desaparecido',
        fechaCreacion: json['fechaCreacion']?.toString() ?? '',
        latitud: (json['latitud'] as num?)?.toDouble(),
        longitud: (json['longitud'] as num?)?.toDouble(),
        fotoPath: json['fotoPath']?.toString(),
      );

  AlertaDesaparecidoRegistro copyWith({
    String? estado,
    String? fotoPath,
    bool quitarFoto = false,
  }) =>
      AlertaDesaparecidoRegistro(
        id: id,
        categoria: categoria,
        nombre: nombre,
        edad: edad,
        genero: genero,
        tipo: tipo,
        raza: raza,
        color: color,
        tamano: tamano,
        detalles: detalles,
        vestimenta: vestimenta,
        fecha: fecha,
        hora: hora,
        provincia: provincia,
        ciudad: ciudad,
        lugar: lugar,
        contactoNombre: contactoNombre,
        contactoTelefono: contactoTelefono,
        estado: estado ?? this.estado,
        fechaCreacion: fechaCreacion,
        latitud: latitud,
        longitud: longitud,
        fotoPath: quitarFoto ? null : (fotoPath ?? this.fotoPath),
      );
}
