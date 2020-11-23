import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:smrs/api_manager.dart';

import 'package:smrs/device_info.dart';
import 'package:smrs/constants.dart';
import 'package:smrs/device_toggle_types.dart';

// ignore: must_be_immutable
class LiquidAnimation extends StatefulWidget {
  // double liquidValue = 0.0;
  Device device;
  final controller;
  Timer timer;

  LiquidAnimation({this.device, this.controller, this.timer});

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
              device.deviceStatus == 1 ?InkWell(
                onTap: () {
                  Future<ToggleTypes> response;
                  // if(widget.timer.isActive){
                  //   widget.timer.cancel();
                  //   print(widget.timer);
                  // }
                  if (device.mode == 1) {
                    // setState(() {
                    //   device.mode = 0;
                    // });
                    setState(() {

                    });
                    response = APIManager.toggleMode(
                        device.deviceId, App.DEVICE_MODE_NORMAL);
                  } else {
                    // setState(() {
                    //   device.mode = 1;
                    // });
                    setState(() {

                    });
                    response = APIManager.toggleMode(
                        device.deviceId, App.DEVICE_MODE_ACTIVE);
                  }
                  // TODO fix toggling issue after active mode then off mode fix! needed! urgent!
                  Scaffold.of(context).showSnackBar(SnackBar(
                    duration: Duration(seconds: App.SNACKBAR_DELAY),
                    content: Text(
                        'Switching to ${device.mode == 0 ? "ACTIVE" : "NORMAL"} mode' ),
                  ));
                  response.then((resp) {
                    setState(() {
                      print(resp.success);
                      device.mode =
                          resp.requestResponse == App.DEVICE_MODE_ACTIVE
                              ? 1
                              : 0;
                    });
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(color: Color(0x33080808)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      device.mode == 0
                          ? CircleButton(color: Colors.yellow)
                          : CircleButton(
                              color: Colors.red,
                            ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        device.mode == 0 ? App.DEVICE_TEXT_NORMAL : App.DEVICE_TEXT_ACTIVE,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.0,
                          fontWeight: FontWeight.w900,
                        ),
                      )
                    ],
                  ),
                ),
              ) : Container(),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Future<ToggleTypes> response;
                  if (device.deviceStatus == 1) {
                    // setState(() {
                    //   device.deviceStatus = 0;
                    // });
                    response =
                        APIManager.toggleOnOff(device.deviceId, App.DEVICE_OFF);
                  } else {
                    // setState(() {
                    //   device.deviceStatus = 1;
                    // });
                    response =
                        APIManager.toggleOnOff(device.deviceId, App.DEVICE_ON);
                  }

                  Scaffold.of(context).showSnackBar(SnackBar(
                    duration: Duration(seconds: App.SNACKBAR_DELAY),
                    content: Text(
                        'Turning the device ${device.deviceStatus == 0 ? "ON" : "OFF"}'),
                  ));
                  response.then((resp) {
                    setState(() {
                      print(resp.success);
                      device.deviceStatus =
                          resp.requestResponse == App.DEVICE_ON ? 0 : 1;
                    });
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(color: Color(0x33080808)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleButton(
                        // iconData: Icons.adjust,
                        color: device.deviceStatus == 1
                            ? Colors.green
                            : Colors.red,
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
                  ),
                ),
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
      onTap: onTap,
      child: new Container(
        width: size,
        height: size,
        decoration: new BoxDecoration(
            color: color,
            // shape: BoxShape.circle,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(width: 2,color: Colors.white70)),
        child: new Icon(
          iconData,
          color: Colors.black,
        ),
      ),
    );
  }
}
