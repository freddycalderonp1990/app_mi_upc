part of '../controllers.dart';

class RegistroUsuarioController extends GetxController {
  final RegistroUsuarioRepository _apiRegistroUsuarioRepository =
  Get.find<RegistroUsuarioRepository>();
  final GpsController gpsController = Get.find<GpsController>();
  final LocalStoreImpl _localStoreImpl = Get.find<LocalStoreImpl>();
  final GoogleAuthService _googleAuthService =
  Get.find<GoogleAuthService>();

  Rx<GaleryCameraModel?> mGaleryCameraModel = Rx<GaleryCameraModel?>(null);
  RxBool peticionServerState = false.obs;
  Rx<Uint8List?> fotoPerfilBytes = Rx<Uint8List?>(null);
  RxBool datosCargados = false.obs;
  RxBool cedulaLista = false.obs;
  RxBool inicializacionCompleta = false.obs;
  RxString metodoRegistro = ''.obs; // '', manual, google, facebook
  RxBool cargandoSocialLogin = false.obs;
  RxBool mostrarFormulario = false.obs;
  RxBool modalSeleccionMostrado = false.obs;

  String proveedorSocial = '';
  String socialId = '';
  String socialToken = '';

  String imeiCell = '';
  String modeloCelular = '';
  String tConexion = 'MOVIL';
  String SSID = 'MOVIL';
  String tipoUsuario = 'NACIONAL';
  String validaMail = 'N';

  final Rxn<AdjuntoModel> adjuntoSeleccionado = Rxn<AdjuntoModel>();
  final RxBool cargandoAdjunto = false.obs;

  final controllerPrimerNombre = TextEditingController();
  final controllerApellido1 = TextEditingController();
  final controllerApellido2 = TextEditingController();
  final controllerCedula = TextEditingController();
  final controllerContacto = TextEditingController();
  final controllerCorreo = TextEditingController();

  final formKeyNacional = GlobalKey<FormState>();
  DeviceInfo? deviceInfo;

  @override
  void onInit() {
    super.onInit();
    getTelephonyInfo();
    getImei();
    initPlatformDevice();
    _init();
  }

  @override
  void onClose() {
    controllerPrimerNombre.dispose();
    controllerApellido1.dispose();
    controllerApellido2.dispose();
    controllerCedula.dispose();
    controllerContacto.dispose();
    controllerCorreo.dispose();
    super.onClose();
  }

  Future<void> _init() async {
    inicializacionCompleta.value = false;
    datosCargados.value = false;
    cedulaLista.value = false;
    mostrarFormulario.value = false;
    modalSeleccionMostrado.value = false;

    await _loadDatosLocales();

    inicializacionCompleta.value = true;
  }

  Future<void> _loadDatosLocales() async {
    final data = await _localStoreImpl.getDatosUsuarioCompleto();

    if (data != null) {
      controllerPrimerNombre.text = (data['nombre'] ?? '').toString();
      controllerApellido1.text = (data['apellido1'] ?? '').toString();
      controllerApellido2.text = (data['apellido2'] ?? '').toString();
      controllerCedula.text = (data['cedula'] ?? '').toString();
      controllerContacto.text = (data['telefono'] ?? '').toString();
      controllerCorreo.text = (data['correo'] ?? '').toString();

      final fotoBase64 = (data['foto'] ?? '').toString();
      if (fotoBase64.isNotEmpty) {
        try {
          fotoPerfilBytes.value = base64Decode(fotoBase64);
        } catch (_) {
          fotoPerfilBytes.value = null;
        }
      } else {
        fotoPerfilBytes.value = null;
      }

      final bool tieneDatos =
          controllerPrimerNombre.text.trim().isNotEmpty ||
              controllerApellido1.text.trim().isNotEmpty ||
              controllerApellido2.text.trim().isNotEmpty ||
              controllerCedula.text.trim().isNotEmpty ||
              controllerContacto.text.trim().isNotEmpty ||
              controllerCorreo.text.trim().isNotEmpty ||
              fotoPerfilBytes.value != null;

      datosCargados.value = tieneDatos;
      cedulaLista.value = controllerCedula.text.trim().isNotEmpty;

      if (tieneDatos) {
        mostrarFormulario.value = true;
        final metodoGuardado = await _localStoreImpl.getMetodoRegistro();
        metodoRegistro.value = (metodoGuardado ?? '').trim();
      } else {
        mostrarFormulario.value = false;
        metodoRegistro.value = '';
      }

      print("✅ Datos cargados localmente desde SharedPreferences");
    } else {
      datosCargados.value = false;
      cedulaLista.value = false;
      mostrarFormulario.value = false;
      metodoRegistro.value = '';
      fotoPerfilBytes.value = null;
    }
  }

