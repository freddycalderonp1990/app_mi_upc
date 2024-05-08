part of '../controllers.dart';

class ServiciosController extends GetxController {
  RxBool peticionServerState = false.obs;

  late StreamSubscription connectionSubscription;
  final status = Rx<ConnectionStatus>(ConnectionStatus.online);

  final ServiciosApiImpl _apiServiciosRepository = Get.find<ServiciosApiImpl>();
  Rx<Servicio> datosServicios =  Servicio(descripcion: '',descTiposervicio: '',idUpcServicio: 0,imgBase64: '',resumen: '',urlImagen: '').obs;
  RxList<Servicio>listaServicios =<Servicio>[].obs;
  final ItemsApiImpl _apiItemsRepository = Get.find<ItemsApiImpl>();
  Rx<Item> datosItemServicios =  Item(descripcion: '',idUpcServitems: 0).obs;
  RxList<Item>listaItemsServicios =<Item>[].obs;
String detalle='RECUERDE LO SIGUIENTE';
  RxList<String>listaDetalleItemsServicios =<String>[].obs;

  var datosServicio = Get.parameters;
  String fecha="";
  String estadoConex = "";
  int id = 0;
  @override
  void onInit() {
    cargarDatosLista();
    // TODO: el contolloler se ha creado pero la vista no se ha renderizado
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



  connectionStatusController() {
    connectionSubscription = internetChecker.internetStatus().listen((newStatus) => status.value = newStatus);
  }

  verificaTConexion() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        estadoConex = 'S';
        print('connected');
      }
    } on SocketException catch (_) {
      estadoConex = 'N';
      DialogosAwesome.getInformation(descripcion: 'Usuario no ha registrado datos en el intervalo de fecha seleccionado');
    }
  }


  cargarDatosLista() async {
    try {
      id=int.parse(datosServicio['id'].toString());
      print('sssssssssssss--'+id.toString());
      fecha= 'Hoy es ${UtilidadesUtil.getFechaActual}';
      listaServicios.clear();
      peticionServerState(true);
      listaServicios.value= await _apiServiciosRepository.buscaListaServicios(id);
      print('----------------------*$listaServicios');
      if (listaServicios.isNotEmpty && listaServicios[0].idUpcServicio==2){
        detalle='COMO ACCEDER A ESTE SERVICIO';

      }
      peticionServerState(false);
    } on ServerException catch (e) {
      peticionServerState(false);
      DialogosAwesome.getError(descripcion: e.cause);
    }
  }
  cargarDatosDetalleLista(int id) async {
    try {
      listaItemsServicios.clear();
      peticionServerState(true);
      listaItemsServicios.value= await _apiItemsRepository.buscaDatosItem(id);
      print('----------------------*'+listaItemsServicios.length.toString());

      peticionServerState(false);
    } on ServerException catch (e) {
      peticionServerState(false);
      DialogosAwesome.getError(descripcion: e.cause);
    }
  }

    getDatosListaItems (int id){
      if (listaItemsServicios.isNotEmpty){

        for (int i = 0; i < listaItemsServicios.length; i++) {
          listaDetalleItemsServicios.add(listaItemsServicios[i].descripcion);
        }
      }

    }
}