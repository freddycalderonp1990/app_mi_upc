import 'dart:async';

import 'package:flutter/cupertino.dart';

class TimerService {
  static final TimerService _instance = TimerService._internal();
  factory TimerService() => _instance;

  TimerService._internal() {
    _startTimer();
  }

  final int maxSeconds = 30;
  final ValueNotifier<int> seconds = ValueNotifier<int>(30);
  final ValueNotifier<double> valueRadio = ValueNotifier<double>(0.0);
  Timer? _timer;

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (seconds.value > 0) {
        seconds.value -= 1;
      } else {
        seconds.value = maxSeconds;
        // Realizar acciones adicionales al llegar a cero
      }

      double resultado = seconds.value * 100;
      valueRadio.value = resultado / maxSeconds;
    });
  }

  void stopTimer() {
    _timer?.cancel();
  }

  void dispose() {
    stopTimer();
  }
}
