import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:safe_space/models/bluetooth.dart';
import 'package:safe_space/models/controller_variables.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  BluetoothState _bluetoothState = bluetoothState;

  String _address = "...";
  String _name = "...";

  Timer _discoverableTimeoutTimer;
  int _discoverableTimeoutSecondsLeft = 10;

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

    _discoverableTimeoutTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            color: Colors.white70,
            boxShadow: [
              BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0.0, 2.0),
                  blurRadius: 6.0)
            ]),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25.0),
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Card(
                color: Theme.of(context).primaryColor,
                margin: EdgeInsets.all(15),
                elevation: 25,
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).primaryColor,
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
                color: Theme.of(context).primaryColor,
                margin: EdgeInsets.all(15),
                elevation: 25,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).primaryColor,
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
                            await FlutterBluetoothSerial.instance
                                .requestEnable();
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
                color: Theme.of(context).primaryColor,
                margin: EdgeInsets.all(15),
                elevation: 25,
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).primaryColor,
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
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return Discover();
                            },
                          ),
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
