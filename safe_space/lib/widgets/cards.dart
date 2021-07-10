import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_space/models/bluetooth_provider.dart';
import 'package:safe_space/models/distance_estimator.dart';

class Devices extends StatefulWidget {
  @override
  _DevicesState createState() => _DevicesState();
}

class _DevicesState extends State<Devices> {
  Color updateColor(int devices) {
    if (devices > 2 && devices < 4) {
      return Colors.yellow;
    } else if (devices >= 4) {
      return Colors.red;
    } else {
      return Color.fromRGBO(0, 219, 144, 1.0);
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
          color: updateColor(context.watch<Bluetooth>().devicenum),
          borderRadius: BorderRadius.circular(10)),
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
              '${context.watch<Bluetooth>().devicenum}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
            )),
      ]),
    );
  }
}

class DistanceInfo extends StatelessWidget {
  double distance = 1.0;
  Color updateColor(double distance) {
    if (distance < 1.0 && distance >= 0.3) {
      return Colors.yellow;
    } else if (distance < 0.3) {
      return Colors.red;
    } else {
      return Color.fromRGBO(0, 219, 144, 1.0);
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
          color: updateColor(
              double.parse(context.watch<DistanceEstimator>().distancecal)),
          borderRadius: BorderRadius.circular(10)),
      child: Stack(children: [
        Text(
          'Distance from nearest device',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
        ),
        Positioned(
          right: 10,
          bottom: 10,
          child: DistanceEstimator().distancecal == null
              ? Text('${context.watch<DistanceEstimator>().distancecal}' + 'm',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ))
              : Text('Not available',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  )),
        ),
      ]),
    );
  }
}

class RiskIndicator extends StatefulWidget {
  @override
  _RiskIndicatorState createState() => _RiskIndicatorState();
}

class _RiskIndicatorState extends State<RiskIndicator> {
  String risk;
  int riskIndicator = 0;
  Color updateColor(int devices, double distance) {
    if (devices < 2 && distance > 1) {
      risk = "LOWLOW";
      riskIndicator = 0;
    }
    if (devices < 2 && distance > 1) {
      risk = "LOWHIGH";
      riskIndicator = 10;
    }
    if (devices >= 2 && distance < 1 && distance > 0.5) {
      risk = "MEDIUMLOW";
      riskIndicator = 20;
    }
    if (devices >= 2 && distance < 1 && distance > 0.5) {
      risk = "MEDIUMHIGH";
      riskIndicator = 40;
    }
    if (devices == 0) {
      risk = "LOWLOW";
      riskIndicator = 0;
    }

    if (devices >= 5 && distance <= 0.5) {
      risk = "HIGHLOW";
      riskIndicator = 70;
    }
    if (devices >= 5 && distance <= 0.5) {
      risk = "HIGHHIGH";
      riskIndicator = 90;
    }

    switch (risk) {
      case "LOWLOW":
        return Color.fromRGBO(0, 219, 144, 1.0);
        break;
      case "LOWHIGH":
        return Colors.yellow[400];
        break;
      case "MEDIUMLOW":
        return Colors.yellow;
        break;
      case "MEDIUMHIGH":
        return Colors.yellow[600];
        break;
      case "HIGHLOW":
        return Colors.red;
        break;
      case "HIGHHIGH":
        return Colors.red[900];
        break;
      default:
        return Color.fromRGBO(0, 219, 144, 1.0);
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
          color: updateColor(context.watch<Bluetooth>().devicenum,
              double.parse(context.watch<DistanceEstimator>().distancecal)),
          borderRadius: BorderRadius.circular(10)),
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
              '$riskIndicator%',
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
    if (maskon.toLowerCase() == 'yes') return Color.fromRGBO(0, 219, 144, 1.0);
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
