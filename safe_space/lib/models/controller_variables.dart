// ignore: non_constant_identifier_names


import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

// ignore: non_constant_identifier_names
bool sound_active = false;
// ignore: non_constant_identifier_names
bool vibration_active = false;
// ignore: non_constant_identifier_names
bool animation_active = false;

bool isDiscovering = false;

List<BluetoothDiscoveryResult> results = [];

int counter = 0;

String username;

BluetoothState bluetoothState = BluetoothState.UNKNOWN;

List<BluetoothDevice> devices = [];
