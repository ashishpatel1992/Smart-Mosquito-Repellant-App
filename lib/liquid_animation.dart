import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

import 'package:smrs/constants.dart';


// ignore: must_be_immutable
class LiquidAnimation extends StatefulWidget {
  double liquidValue = 0.0;
  LiquidAnimation({this.liquidValue});

  setUsage(double value){
    this.liquidValue = value;
  }
  @override
  State<StatefulWidget> createState() =>
      _LiquidAnimationState(usage: liquidValue);
}

class _LiquidAnimationState
    extends State<LiquidAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  double usage;
  _LiquidAnimationState({this.usage});

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 0),
    );

    _animationController.addListener(() => setState(() {}));
    _animationController.animateTo(usage);
    // _animationController.value  = 45;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
