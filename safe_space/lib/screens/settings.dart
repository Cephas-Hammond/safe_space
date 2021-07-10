import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:safe_space/models/bluetooth.dart';


class MainPage extends StatefulWidget {
  @override
  _MainPage createState() => new _MainPage();
}

class _MainPage extends State<MainPage> {
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;

  String _address = "...";
  String _name = "...";
  // int counter = 0;

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
      appBar: AppBar(
        title: const Text('Safe Space'),
        backgroundColor: Colors.orange,
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            //Divider(),
            Card(
              child: ListTile(
                  leading: Icon(
                    Icons.category_outlined,
                    color: Colors.orangeAccent,
                    size: 50,
                  ),
                  title: const Text('General')),
            ),
            Card(
              child: SwitchListTile(
                title: const Text('Enable Bluetooth'),
                value: _bluetoothState.isEnabled,
                onChanged: (bool value) {
                  // Do the request and update with the true value then
                  future() async {
                    // async lambda seems to not working
                    if (value)
                      await FlutterBluetoothSerial.instance.requestEnable();
                    else
                      await FlutterBluetoothSerial.instance.requestDisable();
                  }

                  future().then((_) {
                    setState(() {});
                  });
                },
                secondary: Icon(
                  Icons.bluetooth_searching,
                  color: Colors.orangeAccent,
                  size: 50,
                ),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(
                  Icons.settings_bluetooth,
                  color: Theme.of(context).primaryColor,
                  size: 50,
                ),
                title: const Text('Bluetooth status'),
                subtitle: Text(_bluetoothState.toString()),
                trailing: ElevatedButton(
                  child: const Text('Settings'),
                  onPressed: () {
                    FlutterBluetoothSerial.instance.openSettings();
                  },
                ),
              ),
            ),

            Card(
              margin: EdgeInsets.only(top: 150),
              child: ListTile(
                // leading: Icon(
                //     Icons.find_in_page,
                //     color: Colors.orangeAccent,
                //     size: 50,
                //     ),
                title: ElevatedButton(
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

class Settings extends StatefulWidget {
  // const Settings({ Key? key }) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}