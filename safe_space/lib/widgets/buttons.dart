//Sound Toggle button
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:safe_space/models/controller_variables.dart';
import 'package:vibration/vibration.dart';

class SoundToggle extends StatefulWidget {
  //SoundToggle({Key ? key}) : super(key: key);

  @override
  _SoundToggle createState() => _SoundToggle();
}

class _SoundToggle extends State<SoundToggle> {
  //bool _active = false;

  void _handleTap() {
    setState(() {
      sound_active = !sound_active;
    });
    //Plays a notification sound if toggled on
    if (sound_active) {
      FlutterRingtonePlayer.playNotification();
    } else {
      FlutterRingtonePlayer.stop();
    }
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          padding: EdgeInsets.all(8.0),
          height: 120,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0.0, 2.0),
                    blurRadius: 6.0),
              ],
              color: sound_active
                  ? Color.fromRGBO(0, 219, 144, 1.0)
                  : Colors.blueGrey[50]),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.notifications_active,
                  color: sound_active ? Colors.white : Colors.grey,
                  size: 35,
                ),
                Center(
                  child: Text(
                    sound_active ? "Sound: ON" : "Sound: OFF",
                    style: TextStyle(
                        color: sound_active ? Colors.white : Colors.grey,
                        fontSize: 10),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//Vibration toggle button
class VibrationToggle extends StatefulWidget {
  @override
  _VibrationToggle createState() => _VibrationToggle();
}

class _VibrationToggle extends State<VibrationToggle> {
  // bool _active = false;

  // bool getActive() {
  //   return _active;
  // }

  Future<void> _handleVibrateTap() async {
    setState(() {
      vibration_active = !vibration_active;
    });
    //Activates a 1 second vibration if toggled on
    if (vibration_active) {
      if (await Vibration.hasVibrator()) {
        Vibration.vibrate(duration: 1000);
      }
    }
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleVibrateTap,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          padding: EdgeInsets.all(8.0),
          height: 120,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0.0, 2.0),
                    blurRadius: 6.0),
              ],
              color: vibration_active
                  ? Theme.of(context).primaryColor
                  : Colors.blueGrey[50]),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.vibration,
                  color: vibration_active ? Colors.white : Colors.grey,
                  size: 35,
                ),
                Center(
                  child: Text(
                    vibration_active ? "Vibration: ON" : "Vibration: OFF",
                    style: TextStyle(
                        color: vibration_active ? Colors.white : Colors.grey,
                        fontSize: 10),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Animation toggle button
class AnimationToggle extends StatefulWidget {
  @override
  _AnimationToggle createState() => _AnimationToggle();
}

class _AnimationToggle extends State<AnimationToggle> {
  //bool _active = false;

  void _handleAnimateTap() {
    setState(() {
      animation_active = !animation_active;
    });
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleAnimateTap,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          padding: EdgeInsets.all(8.0),
          height: 120,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0.0, 2.0),
                    blurRadius: 6.0),
              ],
              color: animation_active
                  ? Theme.of(context).primaryColor
                  : Colors.blueGrey[50]),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.animation,
                  color: animation_active ? Colors.white : Colors.grey,
                  size: 35,
                ),
                Center(
                  child: Text(
                    animation_active ? "Animation: ON" : "Animation: OFF",
                    style: TextStyle(
                        color: animation_active ? Colors.white : Colors.grey,
                        fontSize: 10),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StartBluetooth extends StatefulWidget {
  @override
  _StartBluetoothState createState() => _StartBluetoothState();
}

class _StartBluetoothState extends State<StartBluetooth> {
  startBluetooth() {
    isDiscovering = !isDiscovering;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: startBluetooth(),
      child: Container(),
    );
  }
}
