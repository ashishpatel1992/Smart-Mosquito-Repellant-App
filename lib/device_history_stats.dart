import 'dart:async';
import 'package:flutter/material.dart';
import 'package:smrs/api_manager.dart';
import 'package:smrs/constants.dart';
import 'package:smrs/device_history_info.dart';

class DeviceHistoryCard extends StatefulWidget {
  String deviceId;

  DeviceHistoryCard(String _deviceId) {
    deviceId = _deviceId;
  }

  @override
  _DeviceHistoryCardState createState() => _DeviceHistoryCardState();
}

class _DeviceHistoryCardState extends State<DeviceHistoryCard> {
  Future<DeviceHistory> deviceHistory;

  // Timer timer;

  @override
  void initState() {
    deviceHistory = APIManager().getDeviceHistory(widget.deviceId);

    print('Device update..');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [],
        ),
        body: Container(
          child: Text(widget.deviceId),
          color: Colors.black87,
        ));
  }
}
