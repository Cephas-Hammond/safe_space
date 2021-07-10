import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class Bluetooth with ChangeNotifier {
  StreamSubscription<BluetoothDiscoveryResult> _streamSubscription;
  bool isDiscovering;
  List<BluetoothDevice> devices = [];
  List<BluetoothDiscoveryResult> results = [];

  Bluetooth({this.isDiscovering = true, startDiscovery()});

  int get devicenum => devices.length;
  
  void startDiscovery() {
    _streamSubscription =
        FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
      //scoped_model
      // int index;if (r.rssi < -70) {
      print('device found');
      results.add(r);

      if (!devices.contains(r.device)) {
        devices.add(r.device);
      }
      print(r.device.address.toString());
      notifyListeners();
    });

    _streamSubscription.onDone(() {
      //isDiscovering = false;
      _restartDiscovery();
      notifyListeners();
    });
    print(_streamSubscription);
  }

  void _restartDiscovery() {
    results.clear();
    isDiscovering = true;

    startDiscovery();
    notifyListeners();
  }

  void setDeviceNum(List<BluetoothDevice> value) {
    devices = value;

    notifyListeners();
  }
}
