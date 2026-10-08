import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:network_info_plus/network_info_plus.dart';

class DeviceNetworkData {
  final String idDispositivo;
  final String red;
  final String tipoRed;
  final String direccionIp;

  DeviceNetworkData({
    required this.idDispositivo,
    required this.red,
    required this.tipoRed,
    required this.direccionIp,
  });
}

class DeviceNetworkHelper {
  static final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();
  static final Connectivity _connectivity = Connectivity();
  static final NetworkInfo _networkInfo = NetworkInfo();

  static Future<DeviceNetworkData> getDeviceNetworkData() async {
    final idDispositivo = await _getDeviceId();
    final redInfo = await _getRedInfo();
    final direccionIp = await _getIp();

    return DeviceNetworkData(
      idDispositivo: idDispositivo,
      red: redInfo['red'] ?? 'DESCONOCIDA',
      tipoRed: redInfo['tipoRed'] ?? 'DESCONOCIDO',
      direccionIp: direccionIp,
    );
  }

  static Future<String> _getDeviceId() async {
    if (Platform.isAndroid) {
      final androidInfo = await _deviceInfo.androidInfo;
      return androidInfo.id.isNotEmpty ? androidInfo.id : 'ANDROID_DEVICE';
    }

    if (Platform.isIOS) {
      final iosInfo = await _deviceInfo.iosInfo;
      return iosInfo.identifierForVendor ?? 'IOS_DEVICE';
    }

    return 'UNKNOWN_DEVICE';
  }

  static Future<Map<String, String>> _getRedInfo() async {
    final result = await _connectivity.checkConnectivity();

    if (result.contains(ConnectivityResult.wifi)) {
      final wifiName = await _networkInfo.getWifiName();
      return {
        'red': wifiName ?? 'WIFI',
        'tipoRed': 'WIFI',
      };
    }

    if (result.contains(ConnectivityResult.mobile)) {
      return {
        'red': 'DATOS MOVILES',
        'tipoRed': 'MOVIL',
      };
    }

    if (result.contains(ConnectivityResult.ethernet)) {
      return {
        'red': 'ETHERNET',
        'tipoRed': 'ETHERNET',
      };
    }

    return {
      'red': 'SIN RED',
      'tipoRed': 'OFFLINE',
    };
  }

  static Future<String> _getIp() async {
    try {
      final wifiIp = await _networkInfo.getWifiIP();
      if (wifiIp != null && wifiIp.isNotEmpty) {
        return wifiIp;
      }
    } catch (_) {}

    try {
      final interfaces = await NetworkInterface.list(
        includeLoopback: false,
        type: InternetAddressType.IPv4,
      );

      for (final interface in interfaces) {
        for (final addr in interface.addresses) {
          if (!addr.isLoopback) {
            return addr.address;
          }
        }
      }
    } catch (_) {}

    return '0.0.0.0';
  }
}
