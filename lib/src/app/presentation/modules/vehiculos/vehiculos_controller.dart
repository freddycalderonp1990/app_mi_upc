part of '../controllers.dart';

class VehiculosController extends GetxController {
  RxBool peticionServerState = false.obs;
  late StreamSubscription connectionSubscription;
  final status = Rx<ConnectionStatus>(ConnectionStatus.online);

  // Repos y casos de uso
  final ServiciosRepository _apiServiciosRepository = Get.find(); // Puedes usar otro repo si tienes uno de vehículos
  final SaveFileImgUseCase _saveFileImgUseCase = Get.find();

  // UI / estados
  final TextEditingController placaController = TextEditingController();
  RxBool cargandoConsulta = false.obs;
  RxBool vehiculoEncontrado = false.obs;

  // Datos del vehículo
  RxString marca = ''.obs;
  RxString color = ''.obs;
  RxString anio = ''.obs;

  // Foto opcional
  Rx<GaleryCameraModel?> mGaleryCameraModel = Rx<GaleryCameraModel?>(null);

  // Heredado de tu código (para cabecera/fecha)
  var datosServicio = Get.parameters;
  String imagenModulo = "";
  String fecha = "";
// UI / estados
  final TextEditingController marcaController = TextEditingController();
  final TextEditingController colorController = TextEditingController();
  final TextEditingController anioController  = TextEditingController();


  RxBool consultaRealizada  = false.obs; // se mostró el bloque de campos


// (Si los usabas antes, puedes mantener estos RxString, pero ahora los controladores son la fuente de verdad)


  void limpiarDatosVehiculo() {
    vehiculoEncontrado(false);
    consultaRealizada(false);
    marca('');
    color('');
    anio('');

    marcaController.clear();
    colorController.clear();
    anioController.clear();

    mGaleryCameraModel.value = null;
  }

  @override
  void onClose() {
    placaController.dispose();
    marcaController.dispose();
    colorController.dispose();
    anioController.dispose();
    connectionSubscription.cancel();
    super.onClose();
  }

  @override
  void onInit() {
    fecha = 'Hoy es ${UtilidadesUtil.getFechaActual}';
    imagenModulo = datosServicio['imagen'].toString();
    super.onInit();
  }

  @override
  void onReady() {
    _init();
    _initNotificaciones(); // si deseas mantener notificaciones
  }

  _init() async {}

  connectionStatusController() {
    connectionSubscription = internetChecker.internetStatus().listen(
          (newStatus) => status.value = newStatus,
    );
  }


  // === CONSULTA POR PLACA ===
  Future<void> consultarVehiculoPorPlaca() async {
    final placa = placaController.text.trim().toUpperCase();
    if (placa.isEmpty) {
      DialogosAwesome.getWarning(descripcion: "Ingrese una placa para consultar");
      return;
    }

    try {
      cargandoConsulta(true);
      limpiarDatosVehiculo();

      // TODO: Ajusta el método real de tu repo/servicio backend
      // Debe devolver algo como: {marca, color, anio}
      //final result = await _apiServiciosRepository.consultarVehiculoPorPlaca(placa: placa);
      final result=true;
      if (result == null) {
        DialogosAwesome.getWarning(descripcion: "No se encontró información para la placa $placa");
        return;
      }

      // Mapea resultado
     // marca(result.marca ?? '');
     // color(result.color ?? '');
      //anio((result.anioFabricacion ?? '').toString());
    marca('KIA' ?? '');
       color('PLATEADO' ?? '');
      anio(('2018' ?? '').toString());
      if (marca.value.isEmpty && color.value.isEmpty && anio.value.isEmpty) {
        DialogosAwesome.getWarning(descripcion: "No se encontró información para la placa $placa");
        return;
      }

      vehiculoEncontrado(true);
    } on ServerException catch (e) {
      DialogosAwesome.getError(descripcion: e.cause);
    } catch (e) {
      DialogosAwesome.getError(descripcion: e.toString());
    } finally {
      cargandoConsulta(false);
    }
  }

