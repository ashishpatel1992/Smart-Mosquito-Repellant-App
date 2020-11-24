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
      debugShowCheckedModeBanner: false,
      title: 'Smart Mosquito Repellent App',
      theme: ThemeData(
        primarySwatch: MaterialColor(App.baseColor, App.colorSwatch),
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.white),
          bodyText2: TextStyle(color: Colors.white),
        ),
        dialogTheme: DialogTheme(
            // backgroundColor: Colors.red,
            contentTextStyle: TextStyle(color: Colors.white, fontSize: 18),
            titleTextStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24)),
      ),
      home: MyHomePage(title: App.appName),
    );
  }
}
