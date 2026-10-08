part of '../controllers.dart';

class AlertasDelitosController extends GetxController {
  final AlertasDelitosRepository _apiAlertasDelitosRepository = Get.find();
  final GpsController gpsController = Get.find<GpsController>();

  final CheckInternetConnection internetChecker = CheckInternetConnection();
  late StreamSubscription connectionSubscription;

  final Rx<ConnectionStatus> status = ConnectionStatus.online.obs;

  final formKey = GlobalKey<FormState>();
  final Rxn<DateTime> fechaEventoSeleccionada = Rxn<DateTime>();
  final TextEditingController fechaEventoController = TextEditingController();
  final Map<String, String?> datosServicio = Get.parameters;
  String nombreModulo = '';
  String imagenModulo = '';

  final RxBool peticionServerState = false.obs;
  final RxBool btnPressed = false.obs;

  final TextEditingController descripcionController = TextEditingController();
  final TextEditingController referenciaController = TextEditingController();
  final TextEditingController seudonimoController = TextEditingController();
  final TextEditingController telefonoController = TextEditingController();
  final TextEditingController correoController = TextEditingController();

  final RxList<CatalogoModel> listEventosApi = <CatalogoModel>[].obs;
  final RxInt idEventoApiSeleccionado = 0.obs;
  final RxString nombreEventoApiSeleccionado = ''.obs;
  final RxBool cargandoEventosApi = false.obs;

  final RxBool creandoEvento = false.obs;
  final RxString mensajeError = ''.obs;
  final Rxn<EventoEntity> eventoCreado = Rxn<EventoEntity>();

  final RxDouble latitudDispositivo = 0.0.obs;
  final RxDouble longitudDispositivo = 0.0.obs;
  final RxDouble latitudEvento = 0.0.obs;
  final RxDouble longitudEvento = 0.0.obs;
  final RxBool ubicacionLista = false.obs;

  final Rxn<AdjuntoModel> adjuntoSeleccionado = Rxn<AdjuntoModel>();
  final RxBool cargandoAdjunto = false.obs;

  String imeiCell = '';
  String modeloCelular = '';
  String tConexion = 'MOVIL';
  String SSID = 'MOVIL';
  String plataforma = 'Android';

  final RxBool dialogoTerminosMostrado = false.obs;

