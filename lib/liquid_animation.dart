import 'dart:async';

import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

import 'package:smrs/device_info.dart';
import 'package:smrs/constants.dart';

// ignore: must_be_immutable
class LiquidAnimation extends StatefulWidget {
  // double liquidValue = 0.0;
  Device device;
  final controller;

  LiquidAnimation({this.device, this.controller});

  // setUsage(double value){
  //   // this.liquidValue = device.level;
  // }
  @override
  State<StatefulWidget> createState() => _LiquidAnimationState(device: device);
}

//TODO: make it dynamic update
// How to dynamically update stateless widget from another widgetl
class _LiquidAnimationState extends State<LiquidAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Device device;
  Future<Device> futureDevice;

  _LiquidAnimationState({this.device});

  Timer timer;
  Stream stream;
  // Stream<Device> get strean => _animationController.
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 0),
    );

    _animationController.addListener(() => setState(() {}));
    _animationController.animateTo(device.level);

    stream = widget.controller.stream;
    stream.listen((event) {
      futureDevice = event;
    });
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureDevice,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          device = snapshot.data;
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            _animationController.animateTo(device.level);
          });

          return buildLiquidAnimation(device);
        } else if (snapshot.hasError) {
          return Center(
            child: Text('${snapshot.error}'),
          );
        } else {
          return buildLiquidAnimation(device);
        }
      },
    );
  }

  Expanded buildLiquidAnimation(Device device) {
    double percentage = device.level * 100;
    return Expanded(
      child: LiquidLinearProgressIndicator(
          value: _animationController.value,
          backgroundColor: Color(App.bgColor),
          valueColor: AlwaysStoppedAnimation(Colors.blue),
          borderRadius: 12.0,
          direction: Axis.vertical,
          center: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
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
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  device.mode == "normal"
                      ? CircleButton(color: Colors.yellow)
                      : CircleButton(
                          color: Colors.red,
                        ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    device.mode == "normal" ? "Normal mode" : "Active mode",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w900,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleButton(
                    // iconData: Icons.adjust,
                    color: Colors.green,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    device.deviceStatus == 1 ? "On" : "Off",
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

  const CircleButton({Key key, this.onTap, this.iconData, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = 30.0;

    return new InkResponse(
      onTap: () {
        print("button press");
      },
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
