import 'package:intl/intl.dart';
import '../../../app/core/app_config.dart';

class MyDate{

  static String get getFechaHoraActual {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('${AppConfig.formatoFecha} ${AppConfig.formatoHora}').format(now);

    return formattedDate;
  }

  static String get getFechaActual {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat(AppConfig.formatoFecha).format(now);

    return formattedDate;
  }


  static String setFormatFechaString( String fechaString) {
    try {
      DateTime fecha = DateTime.parse(fechaString);

      String formattedDate = DateFormat(AppConfig.formatoFecha).format(fecha);

      return formattedDate;
    }
    catch(e){
      return "0000-00-00";
    }
  }

  static String setFormatFecha( DateTime fecha) {

    String formattedDate = DateFormat(AppConfig.formatoFecha).format(fecha);

    return formattedDate;
  }


  static String  getDia(DateTime fecha){
    String dia='';
    switch (fecha.weekday) {
      case 1://LUNES
        dia = "Lunes";
        break;
      case 2://MARTES
        dia = "Martes";
        break;
      case 3://MIERCOLES
        dia = "Miércoles";
        break;
      case 4://JUEVES
        dia = "Jueves";
        break;
      case 5://VIERNES
        dia = "Viernes";
        break;
      case 6://SABADO
        dia = "Sábado";
        break;
      case 7://DOMINGO
        dia = "Domingo";
        break;
    }

    return dia;

  }
}