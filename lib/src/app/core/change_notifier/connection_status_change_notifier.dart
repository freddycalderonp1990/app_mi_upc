import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/cupertino.dart';

import '../utils/check_internet_conexion.dart';

final internetChecker = CheckInternetConnection();
class ConnectionStatusChangeNotifier extends ChangeNotifier {
  late StreamSubscription _connectionSubscription;

  ConnectionStatus status = ConnectionStatus.online;

  ConnectionStatusChangeNotifier() {
    _connectionSubscription = internetChecker
        .internetStatus()
        .listen((newStatus) {
      status = newStatus;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _connectionSubscription.cancel();
    super.dispose();
  }
}
