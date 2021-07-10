// ignore: must_be_immutable
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:safe_space/widgets/buttons.dart';
import 'package:safe_space/widgets/cards.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: 50,
          ),
          Text(
            'Hello, John',
            style: TextStyle(
                color: Colors.grey, fontSize: 25, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 5,
          ),
          Security(),
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(child: Devices()),
                Expanded(child: DistanceInfo()),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(child: RiskIndicator()),
                Expanded(child: MaskIndicator()),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Divider(),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.all(8.0),
            alignment: Alignment.bottomLeft,
            child: Text(
              "Customize notifications",
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: SoundToggle(),
                ),
                Expanded(
                  child: VibrationToggle(),
                ),
                Expanded(
                  child: AnimationToggle(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Security extends StatefulWidget {
  @override
  _SecurityState createState() => _SecurityState();
}

class _SecurityState extends State<Security> {
  int secure = 2;
  Text secureState = Text('You\'re safe');
  Icon secureIcon = Icon(Icons.check_circle);

  Random rnd = new Random();
  int min = 0, max = 3;
  updateSecurity() {
    setState(() {
      secure = rnd.nextInt(max);
      print(secure);
      switch (secure) {
        case 0:
          secureState = Text(
            "You're safe!",
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 13,
                fontWeight: FontWeight.w500),
          );
          secureIcon = Icon(
            Icons.check_circle,
            color: Theme.of(context).primaryColor,
          );
          break;
        case 1:
          secureState = Text(
            "You're at risk!",
            style: TextStyle(
                color: Colors.yellow,
                fontSize: 13,
                fontWeight: FontWeight.w500),
          );
          secureIcon = Icon(
            Icons.warning_rounded,
            color: Colors.yellow,
          );
          break;
        case 2:
          secureState = Text(
            "You're in danger!",
            style: TextStyle(
                color: Colors.red, fontSize: 13, fontWeight: FontWeight.w500),
          );
          secureIcon = Icon(
            Icons.warning_sharp,
            color: Colors.red,
          );
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: updateSecurity(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          secureState,
          secureIcon,
        ],
      ),
    );
  }
}
