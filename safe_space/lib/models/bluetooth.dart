import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:safe_space/screens/devices.dart';
import 'bluetooth_provider.dart';
import 'controller_variables.dart';
import 'distance_estimator.dart';

class DiscoveryPage extends StatefulWidget {
  /// If true, discovery starts on page start, otherwise user must press action button.
  final bool start;

  const DiscoveryPage({this.start = true});

  @override
  _DiscoveryPage createState() => new _DiscoveryPage();
}

class _DiscoveryPage extends State<DiscoveryPage> {
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
        if (r.rssi > -70) {
          print('device found');
          results.add(r);

          if (!devices.contains(r.device)) {
            devices.add(r.device);
            context.read<Bluetooth>().setDeviceNum(devices);
          }
        }
      });
    });

    _streamSubscription.onDone(() {
      setState(() {
        //isDiscovering = false;
        Timer(Duration(seconds: 3), () {
          _restartDiscovery();
        });
      });
    });
    print(_streamSubscription);
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
    return Scaffold(
      appBar: AppBar(
        title: isDiscovering
            ? Text(
                'Discovering devices',
                style: TextStyle(color: Colors.white),
              )
            : Text(
                'Discovered devices',
                style: TextStyle(color: Colors.white),
              ),
        backgroundColor: Theme.of(context).primaryColor,
        actions: <Widget>[
          isDiscovering
              ? FittedBox(
                  child: Container(
                    margin: new EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                )
              : IconButton(
                  icon: Icon(Icons.replay),
                  onPressed: _restartDiscovery,
                )
        ],
      ),
      // body: Center(
      //   child: Column(
      //     children: [Text('$device')],
      //   ),
      // ),
      body: ListView.builder(
        itemCount: results.length,
        itemBuilder: (BuildContext context, index) {
          BluetoothDiscoveryResult result = results[index];
          //activateNotification(CalculateDistance(result.rssi));
          //context.read<DistanceEstimator>().CalculateDistance(result.rssi);
          CalculateDistance(result.rssi);
          print(devices.length);
          return BluetoothDeviceListEntry(
            device: result.device,
            rssi: result.rssi,
            onTap: () {
              Navigator.of(context).pop(result.device);
            },
            onLongPress: () async {
              try {
                bool bonded = false;
                if (result.device.isBonded) {
                  print('Unbonding from ${result.device.address}...');
                  await FlutterBluetoothSerial.instance
                      .removeDeviceBondWithAddress(result.device.address);
                  print('Unbonding from ${result.device.address} has succed');
                } else {
                  print('Bonding with ${result.device.address}...');
                  bonded = await FlutterBluetoothSerial.instance
                      .bondDeviceAtAddress(result.device.address);
                  print(
                      'Bonding with ${result.device.address} has ${bonded ? 'succed' : 'failed'}.');
                }
                setState(() {
                  results[results.indexOf(result)] = BluetoothDiscoveryResult(
                      device: BluetoothDevice(
                        name: result.device.name ?? '',
                        address: result.device.address,
                        type: result.device.type,
                        bondState: bonded
                            ? BluetoothBondState.bonded
                            : BluetoothBondState.none,
                      ),
                      rssi: result.rssi);
                });
              } catch (ex) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Error occured while bonding'),
                      content: Text("${ex.toString()}"),
                      actions: <Widget>[
                        new TextButton(
                          child: new Text("Close"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              }
            },
          );
        },
      ),
    );
  }

  // ignore: non_constant_identifier_names
  void CalculateDistance(int rssi) {
    context.read<DistanceEstimator>().CalculateDistance(rssi);
  }
}