  @override
  void onInit() {
    super.onInit();
    imagenModulo = datosServicio['imagen']?.toString() ?? '';
    nombreModulo = datosServicio['nombreModulo']?.toString() ?? '';
    getImei();
    getTelephonyInfo();
    initPlatformDevice();
    connectionStatusController();
    consultaDatosCatalogoAlerta();
    obtenerUbicacionInicial();
    _initFechaEvento();
  }
  void _initFechaEvento() {
    final ahora = DateTime.now();
    fechaEventoSeleccionada.value = ahora;
    fechaEventoController.text = DateFormat('dd/MM/yyyy HH:mm').format(ahora);
  }
  Future<void> seleccionarFechaEvento(BuildContext context) async {
    try {
      final DateTime ahora = DateTime.now();
      final DateTime fechaBase = fechaEventoSeleccionada.value ?? ahora;

      final DateTime? fecha = await showDatePicker(
        context: context,
        initialDate: fechaBase,
        firstDate: DateTime(2020),
        lastDate: ahora,
        locale: const Locale('es', 'EC'),
        helpText: 'Seleccionar fecha del evento',
        cancelText: 'Cancelar',
        confirmText: 'Aceptar',
      );

      if (fecha == null) return;

      final TimeOfDay? hora = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(fechaBase),
        helpText: 'Seleccionar hora del evento',
        cancelText: 'Cancelar',
        confirmText: 'Aceptar',
      );

      if (hora == null) return;

      final DateTime fechaCompleta = DateTime(
        fecha.year,
        fecha.month,
        fecha.day,
        hora.hour,
        hora.minute,
      );

      if (fechaCompleta.isAfter(ahora)) {
        DialogosAwesome.getInformationAceptar(
          descripcion: "La fecha y hora del evento no puede ser futura.",
          btnOkOnPress: () => Get.back(),
        );
        return;
      }

      fechaEventoSeleccionada.value = fechaCompleta;
      fechaEventoController.text =
          DateFormat('dd/MM/yyyy HH:mm').format(fechaCompleta);
    } catch (e) {
      DialogosAwesome.getError(
        descripcion: "No fue posible seleccionar la fecha del evento: $e",
      );
    }
  }
  String? validarFechaEvento() {
    final fecha = fechaEventoSeleccionada.value;

    if (fecha == null) {
      return 'Debe seleccionar la fecha del evento';
    }

    if (fecha.isAfter(DateTime.now())) {
      return 'La fecha del evento no puede ser futura';
    }

    return null;
  }
  @override
  void onClose() {
    descripcionController.dispose();
    referenciaController.dispose();
    seudonimoController.dispose();
    telefonoController.dispose();
    correoController.dispose();
    fechaEventoController.dispose();
    connectionSubscription.cancel();
    internetChecker.close();
    super.onClose();
  }

  void connectionStatusController() {
    connectionSubscription =
        internetChecker.internetStatus().listen((newStatus) {
          status.value = newStatus;
        });
  }

  Future<void> consultaDatosCatalogoAlerta() async {
    try {
      listEventosApi.clear();
      cargandoEventosApi.value = true;

      final List<CatalogoModel> tiposEvento = [
        CatalogoModel(id: 1, descripcion: 'EXTORSIÓN'),
        CatalogoModel(id: 2, descripcion: 'SECUESTRO'),
        CatalogoModel(id: 3, descripcion: 'DROGAS'),
        CatalogoModel(id: 4, descripcion: 'OTRO'),
      ];

      listEventosApi.assignAll(tiposEvento);
    } catch (e) {
      DialogosAwesome.getError(descripcion: e.toString());
    } finally {
      cargandoEventosApi.value = false;
    }
  }

  void seleccionarEventoCatalogo(CatalogoModel item) {
    idEventoApiSeleccionado.value = item.id;
    nombreEventoApiSeleccionado.value = item.descripcion;
  }

  void actualizarUbicacionEvento(double lat, double lng) {
    latitudEvento.value = lat;
    longitudEvento.value = lng;
    ubicacionLista.value = true;
  }

  Future<bool> verificarGps() async {
    final bool gpsOk = await gpsController.verificarGPS();

    if (!gpsOk) return false;

    gpsController.iniciarSeguimiento();
    await Future.delayed(const Duration(seconds: 2));

    if (AppConfig.ubicacion.value.latitude == 0.0 &&
        AppConfig.ubicacion.value.longitude == 0.0) {
      gpsController.cancelarSeguimiento();

      DialogosAwesome.getInformationAceptar(
        btnOkOnPress: () => Get.back(),
        descripcion: "Las coordenadas aún no están listas, vuelva a intentar.",
      );
      return false;
    }

    latitudDispositivo.value = AppConfig.ubicacion.value.latitude;
    longitudDispositivo.value = AppConfig.ubicacion.value.longitude;

    if (latitudEvento.value == 0.0 && longitudEvento.value == 0.0) {
      latitudEvento.value = latitudDispositivo.value;
      longitudEvento.value = longitudDispositivo.value;
      ubicacionLista.value = true;
    }

    gpsController.cancelarSeguimiento();
    return true;
  }

  String? validarDescripcion(String? value) {
    final v = (value ?? '').trim();
    if (v.isEmpty) return 'Debe ingresar la descripción del evento';
    if (v.length < 5) return 'Ingrese una descripción más detallada';
    return null;
  }

  String? validarReferencia(String? value) {
    final v = (value ?? '').trim();
    if (v.isEmpty) return 'Debe ingresar una referencia del lugar';
    if (v.length < 5) return 'Ingrese una referencia más detallada';
    return null;
  }

  String? validarSeudonimo(String? value) {
    final v = (value ?? '').trim();
    if (v.isEmpty) return 'Debe ingresar un seudónimo o nombre referencial';
    return null;
  }

  String? validarTelefono(String? value) {
    final v = (value ?? '').trim();
    if (v.isEmpty) return 'Debe ingresar el número telefónico';
    if (!RegExp(r'^\d{10}$').hasMatch(v)) {
      return 'El número telefónico debe tener 10 dígitos';
    }
    return null;
  }

  String? validarCorreo(String? value) {
    final v = (value ?? '').trim();
    if (v.isEmpty) return 'Debe ingresar el correo electrónico';

    final regex = RegExp(r'^[\w\.\-]+@([\w\-]+\.)+[a-zA-Z]{2,}$');
    if (!regex.hasMatch(v)) {
      return 'Correo electrónico inválido';
    }
    return null;
  }

  bool validarFormulario() {
    if (idEventoApiSeleccionado.value == 0 ||
        nombreEventoApiSeleccionado.value.trim().isEmpty) {
      DialogosAwesome.getInformationAceptar(
        descripcion: "Debe seleccionar un tipo de evento.",
        btnOkOnPress: () => Get.back(),
      );
      return false;
    }
    final fechaError = validarFechaEvento();
    if (fechaError != null) {
      DialogosAwesome.getInformationAceptar(
        descripcion: fechaError,
        btnOkOnPress: () => Get.back(),
      );
      return false;
    }
    final descripcionError = validarDescripcion(descripcionController.text);
    if (descripcionError != null) {
      DialogosAwesome.getInformationAceptar(
        descripcion: descripcionError,
        btnOkOnPress: () => Get.back(),
      );
      return false;
    }

    final referenciaError = validarReferencia(referenciaController.text);
    if (referenciaError != null) {
      DialogosAwesome.getInformationAceptar(
        descripcion: referenciaError,
        btnOkOnPress: () => Get.back(),
      );
      return false;
    }

    if (!ubicacionLista.value ||
        latitudEvento.value == 0.0 ||
        longitudEvento.value == 0.0) {
      DialogosAwesome.getInformationAceptar(
        descripcion: "Debe seleccionar la ubicación del evento en el mapa.",
        btnOkOnPress: () => Get.back(),
      );
      return false;
    }

    if (adjuntoSeleccionado.value == null) {
      DialogosAwesome.getInformationAceptar(
        descripcion: "Debe adjuntar una evidencia del evento.",
        btnOkOnPress: () => Get.back(),
      );
      return false;
    }

    final seudonimoError = validarSeudonimo(seudonimoController.text);
    if (seudonimoError != null) {
      DialogosAwesome.getInformationAceptar(
        descripcion: seudonimoError,
        btnOkOnPress: () => Get.back(),
      );
      return false;
    }

    final telefonoError = validarTelefono(telefonoController.text);
    if (telefonoError != null) {
      DialogosAwesome.getInformationAceptar(
        descripcion: telefonoError,
        btnOkOnPress: () => Get.back(),
      );
      return false;
    }

    final correoError = validarCorreo(correoController.text);
    if (correoError != null) {
      DialogosAwesome.getInformationAceptar(
        descripcion: correoError,
        btnOkOnPress: () => Get.back(),
      );
      return false;
    }

    return true;
  }

  Future<void> seleccionarAdjunto() async {
    try {
      cargandoAdjunto.value = true;

      final archivo = await FileAdjuntoHelper.seleccionarArchivo();

      if (archivo != null) {
        adjuntoSeleccionado.value = archivo;

        if (archivo.superaCincoMb) {
          DialogosAwesome.getInformationAceptar(
            descripcion:
            "El archivo seleccionado supera los 5 MB. Se recomienda conectarse a una red Wi-Fi para continuar con el envío.",
            btnOkOnPress: () => Get.back(),
          );
        }
      }
    } catch (e) {
      DialogosAwesome.getError(
        descripcion: "No fue posible seleccionar el archivo: $e",
      );
    } finally {
      cargandoAdjunto.value = false;
    }
  }

  void eliminarAdjunto() {
    adjuntoSeleccionado.value = null;
  }

  Future<bool> crearEvento() async {
    try {
      mensajeError.value = '';
      eventoCreado.value = null;
      peticionServerState(true);

      if (status.value == ConnectionStatus.offline) {
        DialogosAwesome.getInformationAceptar(
          descripcion: "No tiene conexión a internet.",
          btnOkOnPress: () => Get.back(),
        );
        peticionServerState(false);
        return false;
      }

      if (!validarFormulario()) {
        peticionServerState(false);
        return false;
      }

      creandoEvento.value = true;

      final now = DateTime.now().toUtc();
      final deviceData = await DeviceNetworkHelper.getDeviceNetworkData();
      final adjunto = adjuntoSeleccionado.value;

      final EventoEntity evento = EventoEntity(
        idDispositivo: deviceData.idDispositivo,
        tipoEvento: nombreEventoApiSeleccionado.value.trim(),
        fechaEvento: fechaEventoSeleccionada.value!.toUtc().toIso8601String(),
        descripcionEvento: descripcionController.text.trim(),
        referenciaLugar: referenciaController.text.trim(),
        latitudDispositivo: latitudDispositivo.value,
        longitudDispositivo: longitudDispositivo.value,
        latitudEvento: latitudEvento.value,
        longitudEvento: longitudEvento.value,
        nombreSeudonimo: seudonimoController.text.trim(),
        numeroTelefono: telefonoController.text.trim(),
        correoElectronico: correoController.text.trim(),
        urlArchivoRespaldo: null,
        nombreArchivoRespaldo: adjunto?.nombre,
        tipoMimeArchivoRespaldo: adjunto?.mimeType,
        tamanioArchivoRespaldo: adjunto?.tamanioBytes,
        direccionIp:
        "${deviceData.red} - ${deviceData.tipoRed}: ${deviceData.direccionIp}",
        agenteUsuario: "Android",
        estado: "No Verificado",
        fechaCreacion: now.toString(),
        fechaActualizacion: now.toString(),
        archivoAdjunto: adjunto?.file,
      );

      final EventoEntity response =
      await _apiAlertasDelitosRepository.crearEvento(evento);

      eventoCreado.value = response;
      limpiarFormulario();

      peticionServerState(false);

      DialogosAwesome.getSucess(
        title: "Mi UPC",
        descripcion: "Evento registrado correctamente",
        btnOkOnPress: () {
          if (Get.isDialogOpen == true) {
            Get.back();
          }
          Get.offAllNamed(AppRoutes.MENU);
        },
      );

      return true;
    } on ServerException catch (e) {
      peticionServerState(false);
      mensajeError.value = e.cause;
      DialogosAwesome.getError(descripcion: e.cause);
      return false;
    } catch (e) {
      peticionServerState(false);
      mensajeError.value = e.toString();
      DialogosAwesome.getError(descripcion: e.toString());
      return false;
    } finally {
      peticionServerState(false);
      creandoEvento.value = false;
    }
  }

  void limpiarFormulario() {
    descripcionController.clear();
    referenciaController.clear();
    seudonimoController.clear();
    telefonoController.clear();
    correoController.clear();
    idEventoApiSeleccionado.value = 0;
    nombreEventoApiSeleccionado.value = '';
    adjuntoSeleccionado.value = null;
    latitudEvento.value = 0.0;
    longitudEvento.value = 0.0;
    ubicacionLista.value = false;
    _initFechaEvento();
  }

  Future<void> getImei() async {
    try {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        imeiCell = androidInfo.id;
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        imeiCell = iosInfo.identifierForVendor ?? "iOS";
      }
    } catch (_) {}
  }

  Future<void> getTelephonyInfo() async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.mobile) {
        tConexion = "Mobile Data";
      } else if (connectivityResult == ConnectivityResult.wifi) {
        tConexion = "Wifi";
      } else {
        tConexion = "none";
      }
      SSID = (await NetworkInfo().getWifiName()) ?? "none";
    } catch (_) {}
  }

  Future<void> initPlatformDevice() async {
    try {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        modeloCelular = '${androidInfo.manufacturer}-${androidInfo.model}';
        plataforma = 'Android';
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        modeloCelular = '${iosInfo.utsname.machine}-${iosInfo.systemVersion}';
        plataforma = 'iOS';
      }
    } catch (e) {
      print('Error: Failed to get platform version.');
    }
  }

  void mostrarDialogoTerminos(BuildContext context) {
    if (dialogoTerminosMostrado.value) return;

    dialogoTerminosMostrado.value = true;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.dialog(
        PopScope(
          canPop: false,
          child: Dialog(
            insetPadding:
            const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
            backgroundColor: Colors.transparent,
            child: DialogoTerminos1800Delito(),
          ),
        ),
        barrierDismissible: false,
      );
    });
  }

  Future<void> obtenerUbicacionInicial() async {
    try {
      final bool gpsOk = await verificarGps();
      if (!gpsOk) return;

      latitudEvento.value = latitudDispositivo.value;
      longitudEvento.value = longitudDispositivo.value;
      ubicacionLista.value = true;
    } catch (e) {
      print("Error al obtener ubicación inicial: $e");
    }
  }

  void aceptarDialogoTerminos() {
    if (Get.isDialogOpen == true) {
      Get.back();
    }
  }

  void rechazarDialogoTerminos() {
    if (Get.isDialogOpen == true) {
      Get.back();
    }
    Get.back();
  }
  Future<void> tomarFoto() async {
    try {
      cargandoAdjunto.value = true;

      final archivo = await FileAdjuntoHelper.tomarFotoDesdeCamara();

      if (archivo != null) {
        adjuntoSeleccionado.value = archivo;

        if (archivo.superaCincoMb) {
          DialogosAwesome.getInformationAceptar(
            descripcion:
            "El archivo seleccionado supera los 5 MB. Se recomienda conectarse a una red Wi-Fi para continuar con el envío.",
            btnOkOnPress: () => Get.back(),
          );
        }
      }
    } catch (e) {
      DialogosAwesome.getError(
        descripcion: "No fue posible tomar la foto: $e",
      );
    } finally {
      cargandoAdjunto.value = false;
    }
  }

  Future<void> seleccionarDesdeGaleria() async {
    try {
      cargandoAdjunto.value = true;

      final archivo = await FileAdjuntoHelper.seleccionarImagenGaleria();

      if (archivo != null) {
        adjuntoSeleccionado.value = archivo;

        if (archivo.superaCincoMb) {
          DialogosAwesome.getInformationAceptar(
            descripcion:
            "El archivo seleccionado supera los 5 MB. Se recomienda conectarse a una red Wi-Fi para continuar con el envío.",
            btnOkOnPress: () => Get.back(),
          );
        }
      }
    } catch (e) {
      DialogosAwesome.getError(
        descripcion: "No fue posible seleccionar la imagen: $e",
      );
    } finally {
      cargandoAdjunto.value = false;
    }
  }

  Future<void> seleccionarArchivoAdjunto() async {
    try {
      cargandoAdjunto.value = true;

      final archivo = await FileAdjuntoHelper.seleccionarArchivo();

      if (archivo != null) {
        adjuntoSeleccionado.value = archivo;

        if (archivo.superaCincoMb) {
          DialogosAwesome.getInformationAceptar(
            descripcion:
            "El archivo seleccionado supera los 5 MB. Se recomienda conectarse a una red Wi-Fi para continuar con el envío.",
            btnOkOnPress: () => Get.back(),
          );
        }
      }
    } catch (e) {
      DialogosAwesome.getError(
        descripcion: "No fue posible seleccionar el archivo: $e",
      );
    } finally {
      cargandoAdjunto.value = false;
    }
  }
  Future<void> grabarVideo() async {
    try {
      cargandoAdjunto.value = true;

      final archivo = await FileAdjuntoHelper.grabarVideoDesdeCamara();

      if (archivo != null) {
        adjuntoSeleccionado.value = archivo;

        if (archivo.superaCincoMb) {
          DialogosAwesome.getInformationAceptar(
            descripcion:
            "El video seleccionado supera los 5 MB. Se recomienda conectarse a una red Wi-Fi para continuar con el envío.",
            btnOkOnPress: () => Get.back(),
          );
        }
      }
    } catch (e) {
      DialogosAwesome.getError(
        descripcion: "No fue posible grabar el video: $e",
      );
    } finally {
      cargandoAdjunto.value = false;
    }
  }
  Future<void> seleccionarVideoDesdeGaleria() async {
    try {
      cargandoAdjunto.value = true;

      final archivo = await FileAdjuntoHelper.seleccionarVideoGaleria();

      if (archivo != null) {
        adjuntoSeleccionado.value = archivo;

        if (archivo.superaCincoMb) {
          DialogosAwesome.getInformationAceptar(
            descripcion:
            "El video seleccionado supera los 5 MB. Se recomienda conectarse a una red Wi-Fi para continuar con el envío.",
            btnOkOnPress: () => Get.back(),
          );
        }
      }
    } catch (e) {
      DialogosAwesome.getError(
        descripcion: "No fue posible seleccionar el video: $e",
      );
    } finally {
      cargandoAdjunto.value = false;
    }
  }
}