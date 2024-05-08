import 'dart:async';

import 'package:geolocator/geolocator.dart' as myGeolocator;
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:latlong2/latlong.dart';
import '../../presentation/widgets/custom_widgets.dart';
import '../app_config.dart';


class MyGps{


static myGeolocator.LocationSettings get getConfig{
  final myGeolocator.LocationSettings locationSettings = myGeolocator.LocationSettings(
    accuracy: myGeolocator.LocationAccuracy.high,
    distanceFilter: 50,
  );

  return locationSettings;

}

 static Future<bool> verificarGPS() async{
   cancelarSeguimiento();
   AppConfig.ubicacionLista.value=false;
    // PermisoGPS verifica si el usuario ya dio permisos
    bool permisoGPS = await Permission.location.isGranted;
    //True el usuario dio permisos

    if(!permisoGPS){
      String msj="Necesitamos acceder a la ubicación del Dispositivo.\n\n Por favor active los Permisos de la Ubicación";
      DialogosAwesome.getWarning(descripcion: msj,btnOkOnPress: ()async{
        permisoGPS=await _checkGpsPermisoStatus2();
      });
      return false;
    }

    //verificamos que el GPS del dispositivo este encendido
    final gpsActivo = await myGeolocator.Geolocator.isLocationServiceEnabled();
    if(!gpsActivo){
      String msj= "Necesitamos acceder a la ubicación del Dispositivo.\n\n Por favor active el GPS - Ubicación  de su dispositivo";
      DialogosAwesome.getWarning(descripcion: msj,btnOkOnPress: (){
        Get.back();

      });
      return false;
    }

    if(permisoGPS && gpsActivo  ){
      return true;
    }
    else{
      DialogosAwesome.getError(descripcion: "No se puede obtener información del GSP. Es necesario los permisos del Gps para continuar",title: "Error Gps");
      return false;
    }

  }

 static Future<bool> _checkGpsPermisoStatus2( ) async {
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


 static Future iniciarSeguimiento() async {

    bool gpsListo=await verificarGPS();
    if(!gpsListo){
      return;
    }

   if (AppConfig.positionSubscription == null) {

     print("iniciarSeguimiento");


     final positionStream =myGeolocator.Geolocator.getPositionStream(locationSettings: MyGps.getConfig
     );
     AppConfig.positionSubscription = positionStream.handleError((error) {
       print("tcambia ubicacion ${error}");
       AppConfig.positionSubscription!.cancel();
       AppConfig.positionSubscription = null;

     }).listen((position) {
       AppConfig.ubicacion.value=  LatLng(position.latitude, position.longitude);
       print("cambia ubicacion ${AppConfig.ubicacion.value.latitude}, ${AppConfig.ubicacion.value.longitude}");
       AppConfig.ubicacionLista.value=true;
     });

   }


 }

 static void cancelarSeguimiento() {

   AppConfig.positionSubscription?.cancel();
   AppConfig.positionSubscription=null;
 }
}