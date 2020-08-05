import 'package:circulegapp/Bluetooth.dart';
import 'package:circulegapp/Globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:circulegapp/Graph.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  String _result = "awating data";
  BTcontroller _btCtrl = BTcontroller();

  @override
  Widget build(BuildContext context) {
    _update();
    return Scaffold(
      body: Column(
        children: <Widget>[
          Graph(),
          Center(
            child: Text(
              "Blood Flow Level:" + _result,
              style: Theme.of(context).textTheme.body1,
              textAlign: TextAlign.center,
            ),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }

  void _update() async {
//    btCtrl.getValue().then((pt) {
//      setState(() {
//        result = pt.infraRed.toString();
//      });
//    });
    _btCtrl.test();
  }
}
