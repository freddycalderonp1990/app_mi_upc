part of 'gps_impl_helper.dart';

class GpsController extends GetxController {

  StreamSubscription<myGeolocator.Position>? positionSubscription;
  Rx<LatLng> ubicacion=new LatLng(0.0,0.0).obs;
  var obteniendoUbicacion = false.obs;
  var ubicacionLista = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
print("onInit gps");
    ubicacionLista.value=true;
    super.onInit();
  }

  Future<bool> verificarGPS() async{
    // PermisoGPS verifica si el usuario ya dio permisos
    bool permisoGPS = await Permission.location.isGranted;
    //True el usuario dio permisos

    if(!permisoGPS){
      String msj="Necesitamos acceder a la ubicación del Dispositivo.\n\n Para que puedas ver las Unidades de Policia Comunitaria";
      DialogosAwesome.getWarning(descripcion: msj,btnOkOnPress: ()async{
        permisoGPS=await checkGpsPermisoStatus2();
      });
    }

    //verificamos que el GPS del dispositivo este encendido
    final gpsActivo = await myGeolocator.Geolocator.isLocationServiceEnabled();
    if(!gpsActivo){
      String msj="Necesitamos acceder a la ubicación del Dispositivo.\n\n Para que puedas ver las Unidades de Policia Comunitaria";
      DialogosAwesome.getWarning(descripcion: msj,btnOkOnPress: (){

      });
    }

    if(permisoGPS && gpsActivo  ){
      return true;
    }
    else{
      return false;
    }

  }

  //Verifica si tiene los Permisos y el GPS Activo
  Future<String> checkPermisosGpsActivated() async {
    // PermisoGPS verifica si el usuario ya dio permisos
    final permisoGPS = await Permission.location.isGranted;


    // GPS está activo verifica si el gps del dispositivo se encuentra activo
    final gpsActivo = await myGeolocator.Geolocator.isLocationServiceEnabled();

    if (permisoGPS && gpsActivo) {
      DialogosAwesome.getError(descripcion: "todo ok");
      return "true";
    } else if (!permisoGPS) {

      String msj="Necesitamos acceder a la ubicación del Dispositivo.\n\n Para que puedas ver las Unidades de Policia Comunitaria";
      DialogosAwesome.getWarning(descripcion: msj,btnOkOnPress: (){
        checkGpsPermisoStatus( "aaa");
      });
      return msj;
    } else {


      String msj="Necesitamos acceder a la ubicación del Dispositivo.\n\n Para que puedas ver las Unidades de Policia Comunitaria";
      DialogosAwesome.getError(descripcion: msj);
      return msj;
    }
  }

  Future<bool> checkGpsPermisoStatus2( ) async {
    final status = await Permission.location.request();

    bool result=false;
    switch (status) {
      case PermissionStatus.granted:
      // GPS está activo verifica si el gps del dispositivo se encuentra activo
        final gpsActivo = await myGeolocator.Geolocator.isLocationServiceEnabled();
        result= true;

        break;

      case PermissionStatus.limited:
      //indeterminado

      case PermissionStatus.denied:
      //denegado

      case PermissionStatus.restricted:
      //restringida

      case PermissionStatus.permanentlyDenied:
        //permisos denegas por completo
        //Redirecciona al usuario para que de manuera manual asigne los permisos
       result= await  openAppSettings();
      case PermissionStatus.provisional:
        // TODO: Handle this case.
    }

    return result;
  }


  Future checkGpsPermisoStatus( String pantalla) async {
    final status = await Permission.location.request();

    switch (status) {
      case PermissionStatus.granted:
      // GPS está activo verifica si el gps del dispositivo se encuentra activo
        final gpsActivo = await myGeolocator.Geolocator.isLocationServiceEnabled();
        print(status);
        print(gpsActivo);
        if(gpsActivo) {
          //aceptado
          Get.offAllNamed(pantalla);
        }

        break;

      case PermissionStatus.limited:
      //indeterminado

      case PermissionStatus.denied:
      //denegado

      case PermissionStatus.restricted:
      //restringida

      case PermissionStatus.permanentlyDenied:
      //permisos denegas por completo
      //Redirecciona al usuario para que de manuera manual asigne los permisos
        openAppSettings();
      case PermissionStatus.provisional:
        // TODO: Handle this case.
    }
  }

  Future iniciarSeguimiento() async {
    print("iniciarSeguimiento ${ ubicacion.value.longitude}");
    if (this.positionSubscription == null) {
      obteniendoUbicacion(true);
      print("iniciarSeguimiento");
      final positionStream =myGeolocator.Geolocator.getPositionStream( locationSettings: MyGps.getConfig
      );
      this.positionSubscription = positionStream.handleError((error) {
        print("tcambia ubicacion ${error}");
        this.positionSubscription!.cancel();
        this.positionSubscription = null;
        obteniendoUbicacion(false);
      }).listen((position) {
        AppConfig.ubicacion.value = LatLng(position.latitude, position.longitude);
        AppConfig.ubicacionLista.value=true;
         ubicacion.value=  LatLng(position.latitude, position.longitude);
         print("cambia ubicacion ${ubicacion.value.latitude}, ${ubicacion.value.longitude}");
         ubicacionLista.value=true;
         ubicacionLista.refresh();
         ubicacion.refresh();
         obteniendoUbicacion(false);
      });

    }


  }

  void cancelarSeguimiento() {
    this.positionSubscription?.cancel();
    this.positionSubscription=null;
  }
}
