import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:charts_flutter/flutter.dart';
import 'package:circulegapp/Globals.dart';

class Graph extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  Firestore _db = Firestore.instance;
  List<Point> _readings = List();
  bool _firstLoad = true;

  @override
  void initState() {
    _db.collection("T0000000A").where('dt',isGreaterThanOrEqualTo:DateTime.now().subtract(Duration(days:1))).where('dt',isLessThanOrEqualTo:DateTime.now().add(Duration(days:1))).snapshots().listen((QuerySnapshot q) {
      _readings.clear();      
      q.documents.forEach((d) => d.data['a'].forEach((k, v) {
            DateTime _now = DateTime.now();
            DateTime _dt =
                DateTime.fromMillisecondsSinceEpoch(int.parse(k));
            if (_dt.year == _now.year &&
                _dt.month == _now.month &&
                _dt.day == _now.day) _readings.add(Point(int.parse(k), v));
          }));
      _readings.sort((a, b) => a.timestamp - b.timestamp);
      setState(() {});
    });
    /*
    _db.collection("T0000000A").snapshots().listen((QuerySnapshot q) {
      _readings.clear();      
      q.documents.forEach((d) => d.data['a'].forEach((k, v) {
            DateTime _now = DateTime.now();
            DateTime _dt =
                DateTime.fromMillisecondsSinceEpoch(int.parse(k)*1000); //TODO: Remove *1000
            if (_dt.year == _now.year &&
                _dt.month == _now.month &&
                _dt.day == _now.day) _readings.add(Point(int.parse(k), v));
          }));
      _readings.sort((a, b) => a.timestamp - b.timestamp);
      setState(() {});
    });*/
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Series<dynamic, DateTime>> _items = [
      Series(
        id: 'IR Readings',
        domainFn: (r, _) =>
            DateTime.fromMillisecondsSinceEpoch(r.timestamp),
        measureFn: (r, _) => r.infraRed,
        seriesColor: Color.fromHex(code:"FF0000FF"),
        data: _readings,
      )
    ];
    Widget _ret = Container(
      width: DeviceSpecs.screenWidth * 0.9,
      height: DeviceSpecs.screenWidth * 0.9,
      child: _readings.length == 0
          ? Text("No Data Found")
          : TimeSeriesChart(
              _items,
              animate: true,
              animationDuration: _firstLoad?Duration(milliseconds:300):Duration(seconds: 5), 
            ),
    );
    if(_readings.length != 0)_firstLoad=false;
    return _ret;
  }
}
