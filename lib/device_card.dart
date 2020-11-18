import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'api_manager.dart';
import 'constants.dart';
import 'package:smrs/device_info.dart';

import 'package:smrs/liquid_animation.dart';

class DeviceCard extends StatefulWidget {
  double usage;
  Device device;

  DeviceCard(Device _device) {
    device = _device;
    usage = _device.level;
  }

  @override
  _DeviceCardState createState() => _DeviceCardState();
}

class _DeviceCardState extends State<DeviceCard> {
  Future<Device> _device;
  Device normalDevice;
  ValueNotifier<LiquidAnimation> liquidAnimation;
  Timer timer;
  StreamController<Future<Device>> _controller = StreamController.broadcast();

  @override
  void initState() {
    // Stream stream = _controller.stream;

    _device = APIManager().getDeviceById(widget.device.deviceId);

    timer = Timer.periodic(Duration(seconds: App.apiRefreshRate), (timer) {
      setState(() {
        _device = APIManager().getDeviceById(widget.device.deviceId);
        _controller.add(_device);
      });
      print('Device update..');
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.close();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {});
    return Scaffold(
      backgroundColor: Color(App.bgColor),
      appBar: AppBar(
        title: Text(widget.device.deviceName == null
            ? widget.device.deviceId
            : '${widget.device.deviceName} (${widget.device.deviceId})'),
      ),
      body: Center(
        child: FutureBuilder<Device>(future: _device, builder: (context, snapshot) {
          if (snapshot.hasData) {
            var myDevice = snapshot.data;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                LiquidAnimation(device: myDevice, controller: _controller),
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
              ),
            );
          }
        }),
      ),
      //
    );
  }
}

// class DeviceCard{
//   // LiquidAnimation liquidAnimation;
//   // double usage;
//   // Device device;
//
//   DeviceCard(Device _device){
//     device = _device;
//     usage = _device.level;
//   }
//
//   Widget getDevice(){
//
//
//   }
// }
