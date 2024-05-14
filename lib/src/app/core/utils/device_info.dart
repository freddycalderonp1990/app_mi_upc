import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:device_information/device_information.dart'; //Imei
import 'package:network_info_plus/network_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../app/core/utils/utilidadesUtil.dart';
import '../../presentation/widgets/custom_widgets.dart';
import 'my_date.dart';

class DeviceInfo {
  static Future<String> get getTipoConexion async {
    String tipo = "OTRO";

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      tipo = "MOVIL";
    } else if (connectivityResult == ConnectivityResult.wifi) {
      tipo = "WIFI";
    } else if (connectivityResult == ConnectivityResult.ethernet) {
      tipo = "ETHERNET";
    } else if (connectivityResult == ConnectivityResult.none) {
      tipo = "NINGUNO";
    }

    return "TIPO DE RED - " + tipo;
  }

  static Future<bool> get getExisteConexion async {
    bool resul = false;

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.ethernet) {
      try {
        final result = await InternetAddress.lookup('siipne.policia.gob.ec');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          resul = true;
          print(result);
          print("tengo intenet");
        }
      } on SocketException catch (_) {
        print("no hay");

        DialogosAwesome.getWarning(
            descripcion:
                "No Existe Conexión a Internet, asegurese de estar conectado a una red wifi o plan de datos");
      }
    }

    if (!resul) {
      DialogosAwesome.getWarning(
          descripcion:
              "No Existe Conexión a Internet, asegurese de estar conectado a una red wifi o plan de datos");
    }

    return resul;
  }

  static Future<String> get getImei async {
    try {
      bool permiso = await Permission.phone.isGranted;
      if (!permiso) {
        DialogosAwesome.getWarning(
            descripcion:
                "Necesitamos obtener información del teléfono (Nombre de la red a la que está conectado, Modelo de su celular, versión del sistema operativo), es necesario que active los permisos para continuar.",
            btnOkOnPress: () async {
              await openAppSettings();
            });
      }

      print("ponhe permisos ${permiso}");

      String imeiNo = await DeviceInformation.deviceIMEINumber;

      return imeiNo;
    } catch (e) {
      return "";
    }
  }

  static Future<String> get getNameDevice async {
    try {
      String imeiNo = await DeviceInformation.deviceModel;

      return imeiNo;
    } catch (e) {
      return "";
    }
  }

  static Future<String> get getVersionSO async {
    try {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

      String result="";

      bool isAndroid = Platform.isAndroid;
      if (isAndroid) {


        AndroidDeviceInfo build = await deviceInfo.androidInfo;

        Map<String, dynamic> data = <String, dynamic>{
          'version.securityPatch': build.version.securityPatch,
          'version.sdkInt': build.version.sdkInt,
          'version.release': build.version.release,
          'version.previewSdkInt': build.version.previewSdkInt,
          'version.incremental': build.version.incremental,
          'version.codename': build.version.codename,
          'version.baseOS': build.version.baseOS,
          'board': build.board,
          'bootloader': build.bootloader,
          'brand': build.brand,
          'device': build.device,
          'display': build.display,
          'fingerprint': build.fingerprint,
          'hardware': build.hardware,
          'host': build.host,
          'id': build.id,
          'manufacturer': build.manufacturer,
          'model': build.model,
          'product': build.product,
          'supported32BitAbis': build.supported32BitAbis,
          'supported64BitAbis': build.supported64BitAbis,
          'supportedAbis': build.supportedAbis,
          'tags': build.tags,
          'type': build.type,
          'isPhysicalDevice': build.isPhysicalDevice,

          'systemFeatures': build.systemFeatures,
        };


        result = "ANDROID: "+ build.version.release;
      } else {
        IosDeviceInfo data = await deviceInfo.iosInfo;

        Map<String, dynamic> dataInfo = <String, dynamic>{
          'name': data.name,
          'systemName': data.systemName,
          'systemVersion': data.systemVersion,
          'model': data.model,
          'localizedModel': data.localizedModel,
          'identifierForVendor': data.identifierForVendor,
          'isPhysicalDevice': data.isPhysicalDevice,
          'utsname.sysname:': data.utsname.sysname,
          'utsname.nodename:': data.utsname.nodename,
          'utsname.release:': data.utsname.release,
          'utsname.version:': data.utsname.version,
          'utsname.machine:': data.utsname.machine,
        };

        result ="iOs: ${data.systemName} ${data.systemVersion}";
      }

      return result;
    } catch (e) {
      print("erroro");
      return "";
    }
  }

  static Future<String> get getLocalPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<String> get getInfoAuditoria async {
    String version = await UtilidadesUtil.getVersionCodeNameApp();
    String ip = await DeviceInfo.getIp;
    String fecha = await MyDate.getFechaHoraActual;
    String modeloCell = await DeviceInfo.getNameDevice;

    String detalle =
        " Fecha Local Célular (${fecha}) IP(${ip}) Modelo Cell (${modeloCell}) version app (${version})";

    return detalle;
  }

  static Future<String> get getIp async {
    final info = NetworkInfo();

    String ipAddress = "0.0.0.0";
    var wifiIP = await info.getWifiIP(); // 192.168.1.43

    if (wifiIP != null) {
      ipAddress = wifiIP.toString();
    }

    String plataforma = getPlataforma;
    return plataforma + " IP: " + ipAddress;
  }

  static Future<String> get getSSID async {
    final info = NetworkInfo();

    String value = "";
    var wifiIP = await info.getWifiName(); // 192.168.1.43

    if (wifiIP != null) {
      value = wifiIP.toString();
    }

    return value;
  }

  static String get getPlataforma {
    bool isAndroid = Platform.isAndroid;
    bool isOs = Platform.isIOS;
    String result = Platform.operatingSystem;
    if (isAndroid) {
      result = "ANDROID";
    } else if (isOs) {
      result = "IOS";
    } else {
      result = Platform.operatingSystem.toUpperCase();
    }
    return "PLATAFORMA " + result;
  }
}
