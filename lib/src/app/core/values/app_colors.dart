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

}
