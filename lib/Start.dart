import 'package:flutter/material.dart';
import 'package:circulegapp/Splash.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
        textTheme: TextTheme(
          title: TextStyle(fontSize: 25),
          subhead: TextStyle(fontSize: 20),
          caption: TextStyle(fontSize: 17,),
          body1: TextStyle(fontSize: 15),
          button: TextStyle(fontSize: 17),
        ),
      ),
      home: Splash(),
    );
  }
}
