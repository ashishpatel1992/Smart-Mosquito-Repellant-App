import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

import 'package:smrs/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Map<int, Color> color = {
    50: Color.fromRGBO(24, 52, 71, .1),
    100: Color.fromRGBO(24, 52, 71, .2),
    200: Color.fromRGBO(24, 52, 71, .3),
    300: Color.fromRGBO(24, 52, 71, .4),
    400: Color.fromRGBO(24, 52, 71, .5),
    500: Color.fromRGBO(24, 52, 71, .6),
    600: Color.fromRGBO(24, 52, 71, .7),
    700: Color.fromRGBO(24, 52, 71, .8),
    800: Color.fromRGBO(24, 52, 71, .9),
    900: Color.fromRGBO(24, 52, 71, 1),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: MaterialColor(App.baseColor, color),
      ),
      home: MyHomePage(title: App.appName),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(App.bgColor),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _AnimatedLiquidLinearProgressIndicator(),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              color: Color(App.btnColor),
              highlightColor: Colors.yellow,
              splashColor: Colors.green,
              child: Text("ADD DEVICE",
                  style: TextStyle(color: Colors.white, fontSize: 20.0)),
              onPressed: () {
                print("Button press");
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _AnimatedLiquidLinearProgressIndicator extends StatefulWidget {
  @override
  State<StatefulWidget> createState() =>
      _AnimatedLiquidLinearProgressIndicatorState();
}

class _AnimatedLiquidLinearProgressIndicatorState
    extends State<_AnimatedLiquidLinearProgressIndicator>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 0),
    );

    _animationController.addListener(() => setState(() {}));
    _animationController.animateTo(0.45);
    // _animationController.value  = 45;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final percentage = _animationController.value * 100;

    final percentage = _animationController.value * 100;
    return Expanded(
      child: LiquidLinearProgressIndicator(
          value: _animationController.value,
          backgroundColor: Color(App.bgColor),
          valueColor: AlwaysStoppedAnimation(Colors.blue),
          borderRadius: 12.0,
          direction: Axis.vertical,
          center: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${percentage.toStringAsFixed(0)}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 70.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "%",
                    style: TextStyle(color: Colors.white, fontSize: 52.0),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleButton(
                    // iconData: Icons.adjust,
                    color: Colors.yellow,
                  ),
                  SizedBox(width: 10,),
                  Text(
                    "Normal mode",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w900,
                    ),
                  )
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleButton(
                    // iconData: Icons.adjust,
                    color: Colors.green,
                  ),
                  SizedBox(width: 10,),
                  Text(
                    "ON",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w900,
                    ),
                  )
                ],
              )
            ],
          )),
    );
  }
}

class CircleButton extends StatelessWidget {
  final GestureTapCallback onTap;
  final IconData iconData;
  final Color color;

  const CircleButton({Key key, this.onTap, this.iconData, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = 30.0;

    return new InkResponse(
      onTap: onTap,
      child: new Container(
        width: size,
        height: size,
        decoration: new BoxDecoration(
          color: color,
          shape: BoxShape.circle,

        ),
        child: new Icon(
          iconData,
          color: Colors.black,
        ),
      ),
    );
  }
}
