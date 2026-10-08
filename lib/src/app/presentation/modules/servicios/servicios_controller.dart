part of '../controllers.dart';

class ServiciosController extends GetxController {
  RxBool peticionServerState = false.obs;
  final RxInt selectedIndex = (-1).obs;
  final MenuPrincipalController menuPrincipalController = Get.find<MenuPrincipalController>();
  final RxInt idServicioSeleccionado = 0.obs;

  final GpsController gpsController = Get.find<GpsController>();
  final AlertaViolenciaRepository _apiAlertaViolenciaRepository = Get.find<AlertaViolenciaRepository>();
  final LocalStoreImpl _localStoreImpl = Get.find<LocalStoreImpl>();

  final CheckInternetConnection internetChecker = CheckInternetConnection();
  late StreamSubscription connectionSubscription;

  final Rx<ConnectionStatus> status = ConnectionStatus.online.obs;
  final ServiciosRepository _apiServiciosRepository = Get.find<ServiciosRepository>();
  Rx<Servicio> datosServicios =
      Servicio(
        descripcion: '',
        descTiposervicio: '',
        idUpcServicio: 0,
        imgBase64: '',
        resumen: '',
        urlImagen: '',
      ).obs;
  final pulsado = false.obs;
  RxList<Servicio> listaServicios = <Servicio>[].obs;
  final ItemsRepository _apiItemsRepository = Get.find<ItemsRepository>();
  late final token;
  Rx<Item> datosItemServicios = Item(descripcion: '', idUpcServitems: 0).obs;
  RxList<Item> listaItemsServicios = <Item>[].obs;
  RxList<ItemOffLine> listaItemsServiciosTodos = <ItemOffLine>[].obs;
  String detalle = 'RECUERDE LO SIGUIENTE';
  RxList<String> listaDetalleItemsServicios = <String>[].obs;
  int idGenPersona=0;
  var datosServicio = Get.parameters;
  String imagenModulo = "";
  String nombreModulo = "";
  String fecha = "";
  String estadoConex = "";
  int id = 0;

  @override
  void onInit() {
    cargarDatosLista();
    cargarDatosListaItemsOffline();
    connectionStatusController();
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: Donde la vista ya se presento
    _init();
  }

  _init() async {
    print(Get.deviceLocale.toString());
  }

