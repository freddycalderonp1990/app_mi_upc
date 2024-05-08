import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import '../app/presentation/routes/app_routes.dart';
import '../app/presentation/routes/app_pages.dart';
import 'dependency_injection.dart';

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        textTheme: const TextTheme(
          displayLarge: TextStyle(
              fontSize: 72.0, fontWeight: FontWeight.bold, color: Colors.red),
          titleLarge: TextStyle(
              fontSize: 36.0,
              fontStyle: FontStyle.italic,
              color: Colors.deepOrangeAccent),
          bodyMedium: TextStyle(fontSize: 14.0, color: Colors.black),
        ),
        // Define el Brightness y Colores por defecto
        backgroundColor: Colors.blueAccent,
        // Define la Familia de fuente por defecto
        fontFamily: 'Bookman Old Style',
        // Define el TextTheme por defecto. Usa esto para espicificar el estilo de texto por defecto
        // para cabeceras, títulos, cuerpos de texto, y más.
      ),

      debugShowCheckedModeBanner: false,

      locale: window.locale, // translations will be displayed in that locale
      fallbackLocale: window.locale,
      initialRoute: AppRoutesMiUpc.SPLASH,
      initialBinding: DependencyInjectionMiUpc(),
      getPages: AppPagesMiUpc.pages,
      home: const Scaffold(
        backgroundColor: Colors.blueAccent,
        body: SafeArea(
          child: Center(
            child: Text('AppMiUpc'),
          ),
        ),
      ),
    );
  }
}
