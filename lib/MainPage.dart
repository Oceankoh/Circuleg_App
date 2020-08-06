import 'package:circulegapp/Bluetooth.dart';
import 'package:circulegapp/Globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:circulegapp/Graph.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

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
    BluetoothConnection btConn= await _btCtrl.connectESP32();
    btConn.input.listen((data){
      String recv = String.fromCharCodes(data);
      print(recv);
    });
  }
}
