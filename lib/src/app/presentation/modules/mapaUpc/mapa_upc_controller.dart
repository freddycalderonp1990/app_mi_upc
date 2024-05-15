part of '../controllers.dart';

class MapaUpcController extends GetxController {
  RxBool peticionServerState = false.obs;
  final internetChecker = CheckInternetConnection();
  final GpsController gpsController = Get.find<GpsController>();
  final MiUpcMapaUpcApiImpl _apiMapaUpcRepository =
      Get.find<MiUpcMapaUpcApiImpl>();

  Rx<Upc> listaUpc = Upc(
          descripcionUpc: '',
          dirUpc: '',
          distance: '',
          fonoUpc: '',
          idGenUpc: 0,
          fotoUpc: '',
          latitudUpc: '',
          longitudUpc: '',
          mailUpc: '')
      .obs;
  RxList<Upc> datosUpc = <Upc>[].obs;

  RxString latitude = ''.obs;
  RxString longitude = ''.obs;
  var address = 'Getting Address..'.obs;
  late StreamSubscription<Position> streamSubscription;
  late StreamSubscription connectionSubscription;
  final status = Rx<ConnectionStatus>(ConnectionStatus.online);
  Rx<LatLng> cen = LatLng(0.0, 0.0).obs;

  //RxList<Subcir> datosSubcir = <Subcir>[].obs;
  //configuraciones del mapa
  double latitudMiUbicacion = 0.0, longitudMiUbicacion = 0.0;
  double zoomMap = 15;
  int totalAvazar = 0;
  bool cargarDatos = true;
  double minZoom = 5;
  double maxZoom = 18;
  double sizeBtnSobreMapa = 40;
  var wifiIP = '';
  bool mini = true;
  double padding = 2.0;
  bool btnZoomMas = true;
  bool btnZoomMenos = true;
  Color colorBtnMapa = Colors.blue;
  Color colorBtnRelleno = Colors.white;

  final Rx<LatLng> centroMapa = new LatLng(0.0, 0.0).obs;
  MapController mapController = MapController();

  @override
  void onInit() {
    _init();

    // TODO: el contolloler se ha creado pero la vista no se ha renderizado
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: Donde la vista ya se presento
    // getLocationNueva();
  }

  _init() async {
    print(Get.deviceLocale.toString());
    // getLocation();
    // iniciarSeguimiento1();
    // getLocationNueva();
    consultarUpc();
  }

  consultarUpc() async {
    print('auxilioooo' + AppConfig.ubicacionLista.toString());

    print(
        'auxiliooooeeeeeeeee' + AppConfig.ubicacion.value.latitude.toString());
    if (AppConfig.ubicacionLista.isTrue) {
      getDatosUpc(
          la: AppConfig.ubicacion.value.latitude,
          lo: AppConfig.ubicacion.value.longitude);
      zoomMap = 15;
      mapController.move(
          LatLng(AppConfig.ubicacion.value.latitude,
              AppConfig.ubicacion.value.longitude),
          zoomMap);
    } else {
      gpsController.iniciarSeguimiento();
    }
  }

  getDatosUpc({required double la, required double lo}) async {
    try {
      datosUpc.clear();
      peticionServerState(true);
      datosUpc.value =
          await _apiMapaUpcRepository.buscaDatosUpc(la: la, lo: lo);
      print('----------------------*datosUpc' + datosUpc.toString());
      peticionServerState(false);
    } on ServerException catch (e) {
      peticionServerState(false);
      DialogosAwesome.getError(descripcion: e.cause);
    }
  }

  getBount() {
    LatLngBounds bounds = LatLngBounds(
        LatLng(AppConfig.ubicacion.value.latitude,
            AppConfig.ubicacion.value.longitude),
        LatLng(AppConfig.ubicacion.value.latitude,
            AppConfig.ubicacion.value.longitude));
    for (var i = 0; i < datosUpc.length; i++) {
      var location = LatLng(double.parse(datosUpc[i].latitudUpc),
          double.parse(datosUpc[i].longitudUpc));
      bounds.extend(location);
    }
    mapController.fitBounds(
      bounds,
      options: const FitBoundsOptions(
        padding: EdgeInsets.all(100),
      ),
    );
  }

  connectionStatusController() {
    connectionSubscription = internetChecker
        .internetStatus()
        .listen((newStatus) => status.value = newStatus);
  }
}
