import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:provider/provider.dart';
import 'package:safe_space/models/bluetooth.dart';
import 'package:safe_space/models/bluetooth_provider.dart';
import 'package:safe_space/models/controller_variables.dart';
import 'package:safe_space/models/distance_estimator.dart';

import 'homepage.dart';
import 'settings.dart';

class Homepage extends StatefulWidget {
  final bool start;

  const Homepage({Key key, this.start = true}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool soundActive = sound_active;

  StreamSubscription<BluetoothDiscoveryResult> _streamSubscription;
  List<BluetoothDiscoveryResult> results = [];

  //_DiscoveryPage();
  int device = 0;
  List<BluetoothDevice> devices = [];
  List<String> addresses = [];

  @override
  void initState() {
    super.initState();

    isDiscovering = widget.start;
    if (isDiscovering) {
      print('init State');
      _startDiscovery();
    }
  }

  void _restartDiscovery() {
    setState(() {
      results.clear();
      devices.clear();

      isDiscovering = true;
    });

    _startDiscovery();
  }

  void _startDiscovery() {
    device++;

    _streamSubscription =
        FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
      setState(() {
        //scoped_model
        // int index;
        print(r.rssi);
        //if (r.rssi > -70) {
        print('device found');
        results.add(r);

        if (!devices.contains(r.device)) {
          devices.add(r.device);
          print(devices.length);
          context.read<Bluetooth>().setDeviceNum(devices);
          CalculateDistance(r.rssi);
        }
        //}
      });
    });

    _streamSubscription.onDone(() {
      setState(() {
        //isDiscovering = false;
        Timer(Duration(seconds: 1), () {
          _restartDiscovery();
        });
      });
    });
    print(_streamSubscription);
  }

  void CalculateDistance(int rssi) {
    context.read<DistanceEstimator>().CalculateDistance(rssi);
  }
  // @TODO . One day there should be `_pairDevice` on long tap on something... ;)

  @override
  void dispose() {
    // Avoid memory leak (`setState` after dispose) and cancel discovery
    _streamSubscription?.cancel();

    super.dispose();
  }

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
            MainPage(),
            DiscoveryPage(),
          ]),
        ));
  }
}
