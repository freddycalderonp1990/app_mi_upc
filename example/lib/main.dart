import 'dart:io';


import 'package:app_mi_upc/app_mi_upc.dart';
import 'package:flutter/material.dart';

import '../app/dependency_injection_app.dart';

import 'app/main_app.dart';


//solucion:OS Error:   CERTIFICATE_VERIFY_FAILED
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}


void main() {
  HttpOverrides.global = new MyHttpOverrides();
  DependencyInjectionApp();
  AppRoutesMiUpc.setNameMenu(name: "Mi Menú");
  //AppRoutesMiUpc.setPageInicio(AppRoutesMiUpc.ACUERDO);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


    return MainApp();
  }
}
