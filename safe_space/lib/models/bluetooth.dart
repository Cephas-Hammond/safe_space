import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import 'controller_variables.dart';

StreamSubscription<BluetoothDiscoveryResult> _streamSubscription;

List<BluetoothDiscoveryResult> results = [];

class Discover extends StatefulWidget {
  

  @override
  _DiscoverState createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {


  @override
  void initState() {
    super.initState();

    
    if (isDiscovering) {
      _startDiscovery();
    }
  }


  void _startDiscovery() {
    _streamSubscription =
        FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
      setState(() {
        results.add(r);
      });
    });

    _streamSubscription.onDone(() {
      setState(() {
        isDiscovering = false;
      });
    });
  }

  void _restartDiscovery() {
    setState(() {
      results.clear();
      isDiscovering = true;
    });

    _startDiscovery();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}
