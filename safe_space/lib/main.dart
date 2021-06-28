//import 'dart:async';
//import 'dart:ffi';
//import 'dart:html';

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

int initScreen;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Wait for firebase initialization
  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = await prefs.getInt('initScreen');
  await prefs.setInt('initScreen', 1);
  //Wait for firebase initialization
  await Firebase.initializeApp();
  runApp(MyApp());
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
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: initScreen == 0 || initScreen == null
          ? '/'
          : 'signup',
      routes: {
        '/': (context) => IntroSliderPage(),
        'signin': (context) => SignIn(),
        'login': (context) => LoginPage(),
        'signup': (context) => SignUp(),
        'home': (context) => Homepage(),
      },
    );
  }
}

// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Timer(Duration(seconds: 5), () {
//       Navigator.of(context)
//           .pushReplacement(MaterialPageRoute(builder: (_) => Homepage()));
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Image.asset('images/social_distance.png'),
//             SizedBox(
//               height: 30,
//             ),
//             CircularProgressIndicator(
//               valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
