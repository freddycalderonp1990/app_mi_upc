part of '../controllers.dart';

class MenuPrincipalController extends GetxController {
  // ======================= ⚙️ ESTADOS ==========================
  final RxBool peticionServerState = false.obs;
  final Rx<Uint8List?> fotoPerfilBytes = Rx<Uint8List?>(null);
  final RxString userPref = ''.obs;
  final RxString metodoRegistro = ''.obs;
  final CheckInternetConnection internetChecker = CheckInternetConnection();
  late StreamSubscription connectionSubscription;
  final Rx<ConnectionStatus> status = ConnectionStatus.online.obs;
  final RxString correoUsuario = ''.obs;
  final RxString telefonoUsuario = ''.obs;
  // ======================= 🧩 DEPENDENCIAS ======================
  final GpsController gpsController = Get.find<GpsController>();
  final ModulosRepository _apiModulosRepository =
  Get.find<ModulosRepository>();
  final AlertaViolenciaRepository _apiAlertaViolenciaRepository =
  Get.find<AlertaViolenciaRepository>();
  final LocalStoreImpl _localStoreImpl = Get.find<LocalStoreImpl>();

  late String botonAlerta = '';

  // ======================= 🗂️ DATOS ============================
  final RxList<Modulo> listaModulo = <Modulo>[].obs;
  final RxList<Permiso> listaPermiso = <Permiso>[].obs;
  final RxList<Dato> listaPermisoBoton = <Dato>[].obs;
  final RxInt numNotificacion = 0.obs;
  final RxList<ListaAlerta> listaAlertasUsuario = <ListaAlerta>[].obs;

  Rx<Modulo> datosModulos = Modulo(
    descripcionModulo: '',
    imgBase64: '',
    idGenEstado: 0,
    idUpcModulosMovil: 0,
    imagenModulo: '',
    ordenModulo: 0,
    tituloModulo: '',
  ).obs;

  Rx<GaleryCameraModel?> mGaleryCameraModel = Rx<GaleryCameraModel?>(null);

  String acuerdo = "";

  final RxBool tienePermisoAlerta = false.obs;
  final RxBool cargandoPermisoAlerta = false.obs;

  // =============================================================
  // 🔹 CICLO DE VIDA
  // =============================================================
  @override
  void onInit() {
    super.onInit();
    verificaTConexion();
    consultaPermisosBotonAlerta();
    _verificaDatos();
    _cargarFotoPerfil();
    connectionStatusController();
    initPermisosNotificaciones();
    _initNotificaciones();
  }

  @override
  void onReady() {
    super.onReady();
    _init();
    consultaAlertasUsuarioNumero();
  }

  @override
  void onClose() {
    connectionSubscription.cancel();
    internetChecker.close();
    super.onClose();
  }

  // =============================================================
  // 🧠 INICIALIZACIÓN Y CONFIGURACIÓN
  // =============================================================
  Future<void> _init() async {
    await consultaPermisosPolicia();
    await generaToken();
    metodoRegistro.value = (await _localStoreImpl.getMetodoRegistro())!;
    print("🌎 Locale actual: ${Get.deviceLocale}");
  }

  Future<void> _cargarFotoPerfil() async {
    try {

      final bytes = await _localStoreImpl.getFoto();
      if (bytes != null) {
        print("🖼️ Foto de perfil cargada correctamente (${bytes.length} bytes)");
        fotoPerfilBytes.value = bytes;
      } else {
        fotoPerfilBytes.value = null;
        print("⚠️ No se encontró foto de perfil en almacenamiento local.");
      }
    } catch (e) {
      fotoPerfilBytes.value = null;
      print("❌ Error al cargar foto de perfil: $e");
    }
  }


  // =============================================================
  // 🌐 CONTROL DE CONEXIÓN
  // =============================================================
  void connectionStatusController() {
    connectionSubscription =
        internetChecker.internetStatus().listen((newStatus) {
          status.value = newStatus;
        });

    if (status.value == ConnectionStatus.online) {
      verificaTConexion();
    } else {
      _cargarModulosOffline();
    }
  }

