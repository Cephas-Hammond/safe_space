import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import './DiscoveryPage.dart';

class BluetoothDiscover extends StatefulWidget {
  @override
  _BluetoothDiscoverState createState() => new _BluetoothDiscoverState();
}

class _BluetoothDiscoverState extends State<BluetoothDiscover> {
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;

  String _address = "...";
  String _name = "...";

  Timer _discoverableTimeoutTimer;
  int _discoverableTimeoutSecondsLeft = 0;

  //BackgroundCollectingTask _collectingTask;

  bool _autoAcceptPairingRequests = false;

  @override
  void initState() {
    super.initState();

    // Get current state
    FlutterBluetoothSerial.instance.state.then((state) {
      setState(() {
        _bluetoothState = state;
      });
    });

    Future.doWhile(() async {
      // Wait if adapter not enabled
      if (await FlutterBluetoothSerial.instance.isEnabled) {
        return false;
      }
      await Future.delayed(Duration(milliseconds: 0xDD));
      return true;
    }).then((_) {
      // Update the address field
      FlutterBluetoothSerial.instance.address.then((address) {
        setState(() {
          _address = address;
        });
      });
    });

    FlutterBluetoothSerial.instance.name.then((name) {
      setState(() {
        _name = name;
      });
    });

    // Listen for futher state changes
    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      setState(() {
        _bluetoothState = state;

        // Discoverable mode is disabled when Bluetooth gets disabled
        _discoverableTimeoutTimer = null;
        _discoverableTimeoutSecondsLeft = 0;
      });
    });
  }

  @override
  void dispose() {
    FlutterBluetoothSerial.instance.setPairingRequestHandler(null);
    //_collectingTask?.dispose();
    _discoverableTimeoutTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Card(
              color: Color.fromRGBO(0, 219, 144, 1.0),
              margin: EdgeInsets.all(15),
              elevation: 25,
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromRGBO(0, 219, 144, 1.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                      leading: Icon(
                        Icons.category_outlined,
                        color: Colors.white,
                        size: 50,
                      ),
                      title: const Text(
                        'General',
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ),
            ),
            Card(
              color: Color.fromRGBO(0, 219, 144, 1.0),
              margin: EdgeInsets.all(15),
              elevation: 25,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromRGBO(0, 219, 144, 1.0),
                ),
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SwitchListTile(
                    title: const Text(
                      'Enable Bluetooth',
                      style: TextStyle(color: Colors.white),
                    ),
                    value: _bluetoothState.isEnabled,
                    onChanged: (bool value) {
                      // Do the request and update with the true value then
                      future() async {
                        // async lambda seems to not working
                        if (value)
                          await FlutterBluetoothSerial.instance.requestEnable();
                        else
                          await FlutterBluetoothSerial.instance
                              .requestDisable();
                      }

                      future().then((_) {
                        setState(() {});
                      });
                    },
                    secondary: Icon(
                      Icons.bluetooth_searching,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                ),
              ),
            ),
            Card(
              color: Color.fromRGBO(0, 219, 144, 1.0),
              margin: EdgeInsets.all(15),
              elevation: 25,
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromRGBO(0, 219, 144, 1.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.settings_bluetooth,
                      color: Colors.white,
                      size: 50,
                    ),
                    title: const Text(
                      'Bluetooth status',
                      style: TextStyle(color: Colors.white),
                    ),
                    //subtitle: Text(_bluetoothState.toString()),
                    trailing: RaisedButton(
                      child: const Text('Settings'),
                      onPressed: () {
                        FlutterBluetoothSerial.instance.openSettings();
                      },
                    ),
                  ),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.all(50),
              child: ListTile(
                // leading: Icon(
                //     Icons.find_in_page,
                //     color: Colors.orangeAccent,
                //     size: 50,
                //     ),
                title: RaisedButton(
                    child: const Text('Discover Devices'),
                    onPressed: () async {
                      final BluetoothDevice selectedDevice =
                          await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return DiscoveryPage();
                          },
                        ),
                      );

                      if (selectedDevice != null) {
                        print(
                            'Discovery -> selected ' + selectedDevice.address);
                      } else {
                        print('Discovery -> no device selected');
                      }
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
