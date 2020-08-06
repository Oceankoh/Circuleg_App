import 'package:circulegapp/Globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter/services.dart';

//Code taken from: https://blog.codemagic.io/creating-iot-based-flutter-app/

class BluetoothController {
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;
  FlutterBluetoothSerial _bluetooth = FlutterBluetoothSerial.instance;
  BluetoothConnection connection;
  List<BluetoothDevice> _devicesList = [];

  BluetoothController() {
    _bluetooth.state.then((state) => _bluetoothState = state);
    _bluetooth.onStateChanged().listen((BluetoothState state) {
      _bluetoothState = state;
    });
  }

  bool get isConnected => connection != null && connection.isConnected;

  Future<void> enableBluetooth() async {
    if (_bluetoothState == BluetoothState.STATE_OFF)
      return (await _bluetooth.requestEnable());
    else
      return false;
  }

  bool _isESP32(BluetoothDevice d) {
    return (d.name == "JON");
  }

  Future<void> connectESP32() async {
    await _bluetooth.getBondedDevices().then((r) => _devicesList.addAll(r));
    for (BluetoothDevice x in _devicesList){
      if (_isESP32(x)){
        if(await _bluetooth.bondDeviceAtAddress(x.address)){
          connection = await BluetoothConnection.toAddress(x.address);
          return;
        }
      }
    }
    _bluetooth.startDiscovery().listen((r) async {
      if (_isESP32(r.device)){
        if(await _bluetooth.bondDeviceAtAddress(r.device.address)){
          connection = await BluetoothConnection.toAddress(r.device.address);
          return;
        }
      }
    });
  }

  //TODO: Call during dispose
  void dispose() {
    connection.dispose();
    connection = null;
  }
}

/*
class BTcontroller{
  BluetoothState
  FlutterBlue fblue = FlutterBlue.instance;
  void test() async{
    print("BT START");
    print(await (fblue.isAvailable));
    fblue.startScan();
    fblue.scanResults.listen((List<ScanResult> results) {
     for (ScanResult result in results) {
        print(result.device.name);
     }
   });
    fblue.connectedDevices.then((list){
      print("connected: ");
      print(list);
    });
  //TODO follow this tutorial https://medium.com/@pietrowicz.eric/bluetooth-low-energy-development-with-flutter-and-circuitpython-c7a25eafd3cf

  }
  Future<Point> getValue() async {
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    int ir;//read bt
    return Point(timestamp, ir);
  }
 }
 */
