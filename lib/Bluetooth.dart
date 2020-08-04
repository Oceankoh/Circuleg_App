 import 'package:circulegapp/Globals.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BTcontroller{
  FlutterBlue fblue = FlutterBlue.instance;
  void test() async{
//    fblue.startScan(timeout: Duration(seconds: 4));
//    fblue.connectedDevices.then((list){
//      print("connected: ");
//      print(list);
//    });
    
  }
  Future<point> getValue() async {
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    int ir;//read bt
    return point(timestamp, ir);
  }
 }