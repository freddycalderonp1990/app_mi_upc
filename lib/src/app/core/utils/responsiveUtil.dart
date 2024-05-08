import 'dart:math' as math;

import 'package:get/get.dart';

class ResponsiveUtil {




  double? ancho, alto, diagonal;

  ResponsiveUtil() {

    ancho = Get.width;
    alto = Get.height;
    diagonal = math.sqrt(math.pow(ancho!, 2) + math.pow(alto!, 2));
  }

  double anchoP(double porcentaje) {
    return ancho! * porcentaje / 100;
  }

  double altoP(double porcentaje) {
    return alto! * porcentaje / 100;
  }

  double diagonalP(double porcentaje) {
    return diagonal! * porcentaje / 100;
  }

  bool isHorizontal() {
    bool resul = false;
    if (ancho! > alto!) {
      resul = true;
    }
    return resul;
  }

  bool isVertical() {
    bool resul = false;
    if (alto! > ancho!) {
      resul = true;
    }
    return resul;
  }
}
