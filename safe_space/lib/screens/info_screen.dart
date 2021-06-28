import 'package:flutter/material.dart';
import 'package:safe_space/models/bluetooth.dart';
import 'package:safe_space/models/controller_variables.dart';

class Infomation extends StatelessWidget {
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
            // child: Image(
            //   image: AssetImage("images/home.jpg"),
            //   fit: BoxFit.cover,
            // ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("There are currently"),
                    Text('$counter'),
                    Text("possible people around you")
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