  Future<void> _guardarDatosLocales({Uint8List? fotoBytes}) async {
    final Uint8List? fotoFinal = fotoBytes ?? fotoPerfilBytes.value;

    await _localStoreImpl.setDatosUsuarioCompleto(
      nombre: controllerPrimerNombre.text.trim(),
      apellido1: controllerApellido1.text.trim(),
      apellido2: controllerApellido2.text.trim(),
      cedula: controllerCedula.text.trim(),
      telefono: controllerContacto.text.trim(),
      correo: controllerCorreo.text.trim(),
      foto: fotoFinal,
    );

    await _localStoreImpl.setTelefono(controllerContacto.text.trim());
    await _localStoreImpl.setDatosMail(controllerCorreo.text.trim());

    if (fotoFinal != null) {
      await _localStoreImpl.setFoto(fotoFinal);
    }
  }

  void usarRegistroManual() {
    metodoRegistro.value = 'manual';
    proveedorSocial = '';
    socialId = '';
    socialToken = '';
    mostrarFormulario.value = true;
    datosCargados.value = false;
  }

  String? emailValidator(String value) {
    final email = value.trim();
    final regex = RegExp(r'^[\w\.\-]+@([\w\-]+\.)+[a-zA-Z]{2,}$');

    if (email.isEmpty) {
      validaMail = "N";
      return "Ingrese su correo electrónico";
    }

    if (!regex.hasMatch(email)) {
      validaMail = "N";
      return "Correo inválido";
    }

    validaMail = "S";
    return null;
  }

  Future<void> registrarConGoogle() async {
    try {
      cargandoSocialLogin.value = true;

      final credential = await _googleAuthService.signInWithGoogle();
      final user = credential.user;

      if (user == null) {
        throw Exception(
          'No fue posible obtener la cuenta autenticada de Google.',
        );
      }

      limpiarFormulario();

      await _aplicarDatosSociales(
        metodo: 'google',
        id: user.uid,
        token: user.refreshToken ?? '',
        nombres: user.displayName ?? '',
        apellidos: '',
        correo: user.email ?? '',
        fotoUrl: user.photoURL,
      );

      _repartirDisplayName(user.displayName ?? '');

      await _guardarDatosLocales(fotoBytes: fotoPerfilBytes.value);
      await _localStoreImpl.setMetodoRegistro('google');

      datosCargados.value = true;
      mostrarFormulario.value = true;
      cedulaLista.value = controllerCedula.text.trim().isNotEmpty;

      DialogosAwesome.getSucess(
        title: "Mi UPC",
        descripcion: "Datos cargados desde Google correctamente.",
        btnOkOnPress: () async {
          Get.back();
          Get.offAllNamed(AppRoutes.MENU)?.then((_) async {
            final menuCtrl = Get.find<MenuPrincipalController>();
            await menuCtrl._verificaDatos();
            await menuCtrl._cargarFotoPerfil();
          });
        },
      );
    } on FirebaseAuthException catch (e) {
      DialogosAwesome.getError(
        descripcion:
        "Error de autenticación con Google: ${e.message ?? e.code}",
        btnOkOnPress: () => Get.back(),
      );
    } catch (e) {
      DialogosAwesome.getError(
        descripcion: "No fue posible iniciar sesión con Google: $e",
        btnOkOnPress: () => Get.back(),
      );
    } finally {
      cargandoSocialLogin.value = false;
    }
  }

