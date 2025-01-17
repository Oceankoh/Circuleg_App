import 'package:circulegapp/MainPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:circulegapp/Globals.dart';
import 'package:flutter/material.dart';
import 'package:animator/animator.dart';
import 'package:flutter/widgets.dart';
import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SplashState();
}

class SplashState extends State<Splash> {
  initSharedPreferences() async {
    SharedPreferences.getInstance().then((prefs) {});
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    initSharedPreferences();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).canvasColor,
        body: Center(key: UniqueKey(), child: LoadAnimation()));
  }
}

class LoadAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DeviceSpecs.screenHeight = MediaQuery.of(context).size.height;
    DeviceSpecs.screenWidth = MediaQuery.of(context).size.width;
    return Container(
        child: Center(
            child: Column(children: [
      Container(
        child: Animator(
          tween: Tween<double>(begin: 0, end: 2 * pi),
          duration: Duration(seconds: 2),
          repeats: 0,
          curve: Curves.easeInOutQuart,
          builder: (anim) => Transform.rotate(
            angle: anim.value,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(pi),
                child: Icon(Icons.sync, size: 50),
              ),
            ),
          ),
        ),
      ),
      Text(
        'Loading',
        style: TextStyle(fontSize: 30, color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
      ),
    ], mainAxisAlignment: MainAxisAlignment.center)));
  }
}
