import 'package:circulegapp/Bluetooth.dart';
import 'package:circulegapp/Globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:circulegapp/Graph.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'Bluetooth.dart';
import 'Globals.dart';
import 'Globals.dart';
import 'Globals.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  Firestore _db = Firestore.instance;
  String _result = "Awaiting data";
  String _connectionStatus = "Not Connected";
  BluetoothController _btCtrl = BluetoothController();
  ProgressDialog pr;

  @override
  Widget build(BuildContext context) {
    pr = ProgressDialog(context, isDismissible: false);
    pr.style(
      message: "Connecting to Device...",
      borderRadius: 10,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("CircuLeg Mobile Application"),
      ),
      body: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              Padding(
                child: Center(
                  child: Text(
                    "Bluetooth Status: $_connectionStatus",
                    style: Theme.of(context).textTheme.body1,
                  ),
                ),
                padding: EdgeInsets.all(DeviceSpecs.screenHeight * 0.02),
              ),
              MaterialButton(
                child: Text(
                  "Connect",
                  style: Theme.of(context).textTheme.button,
                ),
                onPressed: (_connectionStatus == "Not Connected") ? () => _checkBT() : null,
                color: Colors.blueAccent,
                disabledColor: Colors.grey,
              ),
            ],
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

  void _checkBT() async {
    _btCtrl.enableBluetooth();
    pr.show();
    BluetoothConnection btConn = await _btCtrl.connectESP32();
    btConn.input.listen((data) {
      pr.hide();
      setState(() => _connectionStatus = "Connected");
      String received = String.fromCharCodes(data);
      print(received);
      // if input is a number
      if (int.tryParse(received) != null) {
        setState(() => _result = received);
        DateTime _now = DateTime.now();
        _db
            .collection("T0000000A")
            .document("${_now.year}-${_now.month}-${_now.day}-${_now.hour}")
            .setData({
          "dt": _now,
          "a": {"${_now.millisecondsSinceEpoch}": int.parse(_result)}
        }, merge: true);
      }
    });
  }
}