  Future<void> registrarConFacebook() async {
    try {
      cargandoSocialLogin.value = true;

      final Map<String, dynamic> data = await _mockLoginFacebook();

      limpiarFormulario();

      await _aplicarDatosSociales(
        metodo: 'facebook',
        id: data['id'] ?? '',
        token: data['token'] ?? '',
        nombres: data['nombres'] ?? '',
        apellidos: data['apellidos'] ?? '',
        correo: data['correo'] ?? '',
        fotoUrl: data['fotoUrl'],
      );

      await _guardarDatosLocales(fotoBytes: fotoPerfilBytes.value);
      await _localStoreImpl.setMetodoRegistro('facebook');

      datosCargados.value = true;
      mostrarFormulario.value = true;
      cedulaLista.value = controllerCedula.text.trim().isNotEmpty;

      DialogosAwesome.getSucess(
        title: "Mi UPC",
        descripcion: "Datos cargados desde Facebook correctamente.",
        btnOkOnPress: () async {
          Get.back();
          Get.offAllNamed(AppRoutes.MENU)?.then((_) async {
            final menuCtrl = Get.find<MenuPrincipalController>();
            await menuCtrl._verificaDatos();
            await menuCtrl._cargarFotoPerfil();
          });
        },
      );
    } catch (e) {
      DialogosAwesome.getError(
        descripcion: "No fue posible iniciar sesión con Facebook: $e",
        btnOkOnPress: () => Get.back(),
      );
    } finally {
      cargandoSocialLogin.value = false;
    }
  }

  Future<void> _aplicarDatosSociales({
    required String metodo,
    required String id,
    required String token,
    required String nombres,
    required String apellidos,
    required String correo,
    String? fotoUrl,
  }) async {
    metodoRegistro.value = metodo;
    proveedorSocial = metodo.toUpperCase();
    socialId = id;
    socialToken = token;

    if (apellidos.trim().isNotEmpty) {
      if (nombres.trim().isNotEmpty &&
          controllerPrimerNombre.text.trim().isEmpty) {
        controllerPrimerNombre.text = nombres.trim();
      }

      final partes = apellidos.trim().split(' ');
      if (partes.isNotEmpty && controllerApellido1.text.trim().isEmpty) {
        controllerApellido1.text = partes[0];
      }
      if (partes.length > 1 && controllerApellido2.text.trim().isEmpty) {
        controllerApellido2.text = partes.sublist(1).join(' ');
      }
    }

    if (controllerCorreo.text.trim().isEmpty && correo.trim().isNotEmpty) {
      controllerCorreo.text = correo.trim();
    }

    if ((fotoUrl ?? '').trim().isNotEmpty) {
      final bytes = await _descargarImagenComoBytes(fotoUrl!.trim());
      if (bytes != null) {
        fotoPerfilBytes.value = bytes;
      }
    }
  }

  Future<Uint8List?> _descargarImagenComoBytes(String url) async {
    try {
      final uri = Uri.parse(url);
      final response = await NetworkAssetBundle(uri).load("");
      return response.buffer.asUint8List();
    } catch (_) {
      return null;
    }
  }

  Future<Map<String, dynamic>> _mockLoginFacebook() async {
    await Future.delayed(const Duration(milliseconds: 900));
    return {
      "id": "facebook_001",
      "token": "token_facebook_demo",
      "nombres": "Jairo Fernando",
      "apellidos": "Pozo Canacuan",
      "correo": "jairo.demo@facebook.com",
      "fotoUrl": "",
    };
  }

