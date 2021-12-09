import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safe_space/models/auth_service.dart';
import 'package:safe_space/screens/home.dart';
import 'package:safe_space/screens/intro_slider.dart';
import 'package:safe_space/screens/signin.dart';
import 'package:safe_space/screens/signinphone.dart';
import 'package:safe_space/screens/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import 'models/bluetooth_provider.dart';
import 'models/distance_estimator.dart';

int initScreen;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Wait for firebase initialization
  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = await prefs.getInt('initScreen');
  await prefs.setInt('initScreen', 1);
  //Wait for firebase initialization
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => DistanceEstimator()),
      ChangeNotifierProvider(create: (_) => Bluetooth()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Safe Space',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(0, 219, 144, 1.0),
        accentColor: Color.fromRGBO(220, 247, 220, 1),
        scaffoldBackgroundColor: Color(0xFFF3F5F7),
        focusColor: Color.fromRGBO(0, 219, 144, 1.0),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: initScreen == 0 || initScreen == null ? '/' : '\signup',
      routes: {
        '/': (context) => IntroSliderPage(),
        '\signin': (context) => SignIn(),
        '\login': (context) => LoginPage(),
        '\signup': (context) => SignUp(),
        '\home': (context) => Homepage(),
      },
    );
  }
}

