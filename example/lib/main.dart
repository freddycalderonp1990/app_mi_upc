import 'dart:io';


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
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


    return MainApp();
  }
}
