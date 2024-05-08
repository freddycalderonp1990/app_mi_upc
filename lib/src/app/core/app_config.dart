


import 'dart:async';
import 'package:geolocator/geolocator.dart' as myGeolocator;
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:latlong2/latlong.dart';

import '../data/providers/providers_impl.dart';

enum Ambiente { desarrollo, prueba, produccion }

class AppConfig {

  static  String formatoFecha =  'yyyy-MM-dd';
  static  String formatoHora =  'HH:mm';
  static  String formatoSoloHora =  'HH';
  static  String formatoSoloMinuto =  'mm';




  static const double radioBotones = 15.0;
  static const int intentosFallidos = 3;
  static String ambiente = Host.getAmbiente();
  static bool isProduccion=ambiente=='Prod'?true:false;

  static String userTestGoogle='test_google';
  static String passTestGoogle='policiaecuador';
  static String userTestGoogleSiipne='pcjf0401477963';
  static String passTestGoogleSiipne='David2010..';

  static  Ambiente AmbienteUrl=Ambiente.produccion;

  static const String linkAppAndroid =
      "https://play.google.com/store/apps/details?id=siipne3.policia.ecuador.dntic.registro_generales";
  static const String linkAppIos =
      "https://apps.apple.com/ec/app/siipnemovil-2/id1552944115";


  static const double radioBordecajas = 15.0;
  static const double sobraBordecajas = 10.0;

  static const double tamTextoTitulo = 2.0; //tamaño del texto en porcentaje
  static const double tamTexto = 1.5; //tamaño del texto en porcentaje

  static const double anchoContenedor = 90.0;
  static const String SAVE_IMG='cb44971ce0346ab06aae3a677b94be3b';
  static const String MODULO='5b09aa57b4523823e827d8ccc74e26d5';
  static Color? colorBarras = Colors.blue[900];
  static StreamSubscription<myGeolocator.Position>? positionSubscription;
  static Rx<LatLng> ubicacion=new LatLng(0.0,0.0).obs;
  static RxBool errorUbicacion=true.obs;
  static RxBool ubicacionLista=false.obs;
  static const Color colorMarcadorMiUbicacion= Colors.red;
  static const double sizeMarcadorMiUbicacion= 38.0;
  static const IconData iconMarcadorMiUbicacion=Icons.person_pin_circle;

  static const Color colorMarcadorRastro= Colors.black;
  static const double sizeMarcadorRastro= 38.0;
  static const IconData iconMarcadorRastro= Icons.check_circle;
}
