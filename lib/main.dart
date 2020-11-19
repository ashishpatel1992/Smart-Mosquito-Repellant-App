import 'package:flutter/material.dart';

import 'package:smrs/constants.dart';
import 'home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: MaterialColor(App.baseColor, App.colorSwatch),
          textTheme: TextTheme(
              bodyText1: TextStyle(color: Colors.white),
              bodyText2: TextStyle(color: Colors.white))
          // visualDensity: VisualDensity.adaptivePlatformDensity
          ),
      home: MyHomePage(title: App.appName),
    );
  }
}
