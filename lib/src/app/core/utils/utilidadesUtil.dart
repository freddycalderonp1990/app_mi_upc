import 'package:flutter/services.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../presentation/widgets/custom_widgets.dart';


class UtilidadesUtil {

  static Future<String> getVersionCodeNameApp() async {
    String versionName = await getVersionName();
    String versionCode = await getVersionCode();

    String result = versionName + ' - ' + versionCode;

    return result;
  }

  static double redondearDouble(double value,{int decimales=4}){

    String r= value.toStringAsFixed(decimales);

    return double.parse(r);

  }

  static Future<String> getVersionName() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String versionName = packageInfo.version;

    String result = versionName;

    return result;
  }

  static Future<String> getVersionCode() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String versionCode = packageInfo.buildNumber;

    String result = versionCode;

    return result;
  }

  static abrirUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  static void ocultarStatusBar() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);
  }

  static void ocultarStatusBarAll() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  static void mostrarStatusBar() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
  }

  static void statusBarColors({required Color color}) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: color,
      //color barra inferior de navegacion
      // systemNavigationBarColor: Colors.black
    ));
  }
  static String get getFechaActual {
    DateTime today = new DateTime.now();
    String dateSlug =
        "${today.year.toString()}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";
    var arr = dateSlug.split('-');
    final String a = arr[0];
    final String m = arr[1];
    final String d = arr[2];
    DateTime tm = new DateTime(int.parse(a), int.parse(m), int.parse(d));

    return _date(tm);
  }

  static trasnformarFecha(String s) {
    String dato = s.substring(0, 10);
    String hora = s.substring(11, s.length);
    // print(dato);
    var arr = dato.split('-');
    final String a = arr[0];
    final String m = arr[1];
    final String d = arr[2];
    DateTime now = new DateTime(int.parse(a), int.parse(m), int.parse(d));
    String fecha = _date(now);
    print(fecha + "  " + hora);
    return fecha + "\n" + hora;
  }



  static String _date(DateTime tm) {
    String month = "";

    switch (tm.month) {
      case 1:
        month = "Enero";
        break;
      case 2:
        month = "Febrero";
        break;
      case 3:
        month = "Marzo";
        break;
      case 4:
        month = "Abril";
        break;
      case 5:
        month = "Mayo";
        break;
      case 6:
        month = "Junio";
        break;
      case 7:
        month = "Julio";
        break;
      case 8:
        month = "Agosto";
        break;
      case 9:
        month = "Septiembre";
        break;
      case 10:
        month = "Octubre";
        break;
      case 11:
        month = "Noviembre";
        break;
      case 12:
        month = "Diciembre";
        break;
    }

    String dia = "";
    switch (tm.weekday) {
      case 1:
        dia = "Lunes";
        break;
      case 2:
        dia = "Martes";
        break;
      case 3:
        dia = "Miércoles";
        break;
      case 4:
        dia = "Jueves";
        break;
      case 5:
        dia = "Viernes";
        break;
      case 6:
        dia = "Sábado";
        break;
      case 7:
        dia = "Domingo";
        break;
    }
    return "${dia} ${tm.day} de $month del ${tm.year}";
  }

  static const MethodChannel _channel = const MethodChannel('get_mac');

  static Future<String> get macAddress async {
    final String macID = await _channel.invokeMethod('getMacAddress');
    return macID;
  }
  static Future<String> getMac() async{
    String mac='Unknown',imei='Unknown';
    try{
      final String macID = await _channel.invokeMethod('getMacAddress');
      return macID;
    }
    on PlatformException{
      mac='Faild to get Mac';
    }

    return imei;
  }

  static Future<String> getNetworkInfo() async {
    final info = NetworkInfo();

    var wifiName = await info.getWifiName(); // FooNetwork
    var wifiBSSID = await info.getWifiBSSID(); // 11:22:33:44:55:66
    var wifiIP = await info.getWifiIP(); // 192.168.1.43
    var wifiIPv6 =
    await info.getWifiIPv6(); // 2001:0db8:85a3:0000:0000:8a2e:0370:7334
    var wifiSubmask = await info.getWifiSubmask(); // 255.255.255.0
    var wifiBroadcast = await info.getWifiBroadcast(); // 192.168.1.255
    var wifiGateway = await info.getWifiGatewayIP(); // 192.168.1.1

    return wifiIP != null ? wifiIP : 'No se obtuvo la IP';
  }

  static double redondearDecimalesN(double valor, int numDecimales) {
    return double.parse((valor).toStringAsFixed(numDecimales));
  }

  static String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) =>
    '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  static enviarEmail(String texto) async {
    try {
      final Uri _emailLaunchUri = Uri(
        scheme: 'mailto',
        path: 'freddycalderon1990@gmail.com',
        query: encodeQueryParameters(<String, String>{
          'subject': "Appmovil Pagme Información",
          'body': texto,
        }),
      );

      launch(_emailLaunchUri.toString());
    } catch (e) {
      DialogosAwesome.getWarning(descripcion: "No se pudo enviar el email");
    }
  }

  static enviarWts(String texto) async {
    String uri_Wts =
        "https://api.whatsapp.com/send?phone=+593988500896&text=" + texto;
    abrirUrl(uri_Wts);
  }

  static Future<bool> lanzarLlamada(String num) async {
    try {
      launch('tel://$num');
      return true; //donde $phoneNumber es el numero de teléfono que queremos marcar
    } catch (e) {
      DialogosAwesome.getWarning(
          descripcion: "No se pudo realizar la llamada al número:" + num);
      return false;
    }
  }
}
