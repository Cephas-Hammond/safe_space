import 'package:flutter/material.dart';

class Devices extends StatefulWidget {
  @override
  _DevicesState createState() => _DevicesState();
}

class _DevicesState extends State<Devices> {
  int devices = 12;
  Color updateColor() {
    if (devices > 4 && devices < 8) {
      return Colors.yellow;
    } else if (devices > 8) {
      return Colors.red;
    } else {
      return Theme.of(context).primaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 110,
      margin: EdgeInsets.all(5.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: updateColor(), borderRadius: BorderRadius.circular(10)),
      child: Stack(children: [
        Text(
          'Detected devices around you',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
        ),
        Positioned(
            right: 10,
            bottom: 10,
            child: Text(
              '$devices',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
            )),
      ]),
    );
  }
}

class DistanceInfo extends StatefulWidget {
  @override
  _DistanceInfoState createState() => _DistanceInfoState();
}

class _DistanceInfoState extends State<DistanceInfo> {
  double distance = 0.1;
  Color updateColor() {
    if (distance < 1 && distance >= 0.3) {
      return Colors.yellow;
    } else if (distance < 0.3) {
      return Colors.red;
    } else {
      return Theme.of(context).primaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 110,
      margin: EdgeInsets.all(5.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: updateColor(), borderRadius: BorderRadius.circular(10)),
      child: Stack(children: [
        Text(
          'Distance from nearest device',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
        ),
        Positioned(
            right: 10,
            bottom: 10,
            child: Text(
              '${distance}m',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
            )),
      ]),
    );
  }
}

class RiskIndicator extends StatefulWidget {
  @override
  _RiskIndicatorState createState() => _RiskIndicatorState();
}

class _RiskIndicatorState extends State<RiskIndicator> {
  int risk = 93;
  Color updateColor() {
    if (risk > 10 && risk < 50) {
      return Colors.yellow;
    } else if (risk >= 50) {
      return Colors.red;
    } else {
      return Theme.of(context).primaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 110,
      margin: EdgeInsets.all(5.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: updateColor(), borderRadius: BorderRadius.circular(10)),
      child: Stack(children: [
        Text(
          'Risk of infection',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
        ),
        Positioned(
            right: 10,
            bottom: 10,
            child: Text(
              '$risk%',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
            )),
      ]),
    );
  }
}

class MaskIndicator extends StatefulWidget {
  @override
  _MaskIndicatorState createState() => _MaskIndicatorState();
}

class _MaskIndicatorState extends State<MaskIndicator> {
  String maskon = 'Yes';
  Color updateColor() {
    if (maskon.toLowerCase() == 'no') return Colors.red;
    if (maskon.toLowerCase() == 'yes') return Theme.of(context).primaryColor;
  }

  swap() {
    setState(() {
      switch (maskon) {
        case 'Yes':
          maskon = 'No';
          break;
        case 'No':
          maskon = 'Yes';
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: swap,
      child: Container(
        width: 120,
        height: 110,
        margin: EdgeInsets.all(5.0),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: updateColor(), borderRadius: BorderRadius.circular(10)),
        child: Stack(children: [
          Text(
            'Mask on?',
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
          ),
          Positioned(
              right: 10,
              bottom: 10,
              child: Text(
                '$maskon',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              )),
        ]),
      ),
    );
  }
}