  Future<void> registrarUsuario() async {
    try {
      peticionServerState(true);

      final bool esEdicion = datosCargados.value;
      final bool esManual = metodoRegistro.value == 'manual';
      final bool esSocial = metodoRegistro.value == 'google' ||
          metodoRegistro.value == 'facebook';

      if (!(formKeyNacional.currentState?.validate() ?? false)) {
        peticionServerState(false);
        return;
      }

      if (controllerPrimerNombre.text.trim().isEmpty ||
          controllerApellido1.text.trim().isEmpty ||
          controllerApellido2.text.trim().isEmpty ||
          controllerCedula.text.trim().isEmpty ||
          controllerContacto.text.trim().isEmpty ||
          controllerCorreo.text.trim().isEmpty) {
        DialogosAwesome.getError(
          descripcion: 'Verifique que todos los campos tengan datos',
          btnOkOnPress: () => Get.back(),
        );
        peticionServerState(false);
        return;
      }

      emailValidator(controllerCorreo.text);
      if (validaMail == "N") {
        DialogosAwesome.getError(
          descripcion: 'Correo electrónico no válido',
          btnOkOnPress: () => Get.back(),
        );
        peticionServerState(false);
        return;
      }

      String? datosUsuarioServer;
      int? idUserServer;

      if (!esEdicion && esManual) {
        String ip = await DeviceInfo.getIp;

        String mensaje = await _apiRegistroUsuarioRepository.insertarUsuario(
          tipoUsuario: tipoUsuario,
          latitud: AppConfig.ubicacion.value.latitude,
          longitud: AppConfig.ubicacion.value.longitude,
          mail: controllerCorreo.text.trim(),
          fechaRegistro: MyDate.getFechaActual,
          tipoConexion: tConexion,
          ssIDConexion: SSID,
          numCelular: controllerContacto.text.trim(),
          versionAndroid: imeiCell,
          modeloCelular: modeloCelular,
          cedula: controllerCedula.text.trim(),
          ip: ip,
          primerApellido: controllerApellido1.text.trim(),
          primerNombre: controllerPrimerNombre.text.trim(),
          segundoApellido: controllerApellido2.text.trim(),
        );

        final splitted = mensaje.split('|');

        if (splitted.isNotEmpty && splitted[0] == 'true') {
          if (splitted.length > 1) {
            datosUsuarioServer = splitted[1];
          }
          if (splitted.length > 2) {
            idUserServer = int.tryParse(splitted[2]);
          }
        } else {
          peticionServerState(false);
          DialogosAwesome.getError(
            descripcion: splitted.length > 1
                ? splitted[1]
                : 'No fue posible registrar el usuario. Verifique su Cédula, Nombre y Apellidos',
            btnOkOnPress: () => Get.back(),
          );
          return;
        }
      }

      final bytes = await mGaleryCameraModel.value?.imageFile.readAsBytes();
      if (bytes != null) {
        fotoPerfilBytes.value = bytes;
      }

      await _guardarDatosLocales(fotoBytes: bytes);
      await _localStoreImpl.setMetodoRegistro(metodoRegistro.value);

      if (datosUsuarioServer != null && datosUsuarioServer.isNotEmpty) {
        await _localStoreImpl.setDatosUsuario(datosUsuarioServer);
      }

      if (idUserServer != null) {
        await _localStoreImpl.setIdUser(idUserServer);
      }

      datosCargados.value = true;
      cedulaLista.value = true;
      mostrarFormulario.value = true;

      peticionServerState(false);

      DialogosAwesome.getSucess(
        title: "Mi UPC",
        descripcion: esManual
            ? "Usuario registrado exitosamente."
            : esSocial
            ? "Datos sociales guardados correctamente."
            : "Datos actualizados correctamente.",
        btnOkOnPress: () async {
          Get.offAllNamed(AppRoutes.MENU)?.then((_) async {
            final menuCtrl = Get.find<MenuPrincipalController>();
            await menuCtrl._verificaDatos();
            await menuCtrl._cargarFotoPerfil();
          });
        },
      );
    } catch (e) {
      peticionServerState(false);
      DialogosAwesome.getError(
        descripcion: "Error al guardar datos: $e",
        btnOkOnPress: () => Get.back(),
      );
    }
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
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        modeloCelular = '${iosInfo.utsname.machine}-${iosInfo.systemVersion}';
      }
    } catch (_) {}
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

  String? validarCedula(String? value) {
    final v = (value ?? '').trim();
    if (v.isEmpty) return 'Ingrese su número de cédula';
    if (v.length != 10) return 'La cédula debe tener 10 dígitos';
    if (!RegExp(r'^\d{10}$').hasMatch(v)) return 'La cédula debe ser numérica';
    return null;
  }

  String? validarCelular(String? value) {
    final v = (value ?? '').trim();
    if (v.isEmpty) return 'Ingrese su número de contacto';
    if (v.length != 10) return 'El número debe tener 10 dígitos';
    if (!RegExp(r'^\d{10}$').hasMatch(v)) return 'El número debe ser numérico';
    return null;
  }

  String? validarSoloLetras(String? value, String nombreCampo) {
    final v = (value ?? '').trim();
    if (v.isEmpty) return 'Ingrese $nombreCampo';

    final regex = RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+$');
    if (!regex.hasMatch(v)) {
      return '$nombreCampo solo debe contener letras';
    }
    return null;
  }

  void limpiarFormulario() {
    controllerPrimerNombre.clear();
    controllerApellido1.clear();
    controllerApellido2.clear();
    controllerCedula.clear();
    controllerContacto.clear();
    controllerCorreo.clear();

    mGaleryCameraModel.value = null;
    fotoPerfilBytes.value = null;
    adjuntoSeleccionado.value = null;

    datosCargados.value = false;
    cedulaLista.value = false;
    validaMail = 'N';

    metodoRegistro.value = '';
    mostrarFormulario.value = false;
    proveedorSocial = '';
    socialId = '';
    socialToken = '';
  }

  Future<void> limpiarDatosRegistrados() async {
    try {
      peticionServerState(true);

      await _localStoreImpl.setDatosUsuarioCompleto(
        nombre: '',
        apellido1: '',
        apellido2: '',
        cedula: '',
        telefono: '',
        correo: '',
        foto: null,
      );

      await _localStoreImpl.setTelefono('');
      await _localStoreImpl.setDatosMail('');
      await _localStoreImpl.setDatosUsuario('');
      await _localStoreImpl.setIdUser(0);
      await _localStoreImpl.clearMetodoRegistro();
      await _localStoreImpl.clearFoto();

      limpiarFormulario();

      peticionServerState(false);

      DialogosAwesome.getSucess(
        title: "Mi UPC",
        descripcion:
        "Los datos guardados fueron eliminados correctamente. Ahora puede registrar un nuevo usuario.",
        btnOkOnPress: () => Get.back(),
      );
    } catch (e) {
      peticionServerState(false);
      DialogosAwesome.getError(
        descripcion: "No fue posible limpiar los datos guardados: $e",
        btnOkOnPress: () => Get.back(),
      );
    }
  }

  void _repartirDisplayName(String displayName) {
    final limpio = displayName.trim().replaceAll(RegExp(r'\s+'), ' ');
    if (limpio.isEmpty) return;

    final partes = limpio.split(' ');

    controllerPrimerNombre.clear();
    controllerApellido1.clear();
    controllerApellido2.clear();

    if (partes.length == 1) {
      controllerPrimerNombre.text = partes[0];
      return;
    }

    if (partes.length == 2) {
      controllerPrimerNombre.text = partes[0];
      controllerApellido1.text = partes[1];
      return;
    }

    if (partes.length == 3) {
      controllerPrimerNombre.text = partes[0];
      controllerApellido1.text = partes[1];
      controllerApellido2.text = partes[2];
      return;
    }

    controllerPrimerNombre.text = '${partes[0]} ${partes[1]}';
    controllerApellido1.text = partes[2];
    controllerApellido2.text = partes.sublist(3).join(' ');
  }
}