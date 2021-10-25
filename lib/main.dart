import 'package:flutter/material.dart';

import 'Screens/phone.dart';

void main() {
  runApp(mainApp());
}

class mainApp extends StatefulWidget {
  const mainApp({Key? key}) : super(key: key);
  @override
  _mainAppState createState() => _mainAppState();
}

class _mainAppState extends State<mainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: phonePage(),
      theme: new ThemeData(
          textTheme: const TextTheme(
              headline1: TextStyle(
                  fontSize: 14, color: Colors.black, fontFamily: 'vazir'),
              headline2: TextStyle(
                  fontSize: 22,
                  color: Colors.blue,
                  fontFamily: 'vazir',
                  fontWeight: FontWeight.bold))),
    );
  }
}
