import 'package:flutter/material.dart';
import 'package:safe_space/models/controller_variables.dart';
import 'package:safe_space/screens/info_screen.dart';
import 'package:safe_space/screens/settings.dart';
import 'package:safe_space/widgets/buttons.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool soundActive = sound_active;

  startBluetooth(){

  }

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

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                  height: 400,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(25.0),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0.0, 2.0),
                            blurRadius: 6.0)
                      ]),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25.0),
                    child: Image(
                      image: AssetImage("images/home.jpg"),
                      fit: BoxFit.cover,
                    ),
                  )),
              Positioned(
                top: 50,
                left: 20,
                child: Text(
                  "Hello",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Text(
            "Customize Notifications",
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
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
