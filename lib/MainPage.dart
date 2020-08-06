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
  BluetoothController _btCtrl = BluetoothController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          FlatButton(child:Text("BT CONNECT"),onPressed: ()=>_checkBT(),),
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

  void _checkBT() async{
    _btCtrl.enableBluetooth();
    _btCtrl.connectESP32();
  }
}