  Future<void> verificaTConexion() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        await cargarDatosLista();
      } else {
        await _cargarModulosOffline();
      }
    } on SocketException {
      await _cargarModulosOffline();
    }
  }

  Future<void> _cargarModulosOffline() async {
    final list = await _localStoreImpl.getListModulos();
    listaModulo.value = list;
  }

  // =============================================================
  // 📦 CARGA DE MÓDULOS
  // =============================================================
  Future<void> cargarDatosLista() async {
    try {
      peticionServerState(true);
      listaModulo.clear();

      await consultaPermisosBotonAlerta();

      final lista = await _apiModulosRepository.buscaListaModulos();

      if (lista.isEmpty) {
        await _cargarModulosOffline();
        return;
      }

      final listaFiltrada = lista.where((mod) {
        if (mod.tituloModulo == "ALERTAS TEMPRANAS") {
          return tienePermisoAlerta.value;
        }
        return true;
      }).toList();

      listaModulo.value = listaFiltrada;

      await _localStoreImpl.setDatosListaModulos(
        listModulos: listaFiltrada,
      );
      print('moduloooooooo '+listaModulo[0].descripcionModulo);
      print('moduloooooooo '+listaModulo[1].descripcionModulo);
      print('moduloooooooo '+listaModulo[2].descripcionModulo);
    } on ServerException {
      await _cargarModulosOffline();
    } finally {
      peticionServerState(false);
    }
  }

  // =============================================================
  // 🧍‍♂️ PERMISOS Y ALERTAS
  // =============================================================
  Future<void> consultaPermisosBotonAlerta() async {
    try {
      cargandoPermisoAlerta.value = true;
      final idGenPersona = await _localStoreImpl.getIdUser();

      if (idGenPersona == 0) {
        tienePermisoAlerta.value = false;
        return;
      }

      final resp = await _apiModulosRepository.buscaPermisoBoton(
        idGenPersona: idGenPersona,
        nomApp: "PCQR",
      );

      tienePermisoAlerta.value = (resp.msj.toLowerCase() == "existe");
    } on ServerException {
      tienePermisoAlerta.value = false;
    } catch (_) {
      tienePermisoAlerta.value = false;
    } finally {
      cargandoPermisoAlerta.value = false;
    }
  }

  Future<void> consultaPermisosPolicia() async {
    try {
      final idGenUsuario = await _localStoreImpl.getIdUser();
      if (idGenUsuario == 0) return;

      peticionServerState(true);

      listaPermiso.value = await _apiAlertaViolenciaRepository
          .consultaPermisosPolicia(idGenUsuario);

      if (listaPermiso.isNotEmpty && listaPermiso[0].servicio == "N") {
        AppConfig.servicio.value = false;
      }

      await generaToken();
    } on ServerException {
      await _cargarModulosOffline();
    } finally {
      peticionServerState(false);
    }
  }

  Future<void> consultaAlertasUsuarioNumero() async {
    try {
      final idGenPersona = await _localStoreImpl.getIdUser();
      peticionServerState(true);

      listaAlertasUsuario.value =
      await _apiAlertaViolenciaRepository.consultaListaAlertasUsuario(
        idGenPersona,
      );
    } on ServerException {
      // manejar errores sin interrumpir
    } finally {
      peticionServerState(false);
    }
  }

  // =============================================================
  // 📡 GPS Y UBICACIÓN
  // =============================================================
  Future<void> verificarGps() async {
    final gpsActivo = await gpsController.verificarGPS();
    if (!gpsActivo) return;

    gpsController.iniciarSeguimiento();

    if (AppConfig.ubicacion.value.latitude == 0.0) {
      DialogosAwesome.getInformation(
        descripcion: "Las coordenadas aún no están listas. Vuelva a intentar.",
      );
      return;
    }

    gpsController.cancelarSeguimiento();

    final data = {
      "id": "0",
      "imagen": listaModulo.isNotEmpty ? listaModulo[0].imgBase64 : "",
    };

    Get.toNamed(AppRoutes.MAPAUPC, parameters: data);
  }

  // =============================================================
  // 🔔 NOTIFICACIONES (FCM)
  // =============================================================
  Future<void> initPermisosNotificaciones() async {
    final messaging = FirebaseMessaging.instance;
    final settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("✅ Permisos de notificación concedidos");
      await generaToken();
    } else {
      print("❌ Permisos de notificación denegados");
    }
  }

  Future<void> generaToken() async {
    try {
      final settings = await FirebaseMessaging.instance.requestPermission();

      if (settings.authorizationStatus != AuthorizationStatus.authorized) {
        print("❌ Permisos de notificaciones no autorizados por el usuario.");
        return;
      }

      final token = await FirebaseMessaging.instance.getToken();
      if (token == null) {
        print("⚠️ No se pudo obtener el token FCM.");
        return;
      }

      print("✅ TOKEN FCM: $token");

      if (listaPermiso.isNotEmpty) {
        final idDinUsuariosApp = listaPermiso[0].idDinUsuariosApp;
        await _apiAlertaViolenciaRepository.actualizaTokenUsuario(
          idDinUsuariosApp: idDinUsuariosApp,
          tokenNotificacion: token,
        );
      }
    } catch (e, s) {
      print("🚨 Error generando token FCM: $e\n$s");
    }
  }

  void _initNotificaciones() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final titulo = message.notification?.title ?? "Notificación";
      final cuerpo = message.notification?.body ?? "Nuevo mensaje";
      final data = message.data;

      DialogosAwesome.getSucess(
        btnOkOnPress: () {
          Get.back();
          if (data["tipo"] == "NUEVO_EVENTO") {
            Get.toNamed(AppRoutes.DETALLEALERTAS, parameters: {
              "id": data["idEvento"].toString(),
            });
          }
        },
        title: titulo,
        descripcion: cuerpo,
      );
    });
  }
  String obtenerSaludo() {
    final hora = DateTime.now().hour;

    if (hora >= 5 && hora < 12) {
      return 'Buenos días';
    } else if (hora >= 12 && hora < 18) {
      return 'Buenas tardes';
    } else {
      return 'Buenas noches';
    }
  }
  Map<String, dynamic> getMetodoAuthUI(String metodo) {
    switch (metodo.toLowerCase()) {
      case 'google':
        return {
          'icono': Icons.g_mobiledata_rounded,
          'titulo': 'Autenticado con Google',
          'subtitulo': 'Acceso social seguro',
          'color': const Color(0xFFDB4437),
        };
      case 'facebook':
        return {
          'icono': Icons.facebook_rounded,
          'titulo': 'Autenticado con Facebook',
          'subtitulo': 'Acceso social vinculado',
          'color': const Color(0xFF1877F2),
        };
      default:
        return {
          'icono': Icons.badge_rounded,
          'titulo': 'Registro manual',
          'subtitulo': 'Perfil creado localmente',
          'color': const Color(0xFF00A896),
        };
    }
  }
  Future<void> _verificaDatos() async {
    try {
      acuerdo = await _localStoreImpl.getDatosAcuerdo();

      String nombreCompleto = '';
      try {
        nombreCompleto = await _localStoreImpl.getUserName();
      } catch (_) {
        nombreCompleto = '';
      }

      if (nombreCompleto.trim().isEmpty) {
        final data = await _localStoreImpl.getDatosUsuarioCompleto();
        if (data != null) {
          final nombre = (data['nombre'] ?? '').toString().trim();
          final apellido1 = (data['apellido1'] ?? '').toString().trim();
          final apellido2 = (data['apellido2'] ?? '').toString().trim();

          nombreCompleto = '$nombre $apellido1 $apellido2'
              .replaceAll(RegExp(r'\s+'), ' ')
              .trim();

          correoUsuario.value = (data['correo'] ?? '').toString().trim();
          telefonoUsuario.value = (data['telefono'] ?? '').toString().trim();
        }
      } else {
        final data = await _localStoreImpl.getDatosUsuarioCompleto();
        if (data != null) {
          correoUsuario.value = (data['correo'] ?? '').toString().trim();
          telefonoUsuario.value = (data['telefono'] ?? '').toString().trim();
        }
      }

      userPref.value = nombreCompleto;
      metodoRegistro.value =
          (await _localStoreImpl.getMetodoRegistro() ?? '').trim();

      final bytes = await _localStoreImpl.getFoto();
      if (bytes != null) {
        fotoPerfilBytes.value = bytes;
      }

      print("✅ Nombre cargado en menú: ${userPref.value}");
      print("✅ Correo cargado: ${correoUsuario.value}");
      print("✅ Teléfono cargado: ${telefonoUsuario.value}");
      print("✅ Método de registro: ${metodoRegistro.value}");
    } catch (e) {
      userPref.value = '';
      metodoRegistro.value = '';
      correoUsuario.value = '';
      telefonoUsuario.value = '';
      print("❌ Error en _verificaDatos: $e");
    }
  }
}