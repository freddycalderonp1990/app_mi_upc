import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:rxdart/rxdart.dart';

/// Estado de conexión posible
enum ConnectionStatus { online, offline }

/// Servicio central de monitoreo de conexión real (no solo WiFi)
class CheckInternetConnection {
  final Connectivity _connectivity = Connectivity();
  final _controller = BehaviorSubject<ConnectionStatus>();
  StreamSubscription? _connectionSubscription;

  CheckInternetConnection() {
    // Ejecuta verificación inicial
    _init();
  }

  /// Stream reactivo de estado de conexión
  Stream<ConnectionStatus> internetStatus() {
    return _controller.stream.distinct();
  }

  /// Inicializa el monitoreo
  Future<void> _init() async {
    // Verificación inicial
    await _checkInternetConnection();

    // Escucha cambios en la red
    _connectionSubscription =
        _connectivity.onConnectivityChanged.listen((_) async {
          await _checkInternetConnection();
        });
  }

  /// Verifica si realmente hay acceso a Internet
  Future<void> _checkInternetConnection() async {
    try {
      // Espera breve por estabilidad de red (útil en WiFi)
      await Future.delayed(const Duration(milliseconds: 800));

      final hosts = ['google.com', 'cloudflare.com', '1.1.1.1'];
      bool hasConnection = false;

      for (final host in hosts) {
        try {
          final result = await InternetAddress.lookup(host)
              .timeout(const Duration(seconds: 2));
          if (result.isNotEmpty && result.first.rawAddress.isNotEmpty) {
            hasConnection = true;
            break;
          }
        } catch (_) {
          // ignora host fallido y sigue
        }
      }

      _controller.add(
          hasConnection ? ConnectionStatus.online : ConnectionStatus.offline);
    } on SocketException {
      _controller.add(ConnectionStatus.offline);
    } catch (_) {
      _controller.add(ConnectionStatus.offline);
    }
  }

  Future<void> close() async {
    await _connectionSubscription?.cancel();
    await _controller.close();
  }
}
