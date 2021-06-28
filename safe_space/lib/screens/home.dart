import 'package:flutter/material.dart';
import 'package:safe_space/models/controller_variables.dart';
import 'package:safe_space/screens/info_screen.dart';
import 'package:safe_space/screens/settings.dart';

import 'homepage.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool soundActive = sound_active;

  startBluetooth() {}

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          bottomNavigationBar: TabBar(
            indicatorColor: Color.fromRGBO(0, 219, 144, 1.0),
            tabs: [
              Tab(
                icon: Icon(
                  Icons.home,
                  color: Color.fromRGBO(0, 219, 144, 1.0),
                  size: 30,
                ),
                child: Text(
                  "Home",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.info_sharp,
                  color: Color.fromRGBO(0, 219, 144, 1.0),
                  size: 30,
                ),
                child: Text(
                  "Logs",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.settings,
                  color: Color.fromRGBO(0, 219, 144, 1.0),
                  size: 30,
                ),
                child: Text(
                  "Settings",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
          body: TabBarView(children: [
            HomePage(),
            Infomation(),
            Settings(),
          ]),
        ));
  }
}
