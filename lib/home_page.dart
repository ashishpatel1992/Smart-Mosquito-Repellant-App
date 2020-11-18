import 'package:flutter/material.dart';

import 'package:smrs/constants.dart';
import 'package:smrs/device_info.dart';
import 'package:smrs/api_manager.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'device_list_card.dart';

// TODO: Pull down to refresh

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<DevicesModel> _deviceModel;

  @override
  void initState() {
    _deviceModel = APIManager().getDevices();
    print("InitState");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(App.bgColor),
      appBar: AppBar(
        title: Text(
          "All Devices",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        child: deviceListBuilder(),
      ),
    );
  }

  FutureBuilder<DevicesModel> deviceListBuilder() {
    return FutureBuilder<DevicesModel>(
        future: _deviceModel,
        builder: (context, snapshot) {
          // print("SomeData ${snapshot.hasData}");
          if (snapshot.hasData) {
            if (snapshot.data.devices.length > 0) {
              return Scrollbar(
                child: ListView.builder(
                  
                  itemCount: snapshot.data.devices.length,
                  itemBuilder: (context, index) {
                    var device = snapshot.data.devices[index];
                    return DeviceListCard(device: device);
                  },
                ),
              );
            } else {
              return Container(
                child: Center(
                  child: Text(
                    "No device registered",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              );
            }
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Please wait...",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 24),),
                  SizedBox(height: 10,),
                  CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  ),
                ],
              ),
            );
          }
        },
      );
  }
}
