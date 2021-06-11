import 'package:safe_space/models/controller_variables.dart';
import 'package:vibration/vibration.dart';

void activateNotification(int distance, bool active) async {
  bool _vibrationactive = vibration_active;

  if (_vibrationactive) {
    if (await Vibration.hasVibrator()) {
      Vibration.vibrate(pattern: [500, 1000, 500, 2000]);
    }
  }
}
