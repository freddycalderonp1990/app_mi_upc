//device_info_plus: ^11.4.0 #Informacion del cell,Version Sistema Operatvivo
//network_info_plus: ^6.1.4 #Obtener ip del celular (se deben asiganr permisos para IOS)

import 'dart:developer';
import 'dart:io';


import 'package:device_info_plus/device_info_plus.dart';

import 'package:get/get_utils/src/platform/platform.dart';

import 'package:network_info_plus/network_info_plus.dart';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';


import '../../presentation/widgets/custom_widgets.dart';
import 'my_date.dart';

class DeviceInfoApp {
  static Future<String> get getImei async {
    try {
      bool permiso = await Permission.phone.isGranted;
      if (!permiso) {
        DialogosAwesome.getWarning(
          descripcion:
              "Necesitamos obtener información del teléfono (Nombre de la red a la que está conectado, Modelo de su celular, versión del sistema operativo), es necesario que active los permisos para continuar.",
          btnOkOnPress: () async {
            await openAppSettings();
          },
        );
      }

      print("ponhe permisos ${permiso}");

      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

      if (GetPlatform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

        return androidInfo.id;
      }

      if (GetPlatform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        return iosInfo.utsname.nodename;
      }

      if (GetPlatform.isWeb) {
        WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;

        String? a = webBrowserInfo.platform;
        return a != null ? a : "";
      }

      return "";
    } catch (e) {
      return "";
    }
  }

  static Future<String> get getNameDevice async {
    try {
      //  String imeiNo = await DeviceInformation.deviceModel;

      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

      if (GetPlatform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        return androidInfo.model;
      }

      if (GetPlatform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        return iosInfo.utsname.machine;
      }

      if (GetPlatform.isWeb) {
        WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;

        String? a = webBrowserInfo.userAgent;
        return a != null ? a : "";
      }

      if (GetPlatform.isDesktop) {
        return "Escitorio App";
      }

      return "No info model";
    } catch (e) {
      return "No info model";
    }
  }

  static Future<String> get getVersionSO async {
    try {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

      String result = "No information ";

      bool isAndroid = Platform.isAndroid;
      if (isAndroid) {
        AndroidDeviceInfo build = await deviceInfo.androidInfo;

        final deviceInfoPlugin = DeviceInfoPlugin();
        final deviceInfo1 = await deviceInfoPlugin.deviceInfo;
        final allInfo = deviceInfo1.data;
        print(allInfo);

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

        result = "ANDROID: " + build.version.release!;
      } else if (Platform.isIOS) {
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

        result = "iOs: ${data.systemName} ${data.systemVersion}";
      } else {
        WebBrowserInfo data = await deviceInfo.webBrowserInfo;
        result = "web: ${data.appName} ${data.appVersion}";
      }

      return result;
    } catch (e) {
      print("erroro");
      return "No information";
    }
  }

  static Future<String> get getLocalPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<String> get getInfoAuditoria async {
    String version = await getVersionCodeNameApp;
    String ip = await DeviceInfoApp.getIp;
    String fecha = await MyDate.getFechaHoraActual;
    String modeloCell = await DeviceInfoApp.getNameDevice;

    String detalle =
        " Fecha Local Célular (${fecha}) IP(${ip}) Modelo Cell (${modeloCell}) version app (${version})";

    return detalle;
  }

  static Future<String> get getIp async {
    try {
      final info = NetworkInfo();

      String ipAddress = "0.0.0.0";
      String fuente = "desconocida";

      // Intentar obtener IP de Wi-Fi
      String? wifiIP = await info.getWifiIP();
      if (wifiIP != null && wifiIP.isNotEmpty) {
        ipAddress = wifiIP;
        fuente = "Wi-Fi";
      } else {
        // Si no hay Wi-Fi, buscar IP de la red celular
        for (var interface in await NetworkInterface.list()) {
          for (var addr in interface.addresses) {
            if (addr.type == InternetAddressType.IPv4 &&
                !addr.isLoopback &&
                !addr.isLinkLocal) {
              ipAddress = addr.address;
              fuente = "Red móvil";
              break;
            }
          }
          if (ipAddress != "0.0.0.0") break;
        }
      }

      String plataforma = getPlataforma; // tu método para detectar plataforma
      return "$plataforma IP ($fuente): $ipAddress";
    } catch (e) {
      String plataforma = getPlataforma;
      return "$plataforma IP: no disponible";
    }
  }

  static Future<String> get getSSID async {
    final info = NetworkInfo();

    String value = "";
    var wifiIP = await info.getWifiBSSID(); // 192.168.1.43

    if (wifiIP != null) {
      value = wifiIP.toString();
    }

    return value;
  }

  static String get getPlataforma {
    try {
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
    } catch (e) {
      return "PLATAFORMA " + "NO CODE";
    }
  }

  static String get getOnlyPlataforma {
    try {
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
      return result;
    } catch (e) {
      return "NO CODE";
    }
  }

  static Future<String> get getVersionName async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String versionName = packageInfo.version;

    String result = versionName;

    return result;
  }

  static Future<String> get getVersionCode async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String versionCode = packageInfo.buildNumber;

    String result = versionCode;

    return result;
  }

  static Future<String> get getDeviceMarca async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      log("androidInfo: ${androidInfo}");
      return androidInfo.brand ?? 'Unknown'; // Marca del dispositivo Android
    }
    if (Platform.isIOS) {
      final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;

      return iosInfo.name ?? 'Unknown'; // Nombre del dispositivo iOS
    }

    return "Unknown";
  }

  static Future<String> get getVersionCodeNameApp async {
    String versionName = await getVersionName;
    String versionCode = await getVersionCode;

    String resultPl = "Android-Build-";
    if (Platform.isIOS) {
      resultPl = "iOS-Build-";
    }

    String result =
        'V.' +
        resultPl +
        versionName +
        '.' +
        versionCode +
        '-' +
        'PROD';

    return result;
  }
}