  // === GUARDAR REGISTRO (con foto opcional) ===
  Future<void> guardarRegistroVehiculo() async {
    final placa = placaController.text.trim().toUpperCase();
    if (!vehiculoEncontrado.value || placa.isEmpty) {
      DialogosAwesome.getWarning(descripcion: "Debe consultar y confirmar un vehículo antes de guardar");
      return;
    }

    try {
      peticionServerState(true);

      String? nombreImagenFinal;

      // 1) Si hay imagen, súbela
      if (mGaleryCameraModel.value != null) {
        String path = dotenv.env['PATH_IMG_ELECCIONES'] ?? ''; // Ajusta tu path
        String nameFile = "vehiculo_${placa}";
        FileRequest request = FileRequest(
          file: mGaleryCameraModel.value!.imageFile,
          path: path,
          nameFile: nameFile,
        );

        bool insertImg = await _saveFileImgUseCase(request: request);
        if (!insertImg) {
          peticionServerState(false);
          DialogosAwesome.getWarning(
            title: "Guardar Imagen",
            descripcion: "No se pudo guardar la Imagen (el registro continuará sin imagen si lo desea).",
            btnOkOnPress: () => Get.back(),
          );
        } else {
          nombreImagenFinal = "${nameFile}_${mGaleryCameraModel.value!.nombreImg}";
        }
      }

      // 2) Guarda el registro de vehículo (con o sin imagen)
      // TODO: Ajusta al método real de tu backend
   /*   final ok = await _apiServiciosRepository.registrarVehiculo(
        placa: placa,
        marca: marca.value,
        color: color.value,
        anioFabricacion: anio.value,
        imagen: nombreImagenFinal, // puede ir null
      );*/
      final ok =true;
      peticionServerState(false);

      if (ok) {
        DialogosAwesome.getSucess(
          title: "REGISTRO CORRECTO",
          descripcion: "Vehículo guardado exitosamente",
          btnOkOnPress: () {
            Get.back(); // cierra diálogo si hay
            // Limpieza si quieres:
            limpiarDatosVehiculo();
            placaController.clear();
          },
        );
      } else {
        DialogosAwesome.getWarning(descripcion: "No se pudo completar el registro, intente nuevamente.");
      }
    } on ServerException catch (e) {
      peticionServerState(false);
      DialogosAwesome.getError(descripcion: e.cause);
    } catch (e) {
      peticionServerState(false);
      DialogosAwesome.getError(descripcion: e.toString());
    }
  }

  // ---- Notificaciones (opcional, mantengo tu lógica) ----
  bool _notificacionesIniciadas = false;
  void _initNotificaciones() async {
    if (_notificacionesIniciadas) return;
    _notificacionesIniciadas = true;

    final messaging = FirebaseMessaging.instance;
    await messaging.requestPermission();
    await messaging.subscribeToTopic('upceventos1');

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final titulo = message.notification?.title ?? "Sin título";
      final cuerpo = message.notification?.body ?? "Sin cuerpo";

      if (titulo.toString() == "WEB") {
        mostrarSnackbarConEstilo(
          titulo: titulo,
          mensaje: cuerpo,
          icono: Icons.notifications_active_sharp,
          colorFondo: Colors.red,
          colorTexto: Colors.white,
        );
      } else if (titulo.toString() == "SEGUIMIENTO") {
        mostrarSnackbarConEstilo(
          titulo: titulo,
          mensaje: cuerpo,
          icono: Icons.notification_add_outlined,
          colorFondo: Colors.amber,
          colorTexto: Colors.black,
        );
      }
    });
  }

  void mostrarSnackbarConEstilo({
    required String titulo,
    required String mensaje,
    IconData icono = Icons.notifications,
    Color colorFondo = Colors.white,
    Color colorTexto = Colors.black,
    Duration duracion = const Duration(seconds: 5),
  }) {
    Get.snackbar(
      titulo,
      mensaje,
      icon: Icon(icono, color: Colors.white),
      snackPosition: SnackPosition.TOP,
      backgroundColor: colorFondo.withOpacity(0.95),
      colorText: colorTexto,
      borderRadius: 12,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.all(16),
      animationDuration: const Duration(milliseconds: 500),
      duration: duracion,
      forwardAnimationCurve: Curves.easeOutBack,
      reverseAnimationCurve: Curves.easeInBack,
      overlayBlur: 1.5,
      boxShadows: [
        const BoxShadow(
          color: Colors.black26,
          offset: Offset(0, 4),
          blurRadius: 10,
        ),
      ],
      shouldIconPulse: true,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
    );
  }
}
