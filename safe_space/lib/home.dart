import 'package:flutter/material.dart';
import 'DiscoveryPage.dart';
import 'bluetooth.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
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
            DiscoveryPage(),
            BluetoothDiscover(),
          ]),
        ));
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Hello, John",
            style: TextStyle(
                color: Colors.grey, fontSize: 30, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 200,
          ),
          Text(
            "Customize Notifications",
            style: TextStyle(color: Colors.grey),
            textAlign: TextAlign.left,
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      height: 120,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromRGBO(0, 219, 144, 1.0)),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.notifications_active,
                              color: Colors.white,
                              size: 35,
                            ),
                            Center(
                              child: Text(
                                "Sound: ON",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    height: 120,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromRGBO(0, 219, 144, 1.0)),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.vibration,
                            color: Colors.white,
                            size: 35,
                          ),
                          Center(
                            child: Text(
                              "Vibration: ON",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      height: 120,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromRGBO(0, 219, 144, 1.0)),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.animation,
                              color: Colors.white,
                              size: 35,
                            ),
                            Center(
                              child: Text(
                                "Animation: ON",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
