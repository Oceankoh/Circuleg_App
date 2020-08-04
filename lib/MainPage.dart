import 'package:circulegapp/Bluetooth.dart';
import 'package:circulegapp/Globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  String result = "awating data";
  BTcontroller btCtrl = BTcontroller();

  @override
  Widget build(BuildContext context) {
    update();
    return Scaffold(
      body: Column(
        children: <Widget>[
          //TODO insert graph
          Center(
            child: Text(
              "Blood Flow Level:" + result,
              style: Theme.of(context).textTheme.body1,
              textAlign: TextAlign.center,
            ),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }

  void update() async {
//    btCtrl.getValue().then((pt) {
//      setState(() {
//        result = pt.infraRed.toString();
//      });
//    });
    btCtrl.test();
  }
}
