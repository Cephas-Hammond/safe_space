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
  // ignore: deprecated_member_use
  List<Slide> slides = [];

  @override
  void initState() {
    super.initState();
    slides.add(new Slide(
      title: "This is Safe Space",
      description: "The app that keeps you safe",
      pathImage: "images/social_distance.png",
    ));
    slides.add(new Slide(
      title: "How it Works",
      description:
          "Safe Space uses bluetooth technology to determine distance between you and the nearest person",
      pathImage: "images/wash_hands.png",
    ));
    slides.add(new Slide(
      title: "It Reminds You",
      description:
          "Safe Space also helps you to always stay alert by providing with necessary notifications and reminders ",
      pathImage: "images/travel.png",
    ));
  }

  List<Widget> renderListCustomTabs() {
    List<Widget> tabs = [];
    for (int i = 0; i < slides.length; i++) {
      Slide currentSlide = slides[i];
      tabs.add(Container(
        width: double.infinity,
        height: double.infinity,
        child: Container(
          margin: EdgeInsets.only(bottom: 160, top: 60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Image.asset(
                    currentSlide.pathImage,
                    matchTextDirection: true,
                    height: 68,
                  )),
              Container(
                child: Text(
                  currentSlide.title,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                child: Text(
                  currentSlide.description,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
                margin: EdgeInsets.only(
                  top: 15,
                  left: 20,
                  right: 20,
                ),
              ),
            ],
          ),
        ),
      ));
    }
    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
        backgroundColorAllSlides: Colors.white,
        renderSkipBtn: Text("Skip", style: TextStyle(color: Colors.green[700])),
        renderNextBtn: Text(
          "Next",
          style: TextStyle(color: Colors.green[700]),
        ),
        renderDoneBtn: Text(
          "Done",
          style: TextStyle(color: Colors.green[700]),
        ),
        colorDoneBtn: Colors.green,
        colorActiveDot: Colors.green,
        sizeDot: 8.0,
        typeDotAnimation: dotSliderAnimation.SIZE_TRANSITION,
        listCustomTabs: this.renderListCustomTabs(),
        scrollPhysics: BouncingScrollPhysics(),
        hideStatusBar: false,
        onDonePress: () {
          Timer(Duration(seconds: 3), () {
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (_) => Homepage()));
          });
        }
        //: false,
        );
  }
}
