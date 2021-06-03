import 'package:flutter/widgets.dart';
import 'package:vibration/vibration.dart';
import 'home.dart';

void activateNotification(int distance, bool active) async {
  bool _vibrationactive = active;

  if (_vibrationactive) {
    if (distance < 1.5) {
      if (await Vibration.hasVibrator()) {
        Vibration.vibrate(duration: 2000);
      }
    }
  }
}