  @override
  void onClose() {
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
  Future<bool> verificarGps() async {
    bool verificarGps = await gpsController.verificarGPS();
    if (verificarGps) {
      gpsController.iniciarSeguimiento();
      if (AppConfig.ubicacion.value.latitude==0.0) {
        DialogosAwesome.getInformationAceptar(
            btnOkOnPress: (){
              Get.back();
            },
            descripcion: "Las coordenas aun no estan lista vuelva a intentar");
        return false;
      }else{
        gpsController.cancelarSeguimiento();
        return true;
      }
    }
    return false;
  }
  verificaTConexion() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        estadoConex = 'S';
      } else {
        if (id==1){ listaServicios.value = await _localStoreImpl.getListServiciosPoli();}
        if (id==2){listaServicios.value = await _localStoreImpl.getListServicios();}
        listaItemsServiciosTodos.value = await _localStoreImpl.getListItems();
      }
    } on SocketException catch (_) {
      if (id==1){ listaServicios.value = await _localStoreImpl.getListServiciosPoli();}
      if (id==2){listaServicios.value = await _localStoreImpl.getListServicios();}
      listaItemsServiciosTodos.value = await _localStoreImpl.getListItems();
      estadoConex = 'N';
    }
  }

  cargarDatosLista() async {
    try {
      id = int.parse(datosServicio['id'].toString());
      imagenModulo = datosServicio['imagen'].toString();
      nombreModulo=datosServicio['nombreModulo'].toString();
      fecha = 'Hoy es ${UtilidadesUtil.getFechaActual}';
      listaServicios.clear();
      peticionServerState(true);
      idGenPersona = await _localStoreImpl.getIdUser();
      listaServicios.value = await _apiServiciosRepository.buscaListaServicios(
        id,
      );
      if (listaServicios.isNotEmpty && listaServicios[0].idUpcServicio == 2) {
        detalle = 'COMO ACCEDER A ESTE SERVICIO';
      }

      if (listaServicios.isEmpty) {
        if (id==1){ listaServicios.value = await _localStoreImpl.getListServiciosPoli();}
        if (id==2){listaServicios.value = await _localStoreImpl.getListServicios();}
        return;
      }
      if (id == 1) {
        await _localStoreImpl.setDatosListaServiciosPoli(
          listServiciosPoli: listaServicios,
        );
      }
      if (id == 2) {
        await _localStoreImpl.setDatosListaServicios(
          listServicios: listaServicios,
        );
      }

      peticionServerState(false);
    } on ServerException catch (e) {
      peticionServerState(false);
      if (id==1){ listaServicios.value = await _localStoreImpl.getListServiciosPoli();}
      if (id==2){listaServicios.value = await _localStoreImpl.getListServicios();}


    }
  }

  cargarDatosDetalleLista(int id) async {
    try {
      listaItemsServicios.clear();
      peticionServerState(true);
      listaItemsServicios.value = await _apiItemsRepository.buscaDatosItem(id);
      peticionServerState(false);
    } on ServerException catch (e) {
      peticionServerState(false);
      DialogosAwesome.getError(descripcion: e.cause);
    }
  }

  cargarDatosListaItemsOffline() async {
    try {
      listaItemsServiciosTodos.clear();
      peticionServerState(true);

      listaItemsServiciosTodos.value =
          await _apiItemsRepository.buscaDatosItemsOffline();
      if (listaItemsServiciosTodos.isEmpty) {
        listaItemsServiciosTodos.value = await _localStoreImpl.getListItems();
        peticionServerState(false);
        return;
      }
      await _localStoreImpl.setDatosListaItems(
        listItems: listaItemsServiciosTodos.value,
      );
      peticionServerState(false);
    } on ServerException catch (e) {
      peticionServerState(false);
      var list = await _localStoreImpl.getListItems();
      listaItemsServiciosTodos.value = list;
    }
  }

  cargarDatosDetalleListaOffLine(int id) async {
    try {
      listaItemsServicios.clear();
      listaItemsServiciosTodos.clear();
      listaItemsServiciosTodos.value = await _localStoreImpl.getListItems();
      peticionServerState(true);
      for (var i = 0; i < listaItemsServiciosTodos.length; i++) {
        if (listaItemsServiciosTodos[i].idUpcServicio == id) {
          listaItemsServicios.add(
            Item(
              descripcion: listaItemsServiciosTodos[i].descripcion,
              idUpcServitems: listaItemsServiciosTodos[i].idUpcServitems,
            ),
          );
        }
      }
      peticionServerState(false);
    } on ServerException catch (e) {
      peticionServerState(false);
    }
  }

  inicioServicioUsuario() async{
    try {
      bool verificaGps =await verificarGps();
      if (!verificaGps){
        return;
      }
      peticionServerState(true);
      String ip= await DeviceInfo.getIp;
      await generaTokenUsuario();
      int idDinUsuariosApp= menuPrincipalController.listaPermiso[0].idDinUsuariosApp;

      DinUsuarioTurnosApp turnosApp= await _apiAlertaViolenciaRepository.inicioServicio(
          idDinUsuariosApp: idDinUsuariosApp,
          latitud: AppConfig.ubicacion.value.latitude,
          longitud: AppConfig.ubicacion.value.longitude,
          token: token,
          ip: ip);


      if (turnosApp.codeError!=0){
        DialogosAwesome.getWarning(descripcion: turnosApp.msj.toString());
        peticionServerState(false);
      }else{
        AppConfig.servicio.value=true;
       await generaTokenUsuario();
        DialogosAwesome.getSucess(descripcion: "Servicio Iniciado Correctamente\n Recuerde en su TURNO, "
            "usted será el responsable de atender las notificaciones que se registren en el aplicativo");
      }
      peticionServerState(false);
    } on ServerException catch (e) {
      DialogosAwesome.getError(descripcion: e.cause);
      peticionServerState(false);
    }
  }
  Future<void> generaTokenUsuario() async {
    try {
      final settings = await FirebaseMessaging.instance.requestPermission();
      if (settings.authorizationStatus != AuthorizationStatus.authorized) {
        print("❌ Permisos de notificaciones no autorizados por el usuario.");
        return;
      }
       token = await FirebaseMessaging.instance.getToken();
      if (token == null) {
        print("⚠️ No se pudo obtener el token FCM.");
        return;
      }
      print("✅ TOKEN FCM: $token");
    } catch (e, s) {
      print("🚨 Error generando token FCM: $e\n$s");
    }
  }
}
