import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'DiscoveryPage.dart';
import 'bluetooth.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          bottomNavigationBar: TabBar(
            indicatorColor: Color.fromRGBO(0, 219, 144, 1.0),
            tabs: [
              Tab(
                icon: Icon(
                  Icons.home,
                  color: Color.fromRGBO(0, 219, 144, 1.0),
                  size: 30,
                ),
                child: Text(
                  "Home",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.info_sharp,
                  color: Color.fromRGBO(0, 219, 144, 1.0),
                  size: 30,
                ),
                child: Text(
                  "Logs",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.settings,
                  color: Color.fromRGBO(0, 219, 144, 1.0),
                  size: 30,
                ),
                child: Text(
                  "Settings",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
          body: TabBarView(children: [
            HomePage(),
            DiscoveryPage(),
            BluetoothDiscover(),
          ]),
        ));
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Hello, John",
            style: TextStyle(
                color: Colors.grey, fontSize: 30, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 200,
          ),
          Text(
            "Customize Notifications",
            style: TextStyle(color: Colors.grey),
            textAlign: TextAlign.left,
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: SoundToggle(),
                ),
                Expanded(
                  child: VibrationToggle(),
                ),
                Expanded(
                  child: AnimationToggle(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SoundToggle extends StatefulWidget {
  //SoundToggle({Key ? key}) : super(key: key);

  @override
  _SoundToggle createState() => _SoundToggle();
}

class _SoundToggle extends State<SoundToggle> {
  bool _active = false;

  void _handleTap() {
    setState(() {
      _active = !_active;
    });
    if (_active) {
      FlutterRingtonePlayer.play(
        android: AndroidSounds.notification,
        looping: true,
        volume: 1.0,
        ios: null,
      );
    }
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Container(
          padding: EdgeInsets.all(8.0),
          height: 120,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: _active
                  ? Color.fromRGBO(0, 219, 144, 1.0)
                  : Colors.blueGrey[50]),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.notifications_active,
                  color: _active ? Colors.white : Colors.grey,
                  size: 35,
                ),
                Center(
                  child: Text(
                    _active ? "Sound: ON" : "Sound: OFF",
                    style: TextStyle(
                        color: _active ? Colors.white : Colors.grey,
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

class VibrationToggle extends StatefulWidget {
  //SoundToggle({Key ? key}) : super(key: key);

  @override
  _VibrationToggle createState() => _VibrationToggle();
}

class _VibrationToggle extends State<VibrationToggle> {
  bool _active = false;

  bool getActive() {
    return _active;
  }

  void _handleVibrateTap() {
    setState(() {
      _active = !_active;
    });
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleVibrateTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Container(
          padding: EdgeInsets.all(8.0),
          height: 120,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: _active
                  ? Color.fromRGBO(0, 219, 144, 1.0)
                  : Colors.blueGrey[50]),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.notifications_active,
                  color: _active ? Colors.white : Colors.grey,
                  size: 35,
                ),
                Center(
                  child: Text(
                    _active ? "Vibration: ON" : "Vibration: OFF",
                    style: TextStyle(
                        color: _active ? Colors.white : Colors.grey,
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

class AnimationToggle extends StatefulWidget {
  //SoundToggle({Key ? key}) : super(key: key);

  @override
  _AnimationToggle createState() => _AnimationToggle();
}

class _AnimationToggle extends State<AnimationToggle> {
  bool _active = false;

  void _handleAnimateTap() {
    setState(() {
      _active = !_active;
    });
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleAnimateTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Container(
          padding: EdgeInsets.all(8.0),
          height: 120,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: _active
                  ? Color.fromRGBO(0, 219, 144, 1.0)
                  : Colors.blueGrey[50]),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.notifications_active,
                  color: _active ? Colors.white : Colors.grey,
                  size: 35,
                ),
                Center(
                  child: Text(
                    _active ? "Animation: ON" : "Animation: OFF",
                    style: TextStyle(
                        color: _active ? Colors.white : Colors.grey,
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
