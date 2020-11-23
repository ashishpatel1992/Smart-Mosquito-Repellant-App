import 'dart:async';
import 'dart:convert';

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
        title: Text(
          widget.device.deviceName == null
              ? widget.device.deviceId
              : '${widget.device.deviceName} (${widget.device.deviceId})',
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: Center(
        child: FutureBuilder<Device>(
            future: _device,
            builder: (context, snapshot) {
              // print('Error here: ${snapshot.hasError}, ${snapshot.hasData} ${snapshot.connectionState}');
              if (!snapshot.hasError && snapshot.hasData) {
                if (snapshot.data.deviceId == "-1") {
                  return apiErrorHandler(
                      "Device not found", "Invalid device requested");
                }
                var myDevice = snapshot.data;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    LiquidAnimation(device: myDevice, controller: _controller),
                  ],
                );
              } else if (snapshot.hasError) {
                return apiErrorHandler(
                    "Error while reaching server", snapshot.error.toString());
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

  Center apiErrorHandler(String errorTitle, String errorMsg) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.cancel, color: Colors.red),
              SizedBox(
                width: 10,
              ),
              Text(
                errorTitle,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Debug Message:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        border: Border.all(color: Colors.white)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        errorMsg,
                        style: TextStyle(),
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
