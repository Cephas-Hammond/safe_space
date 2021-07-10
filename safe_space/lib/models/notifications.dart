import 'dart:async';

import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:safe_space/models/controller_variables.dart';
import 'package:vibration/vibration.dart';

void activateNotification(double newdistance) async {
  bool _vibrationactive = vibration_active;
  bool _soundactive = sound_active;

  if (newdistance < 1.5) {
    if (_vibrationactive) {
      if (await Vibration.hasVibrator()) {
        Vibration.vibrate(pattern: [500, 1000, 500, 2000]);
      }
    }
    if (_soundactive) {
      Timer(Duration(seconds: 10), () {
        FlutterRingtonePlayer.playAlarm();
      });
    }
  }
}
