import 'dart:developer';


import '../app_config.dart';

class PrintsMsj{

  static void myLog({
    String tag='',
    required String title, required String detalle }){

    if(AppConfig.AmbienteUrl!=Ambiente.produccion){
      log("${tag}-${title}: ${detalle}");
    }
    else{
     // log("${tag}-${title}: Prod-off");
      log("${tag}-${title}: ${detalle}");
    }

  }
}