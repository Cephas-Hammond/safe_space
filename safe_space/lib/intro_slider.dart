//import 'dart:html';

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intro_slider/dot_animation_enum.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';

import 'home.dart';

class IntroSliderPage extends StatefulWidget {
  @override
  _IntroSliderPageState createState() => _IntroSliderPageState();
}

class _IntroSliderPageState extends State<IntroSliderPage> {
  List<Slide> slides = [];

  @override
  void initState() {
    super.initState();
    slides.add(new Slide(
      backgroundColor: Colors.white,
      title: "Welcome to SafeSpace",
      maxLineTitle: 2,
      styleTitle: TextStyle(
          color: Colors.grey, fontSize: 25, fontWeight: FontWeight.w600),
      description: "Safe Space periodically reminds individuals to"
          " observe Covid-19 protocols to help reduce its spread.",
      styleDescription: TextStyle(
        color: Colors.grey,
        fontSize: 15,
      ),
      pathImage: "images/main_illustration.png",
    ));
    slides.add(new Slide(
      backgroundColor: Colors.white,
      description:
          "No distractions? Yes please. Notifications are highly customizable"
          " to suit the occasion. Just tap on any setting to toggle its state",
      styleDescription: TextStyle(
        color: Colors.grey,
        fontSize: 15,
      ),
      pathImage: "images/notification_buttons.png",
    ));
  }

  @override
  Widget build(BuildContext constext) {
    return IntroSlider(
        slides: this.slides,
        renderSkipBtn: Text("Skip",
            style: TextStyle(color: Color.fromRGBO(0, 219, 144, 1.0))),
        renderNextBtn: Text(
          "Next",
          style: TextStyle(color: Colors.white),
        ),
        renderDoneBtn: Text(
          "Done",
          style: TextStyle(color: Colors.white),
        ),
        colorDoneBtn: Color.fromRGBO(0, 219, 144, 1.0),
        colorActiveDot: Color.fromRGBO(0, 219, 144, 1.0),
        sizeDot: 8.0,
        typeDotAnimation: dotSliderAnimation.SIZE_TRANSITION,
        scrollPhysics: BouncingScrollPhysics(),
        hideStatusBar: false,
        onDonePress: () {
          Timer(Duration(seconds: 2), () {
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (_) => Homepage()));
          });
        });
  }
}
