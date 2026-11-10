part of '../controllers.dart';

class AlertasDesaparecidosController extends GetxController {
  AlertasDesaparecidosController(this.repository);

  final AlertasDesaparecidosLocalRepository repository;
  final String categoria = Get.parameters['tipo'] == 'mascotas'
      ? 'mascotas'
      : 'personas';

  final RxList<AlertaDesaparecidoRegistro> registros =
      <AlertaDesaparecidoRegistro>[].obs;
  final RxString busqueda = ''.obs;
  final RxBool cargando = false.obs;
  final RxnString error = RxnString();

  bool get esPersona => categoria == 'personas';
  String get titulo => esPersona
      ? 'PERSONAS DESAPARECIDAS'
      : 'MASCOTAS DESAPARECIDAS';

  List<AlertaDesaparecidoRegistro> get registrosFiltrados {
    final query = busqueda.value.trim().toLowerCase();
    return registros.where((registro) {
      if (registro.categoria != categoria) return false;
      if (query.isEmpty) return true;
      return [
        registro.nombre,
        registro.tipo,
        registro.raza,
        registro.color,
        registro.ciudad,
        registro.provincia,
      ].any((value) => value.toLowerCase().contains(query));
    }).toList()
      ..sort((a, b) {
        final abiertos =
            (a.estado == 'Desaparecido' ? 0 : 1)
                .compareTo(b.estado == 'Desaparecido' ? 0 : 1);
        return abiertos != 0
            ? abiertos
            : b.fechaCreacion.compareTo(a.fechaCreacion);
      });
  }

  @override
  void onInit() {
    super.onInit();
    cargar();
  }

  Future<void> cargar() async {
    cargando.value = true;
    try {
      registros.assignAll(await repository.obtenerTodos());
      error.value = null;
    } catch (_) {
      error.value = 'No se pudieron leer los registros locales. Reintenta.';
    } finally {
      cargando.value = false;
    }
  }

  Future<String> guardarFoto(XFile image) async {
    final directory = await getApplicationDocumentsDirectory();
    final destinationDirectory =
        Directory('${directory.path}/alertas_desaparecidos');
    if (!await destinationDirectory.exists()) {
      await destinationDirectory.create(recursive: true);
    }
    final extension = image.path.contains('.')
        ? image.path.substring(image.path.lastIndexOf('.'))
        : '.jpg';
    final destination =
        '${destinationDirectory.path}/${DateTime.now().microsecondsSinceEpoch}$extension';
    return (await File(image.path).copy(destination)).path;
  }

  Future<void> guardar(AlertaDesaparecidoRegistro registro) async {
    final index = registros.indexWhere((item) => item.id == registro.id);
    final previo = index < 0 ? null : registros[index];
    final actualizados = [...registros];
    if (index < 0) {
      actualizados.add(registro);
    } else {
      actualizados[index] = registro;
    }
    await repository.guardarTodos(actualizados);
    registros.assignAll(actualizados);
    error.value = null;
    if (previo?.fotoPath != null && previo!.fotoPath != registro.fotoPath) {
      await eliminarFoto(previo.fotoPath);
    }
  }

  Future<void> eliminar(AlertaDesaparecidoRegistro registro) async {
    final actualizados =
        registros.where((item) => item.id != registro.id).toList();
    await repository.guardarTodos(actualizados);
    registros.assignAll(actualizados);
    await eliminarFoto(registro.fotoPath);
  }

  Future<void> eliminarFoto(String? path) async {
    if (path == null || path.isEmpty) return;
    try {
      final file = File(path);
      if (await file.exists()) await file.delete();
    } catch (_) {}
  }

  Future<(double, double)> obtenerGps() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      throw StateError('Activa la ubicación del dispositivo e inténtalo de nuevo.');
    }
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied) {
      throw StateError('Se necesita permiso de ubicación para adjuntar el GPS.');
    }
    if (permission == LocationPermission.deniedForever) {
      throw StateError(
        'El permiso de ubicación está desactivado. Puedes continuar sin GPS.',
      );
    }
    final position = await Geolocator.getCurrentPosition(
      locationSettings:
          const LocationSettings(accuracy: LocationAccuracy.high),
    );
    return (position.latitude, position.longitude);
  }
}
