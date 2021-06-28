import 'dart:math';

// ignore: non_constant_identifier_names
double CalculateDistance(int rssi) {
    double distance;
    distance = pow(10, -(rssi + 69) / (10 * 4.7));
    return distance;
}