//en esta pantalla se encarga de escuchar cualdo el usaurio activa el gps y
//redireccionarlo a al pantalla que necesite usar gps

// se encarga de verificar y redireccionar segun los permisos a la pantalla que le corresponde

part of 'gps_impl_helper.dart';

//Pantalla 1, es la primera en llamarse
//Se encarga de verificar si el usuario ya dio los permisos correspondientes al GPS
//y si la ubicacion esta activada

//Si esta activo se muestra la pantalla que necesita usar el GPS
//Caso contrario se redirecciona a la pantalla donde solicita los permisos o activar el GPS



class GpsVerificatePage extends GetView<GpsController>  with WidgetsBindingObserver  {
  final String? pantalla;
  final bool btnAtras;
  final imgFondo;
  final Route<Object?>? pantallaIrAtras;


  final bool cerrarTodasPantallas;

  GpsVerificatePage(
      {Key? key,
      this.pantalla,
      this.cerrarTodasPantallas = false,
      this.btnAtras = true,
      this.imgFondo = null,
      this.pantallaIrAtras})
      : super(key: key);

  //CONFIGURACIONES
  final anchoContenedor = AppConfig.anchoContenedor;


  RxString msj=''.obs;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    //super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    //super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if(pantalla!=null) {
      if (state == AppLifecycleState.resumed) {
        if (await myGeolocator.Geolocator.isLocationServiceEnabled()) {
          if (cerrarTodasPantallas) {
            Get.offAllNamed(pantalla!);
          } else {
            Get.toNamed(pantalla!);
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtil();

    return Container();

  }

  Future<String> verificarGps() async {
    String result = await controller.checkPermisosGpsActivated();
    print("result ${result}");
    if (result == "true") {
      if(pantalla==null){
        return "Pagina no implementada";
      }
      Get.offAllNamed(pantalla!);
      return result;
    } else {
      return result;
    }


  }
}
