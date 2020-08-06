import 'package:circulegapp/Bluetooth.dart';
import 'package:circulegapp/Globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:circulegapp/Graph.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import 'Bluetooth.dart';
import 'Globals.dart';
import 'Globals.dart';
import 'Globals.dart';

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
      appBar: AppBar(
        title: Text("Circuleg Mobile Application"),
      ),
      body: Column(
        children: <Widget>[
          MaterialButton(
            child: Text(
              "Bluetooth Connect",
              style: Theme.of(context).textTheme.button,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ConnectBluetooth()));
            },
            color: Colors.blueAccent,
          ),
          Graph(),
          Row(
            children: <Widget>[
              Center(
                child: Text(
                  "Blood Flow Level: ",
                  style: Theme.of(context).textTheme.body1,
                ),
              ),
              Center(
                child: Text(
                  _result,
                  style: Theme.of(context).textTheme.body1,
                ),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      ),
    );
  }

  void _checkBT() async{
    _btCtrl.enableBluetooth();
    BluetoothConnection btConn= await _btCtrl.connectESP32();
    btConn.input.listen((data){
      String recv = String.fromCharCodes(data);
      print(recv);
    });
  }
}
