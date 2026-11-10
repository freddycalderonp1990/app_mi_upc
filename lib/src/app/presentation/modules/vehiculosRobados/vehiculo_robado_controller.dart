part of '../controllers.dart';

class VehiculoRobadoController extends GetxController {
  VehiculoRobadoController(this._repository);

  final VehiculoRobadoLocalRepository _repository;
  final RxList<VehiculoRobadoRegistro> registros =
      <VehiculoRobadoRegistro>[].obs;
  final RxBool cargando = false.obs;
  final RxString busqueda = ''.obs;
  final RxString tipoFiltro = 'Todos'.obs;
  final RxnString error = RxnString();

  static const tipos = [
    'Automóvil',
    'Motocicleta',
    'Camioneta',
    'Camión',
    'Otro',
  ];

  List<VehiculoRobadoRegistro> get registrosFiltrados {
    final placa = busqueda.value.trim().toUpperCase();
    return registros.where((registro) {
      final coincidePlaca = placa.isEmpty ||
          registro.placa.toUpperCase().contains(placa);
      final coincideTipo =
          tipoFiltro.value == 'Todos' || registro.tipo == tipoFiltro.value;
      return coincidePlaca && coincideTipo;
    }).toList()
      ..sort((a, b) => b.fechaCreacion.compareTo(a.fechaCreacion));
  }

  @override
  void onInit() {
    super.onInit();
    cargarRegistros();
  }

  Future<void> cargarRegistros() async {
    cargando.value = true;
    try {
      registros.assignAll(await _repository.obtenerTodos());
      error.value = null;
    } catch (e) {
      error.value = 'No se pudieron cargar los registros locales.';
    } finally {
      cargando.value = false;
    }
  }

  Future<String> guardarFotografia(XFile imagen) async {
    final directory = await getApplicationDocumentsDirectory();
    final photosDirectory = Directory('${directory.path}/vehiculos_robados');
    if (!await photosDirectory.exists()) {
      await photosDirectory.create(recursive: true);
    }
    final extension = imagen.path.contains('.')
        ? imagen.path.substring(imagen.path.lastIndexOf('.'))
        : '.jpg';
    final destination =
        '${photosDirectory.path}/vehiculo_${DateTime.now().microsecondsSinceEpoch}$extension';
    return (await File(imagen.path).copy(destination)).path;
  }

  Future<void> guardarRegistro(VehiculoRobadoRegistro registro) async {
    final anteriorIndex = registros.indexWhere((item) => item.id == registro.id);
    final anterior =
        anteriorIndex >= 0 ? registros[anteriorIndex] : null;
    final actualizados = [...registros];
    if (anteriorIndex >= 0) {
      actualizados[anteriorIndex] = registro;
    } else {
      actualizados.add(registro);
    }
    await _repository.guardarTodos(actualizados);
    registros.assignAll(actualizados);
    error.value = null;
    if (anterior?.fotoPath != null &&
        anterior!.fotoPath != registro.fotoPath) {
      await eliminarArchivoLocal(anterior.fotoPath);
    }
  }

  Future<void> eliminarRegistro(VehiculoRobadoRegistro registro) async {
    final actualizados =
        registros.where((item) => item.id != registro.id).toList();
    await _repository.guardarTodos(actualizados);
    registros.assignAll(actualizados);
    await eliminarArchivoLocal(registro.fotoPath);
  }

  Future<void> eliminarArchivoLocal(String? path) async {
    if (path == null || path.isEmpty) return;
    try {
      final file = File(path);
      if (await file.exists()) await file.delete();
    } catch (_) {
      // La eliminación del registro no se revierte si una foto ya no existe.
    }
  }

  Future<(double, double)> obtenerUbicacionActual() async {
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
        'El permiso de ubicación está desactivado. Puedes ingresarlo manualmente.',
      );
    }

    final position = await Geolocator.getCurrentPosition(
      locationSettings:
          const LocationSettings(accuracy: LocationAccuracy.high),
    );
    return (position.latitude, position.longitude);
  }
}
