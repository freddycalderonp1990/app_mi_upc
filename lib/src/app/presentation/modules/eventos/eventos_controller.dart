part of '../controllers.dart';

class EventosController extends GetxController {
  RxBool peticionServerState = false.obs;
  final MenuPrincipalController menuPrincipalController=Get.find();
  final GpsController gpsController = Get.find<GpsController>();

String nombreModulo='';
  final ServiciosRepository _apiServiciosRepository = Get.find();
  final AlertaViolenciaRepository _apiAlertaViolenciaRepository = Get.find();
  final RxBool btnPressed = false.obs;

  final CheckInternetConnection internetChecker = CheckInternetConnection();
  late StreamSubscription connectionSubscription;

  final Rx<ConnectionStatus> status = ConnectionStatus.online.obs;


  final SaveFileImgUseCase _saveFileImgUseCase = Get.find();
  final TextEditingController descripcionController = TextEditingController();
  Rx<GaleryCameraModel?> mGaleryCameraModel = Rx<GaleryCameraModel?>(null);
  Rx<Servicio> datosEventos =
      Servicio(
        descripcion: '',
        descTiposervicio: '',
        idUpcServicio: 0,
        imgBase64: '',
        resumen: '',
        urlImagen: '',
      ).obs;
  RxList<Servicio> listaEventos = <Servicio>[].obs;

  Rx<Item> datosItemEventos = Item(descripcion: '', idUpcServitems: 0).obs;
  RxList<Item> listaItemsEventos = <Item>[].obs;
  String detalle = 'RECUERDE LO SIGUIENTE';
  RxList<String> listaDetalleItemsEventos = <String>[].obs;

  RxList<Catalogo> listDelito = <Catalogo>[].obs;
  RxInt idDelitoSeleccionado = 0.obs;
  RxString nombreDelitoSeleccionado = "".obs;
  RxString selectDelito = "".obs;
  RxBool mostrarBtnGuardar = false.obs;



  var datosServicio = Get.parameters;
  String imagenModulo = "";
  String fecha = "";
  String estadoConex = "";
  int id = 0;
  final LocalStoreImpl _localStoreImpl = Get.find<LocalStoreImpl>();

  final formKey = GlobalKey<FormState>();
  var controllerObservacion = new TextEditingController();

  @override
  void onInit() {
    super.onInit();
    imagenModulo = datosServicio['imagen'].toString();
    nombreModulo=datosServicio['nombreModulo'].toString();
    consultaDatosCatalogoAlerta();
    connectionStatusController();

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
  consultaDatosCatalogoAlerta() async {
    try {
      listDelito.clear();
      peticionServerState(true);
      List<Catalogo> catalogos =
      await _apiAlertaViolenciaRepository.consultaCatalogos(1);
      listDelito.assignAll(catalogos); // ✅ ahora guarda los objetos completos
      peticionServerState(false);
    } on ServerException catch (e) {
      peticionServerState(false);
      DialogosAwesome.getError(descripcion: e.cause);
    }
  }

  guardarEvento(int idDinCatalogosApp) async {
    bool verificaGps = await verificarGps();
    if (!verificaGps) return;

    if (descripcionController.text.trim().isEmpty) {
      DialogosAwesome.getWarning(
        btnOkOnPress: () {},
        descripcion: 'Registre una Observación',
      );
      return;
    }

    try {
      peticionServerState(true);
      // 🔹 Datos base para guardar imagen
      String path = dotenv.env['PATH_IMG_ALERTAS'] ?? '';
      String nameFile = "eventos";
      String? nameCompletoImg = "";

      // 🔸 Si el usuario seleccionó imagen, guardarla
      if (mGaleryCameraModel.value != null &&
          mGaleryCameraModel.value!.imageFile != null) {
        FileRequest request = FileRequest(
          file: mGaleryCameraModel.value!.imageFile,
          path: path,
          nameFile: nameFile,
        );

        bool insertImg = await _saveFileImgUseCase(request: request);
        if (!insertImg) {
          DialogosAwesome.getWarning(
            title: "Guardar Imagen",
            descripcion: "No se pudo guardar la Imagen",
            btnOkOnPress: () => Get.back(),
          );
          peticionServerState(false);
          return;
        }

        nameCompletoImg = "${nameFile}_${mGaleryCameraModel.value!.nombreImg}";
      }



      // 🔹 Datos del usuario
      int idGenPersona = await _localStoreImpl.getIdUser();
      //int idUsuarioApp = menuPrincipalController.listaPermiso[0].idDinUsuariosApp;
      String ip = await DeviceInfo.getIp;

      // 🚀 Registrar evento en la API
      DinAlertaApp resultInsert = await _apiAlertaViolenciaRepository.registrarEvento(
        idGenPersona: idGenPersona,
        idDinCatalogosApp: idDinCatalogosApp,
        latitud: AppConfig.ubicacion.value.latitude,
        longitud: AppConfig.ubicacion.value.longitude,
        observacion: descripcionController.text.trim(),
        imagenAlerta: nameCompletoImg ?? '',
        usuario: idGenPersona,
        ip: ip,
      );

      // 📋 Validar respuesta
      final idAlerta = int.tryParse(resultInsert.alertas.idDinAlertaApp ?? '0') ?? 0;
      if (idAlerta > 0) {
        DialogosAwesome.getSucess(
          title: "REGISTRO CORRECTO",
          descripcion: 'Evento registrado correctamente',
          btnOkOnPress: () {
            peticionServerState(false);
            Get.back();
            Get.back();
          },
        );

      } else {
        DialogosAwesome.getWarning(
          descripcion: "No se pudo registrar la alerta. Intente nuevamente.",
        );
        peticionServerState(false);
      }
    } on ServerException catch (e) {
      peticionServerState(false);
      DialogosAwesome.getError(descripcion: e.cause);
    } catch (e, s) {
      peticionServerState(false);
      debugPrint("❌ Error inesperado en guardarEvento: $e\n$s");
      DialogosAwesome.getError(descripcion: "Error inesperado: ${e.toString()}");
    }
  }



}

