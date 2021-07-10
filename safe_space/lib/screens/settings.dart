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
        title: const Text(
          'Safe Space',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            //Divider(),
            Card(
              child: ListTile(
                  leading: Icon(
                    Icons.category_outlined,
                    color: Theme.of(context).primaryColor,
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
                  color: Theme.of(context).primaryColor,
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
  double _val = 50.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 40.0,
          ),
          Text(
            "Settings",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 30.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: 50.0,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
                "Customize Notification like" +
                    " Vibration intensity, social distance, etc.",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w400,
                )),
          ),
          SizedBox(
            height: 50.0,
          ),
          Container(
            child: Column(
              children: [
                Text("Vibration Intensity",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    )),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, top: 20.0, bottom: 20.0, right: 5.0),
                      child: Icon(
                        Icons.vibration,
                        color: Theme.of(context).primaryColor,
                        size: 35.0,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 20.0),
                            alignment: Alignment.topRight,
                            child: Text(
                              '${_val.toInt()}%',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                          Slider(
                            label: "Increase vibration intensity",
                            activeColor: Theme.of(context).primaryColor,
                            inactiveColor: Colors.grey,
                            value: _val,
                            onChanged: (double val) {
                              setState(() {
                                _val = val;
                              });
                            },
                            divisions: 2,
                            max: 100.0,
                            min: 1.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Container(
            margin: EdgeInsets.all(8.0),
            padding: EdgeInsets.all(8.0),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: Text("Minimum Social Distance",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      )),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "1 meter",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                    ),
                    textAlign: TextAlign.left,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Container(
            margin: EdgeInsets.all(8.0),
            padding: EdgeInsets.all(8.0),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: Text("Select Sound",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      )),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Default Sound",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                    ),
                    textAlign: TextAlign.left,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
