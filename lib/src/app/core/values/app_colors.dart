import 'package:flutter/material.dart' show Color, Colors;

class AppColors{
  static final dark = Color(0xFF03091E);

  static final colorBordecajas = Color(0xFF095FB6);

  //static final colorBotones = Color(0xFF6586EF);

  static const Color colorBotones = AppColors.colorAzul;

  //hexadecimal #164987
  static const int _baseAzul = 0x164987; // Definimos el color base sin opacidad
  static const Color colorAzul = Color(0xFF000000 | _baseAzul);
  static const Color colorAzul_80 = Color(0xCC000000 | _baseAzul);
  static const Color colorAzul_60 = Color(0x99000000 | _baseAzul);
  static const Color colorAzul_40 = Color(0x66000000 | _baseAzul);
  static const Color colorAzul_20 = Color(0x33000000 | _baseAzul);
  static const Color colorAzul_10 = Color(0x1A000000 | _baseAzul);
  static const Color colorAzul_1 = Color(0x03000000 | _baseAzul);
  static const Color colorPrimary = AppColors.colorAzul_1;


  static const Color colorLineas = Color(0xFF9E9D9D);


  static const Color colorAmarilloTitle = Color(0xFFF5C12D);
  static const Color colorAzulTitle = Color(0xFF0A2877);


  static const Color colorBotonesWidget = Colors.lightBlue;
  static const Color colorBordeBotones = Colors.blueAccent;



  static const Color colorFondo = colorAzul;
  static const Color colorIcons = colorAzul;




  //AZUL INSTITUCIONAL SECUNDARIO


  static const int _baseAzulSecond = 0x1A468D; // Definimos el color base sin opacidad

  static const Color colorAzulSecond = Color(0xFF000000 | _baseAzulSecond);
  static const Color colorAzulSecond_80 = Color(0xCC000000 | _baseAzulSecond);
  static const Color colorAzulSecond_60 = Color(0x99000000 | _baseAzulSecond);
  static const Color colorAzulSecond_40 = Color(0x66000000 | _baseAzulSecond);
  static const Color colorAzulSecond_20 = Color(0x33000000 | _baseAzulSecond);


  //PLOMO INSTITUCIONAL

  //hexadecimal #A7A9AC

  static const int _basePlomo = 0xA7A9AC; // Color base sin opacidad

  static const Color colorPlomo = Color(0xFF000000 | _basePlomo);
  static const Color colorPlomo_80 = Color(0xCC000000 | _basePlomo);
  static const Color colorPlomo_60 = Color(0x99000000 | _basePlomo);
  static const Color colorPlomo_40 = Color(0x66000000 | _basePlomo);
  static const Color colorPlomo_20 = Color(0x33000000 | _basePlomo);
  static const Color colorPlomo_10 = Color(0x1A000000 | _basePlomo);
  static const Color colorPlomo_1 = Color(0x03000000 | _basePlomo);

//El valor 0x66 representa la opacidad del 40% (equivalente a 40 en el rango de 0-100).
// El valor A7A9AC corresponde al color RGB (167, 169, 172).
  static const Color colorContenedores = Color(0x66A7A9AC);


  //AMARILLO

  static const int _baseAmarillo = 0xFFD300; // Color base sin opacidad

  static const Color colorAmarillo = Color(0xFF000000 | _baseAmarillo);
  static const Color colorAmarillo_80 = Color(0xCC000000 | _baseAmarillo);
  static const Color colorAmarillo_60 = Color(0x99000000 | _baseAmarillo);
  static const Color colorAmarillo_40 = Color(0x66000000 | _baseAmarillo);
  static const Color colorAmarillo_20 = Color(0x33000000 | _baseAmarillo);
  static const Color colorAmarillo_10 = Color(0x1A000000 | _baseAmarillo);


  //ROJO

  static const int baseRojo = 0xED1C24; // Color base sin opacidad

  static const Color colorRojo = Color(0xFF000000 | baseRojo);
  static const Color colorRojo_80 = Color(0xCC000000 | baseRojo);
  static const Color colorRojo_60 = Color(0x99000000 | baseRojo);
  static const Color colorRojo_40 = Color(0x66000000 | baseRojo);
  static const Color colorRojo_20 = Color(0x33000000 | baseRojo);
  static const Color colorRojo_10 = Color(0x1A000000 | baseRojo);

  //VERDE


  static const int baseVerde = 0x00833E; // Color base sin opacidad

  static const Color colorVerde = Color(0xFF000000 | baseVerde);
  static const Color colorVerde_80 = Color(0xCC000000 | baseVerde);
  static const Color colorVerde_60 = Color(0x99000000 | baseVerde);
  static const Color colorVerde_40 = Color(0x66000000 | baseVerde);
  static const Color colorVerde_20 = Color(0x33000000 | baseVerde);

}
