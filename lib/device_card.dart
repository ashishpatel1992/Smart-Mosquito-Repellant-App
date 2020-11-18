import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:smrs/device_info.dart';

import 'package:smrs/liquid_animation.dart';
class DeviceCard{
  LiquidAnimation liquidAnimation;
  double usage;
  Device device;

  DeviceCard(Device _device){
    device = _device;
    usage = _device.level;
  }

  Widget getDevice(){

    return Scaffold(
      backgroundColor: Color(App.bgColor),
      appBar: AppBar(
        title: Text(device.deviceName == null ? device.deviceId : '${device.deviceName} (${device.deviceId})' ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            liquidAnimation = LiquidAnimation(
              device: device,
            ),
          ],
        ),
      ),
      // bottomNavigationBar: Padding(
      //   padding: EdgeInsets.symmetric(vertical: 10.0),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       RaisedButton(
      //         color: Color(App.btnColor),
      //         highlightColor: Colors.yellow,
      //         splashColor: Colors.green,
      //         child: Text("ADD DEVICE",
      //             style: TextStyle(color: Colors.white, fontSize: 20.0)),
      //         onPressed: () {
      //           print("Button press");
      //           // LiquidAnimation la = LiquidAnimation();
      //           // liquidAnimation.setUsage(0.95);
      //         },
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}