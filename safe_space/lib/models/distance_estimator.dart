import 'dart:math';

import 'package:flutter/cupertino.dart';



// ignore: non_constant_identifier_names
class DistanceEstimator with ChangeNotifier {
  double _distance = 0.0;
  String _distancecal = '0.0';

  double get distance => _distance;
  // ignore: non_constant_identifier_names
  void set_distances(double dis) {
    _distance = dis;
  }

  String get distancecal => _distancecal;
  // ignore: non_constant_identifier_names
  void CalculateDistance(int rssi) {
    _distance = pow(10, -(rssi + 55) / (10 * 4.7));
    _distancecal = _distance.toStringAsFixed(2);

    notifyListeners();
  }
}
