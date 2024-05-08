import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app/dependency_injection.dart';
import 'app/main_app.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

//cambios
void main() async {
  HttpOverrides.global = MyHttpOverrides();
  DependencyInjectionMiUpc();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MainApp();
  }
}
