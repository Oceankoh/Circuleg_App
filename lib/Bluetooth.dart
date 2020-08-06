import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

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

  Future<bool> enableBluetooth() async {
    if (_bluetoothState == BluetoothState.STATE_OFF)
      return (await _bluetooth.requestEnable());
    else
      return true;
  }

  bool _isESP32(BluetoothDevice d) { //TODO: Change to ESP check
    return (d.name == "ESP32test");
  }

  Future<BluetoothConnection> connectESP32() async {
    print("Starting");
    await _bluetooth.getBondedDevices().then((r) => _devicesList.addAll(r));
    for (BluetoothDevice x in _devicesList){
      if (_isESP32(x)){
        if(x.bondState == BluetoothBondState.bonded || await _bluetooth.bondDeviceAtAddress(x.address)){
          connection = await BluetoothConnection.toAddress(x.address);
          print("Connected to ${x.name}");
          return connection;
        }
      }
    }

    _bluetooth.startDiscovery().listen((r) async {
      if (_isESP32(r.device)){
        if(r.device.bondState == BluetoothBondState.bonded || await _bluetooth.bondDeviceAtAddress(r.device.address)){
          connection = await BluetoothConnection.toAddress(r.device.address);
          print("Connected to ${r.device.name}");
          _bluetooth.cancelDiscovery();
          return connection;
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