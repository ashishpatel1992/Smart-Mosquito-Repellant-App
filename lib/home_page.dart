import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';

import 'package:smrs/constants.dart';
import 'package:smrs/device_info.dart';
import 'package:smrs/api_manager.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'device_list_card.dart';

// TODO: Pull down to refresh
final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<DevicesModel> _deviceModel;
  Timer timer;

  @override
  void initState() {
    _deviceModel = APIManager().getDevices();
    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        _deviceModel = APIManager().getDevices();
      });
      print("updated");
    });
    print("InitState");
    super.initState();
  }

  @override
  void dispose() {
    // timer.cancel();
    // print("dispose called");
    super.dispose();
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
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Color(App.bgCardColor)),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                color: Color(App.btnColor),
                highlightColor: Colors.yellow,
                splashColor: Colors.green,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("ADD DEVICE",
                      style: TextStyle(color: Colors.white, fontSize: 20.0)),
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        TextEditingController _tfDeviceId =
                            TextEditingController();
                        TextEditingController _tfDeviceName =
                            TextEditingController();
                        final _formKey = GlobalKey<FormState>();
                        bool isProcessing = false;
                        // setState(() {
                        //   isProcessing = false;
                        // });
                        return AlertDialog(
                          title: Text("Add a new device"),
                          backgroundColor: Color(App.bgCardColor),
                          actions: [
                            FlatButton(
                                child: Text('CANCEL',
                                    style: TextStyle(color: Colors.white)),
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                            FlatButton(
                              child: Text("ADD",
                                  style: TextStyle(color: Colors.white)),
                              // color: Color(App.btnColor),
                              onPressed: () {
                                print("Btn Press");
                                print(_tfDeviceName.text);
                                print(_tfDeviceId.text);
                                if (_formKey.currentState.validate()) {
                                  print("Data is Valid");
                                  setState(() {
                                    isProcessing = true;
                                  });
                                  // _tfDeviceName.addListener(() {
                                  //   print("Do Task");
                                  //   setState(() {
                                  //     isProcessing = true;
                                  //   });
                                  // });
                                  // _tfDeviceName.notifyListeners();

                                  sleep(const Duration(seconds:2));
                                  Navigator.pop(context);
                                }
                              },
                              padding: EdgeInsets.all(18.0),
                            )
                          ],
                          content: Container(
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  buildTextFieldForAlertDialog(
                                      _tfDeviceId, 'Enter Device ID'),
                                  buildTextFieldForAlertDialog(
                                      _tfDeviceName, 'Enter Device Name'),
                                  SizedBox(height: 25,),
                                  isProcessing
                                      ? Center(child: CircularProgressIndicator(backgroundColor: Colors.white,))
                                      : Container(),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField buildTextFieldForAlertDialog(
      TextEditingController _tfDeviceId, String hintText) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white60),
      ),
      style: TextStyle(color: Colors.white),
      autofocus: true,
      controller: _tfDeviceId,
      autocorrect: false,
      enabled: true,
      cursorColor: Colors.white,
      validator: (value) {
        if (value.isEmpty) {
          return "This field Cannot be empty";
        }
        return null;
      },
    );
  }

  FutureBuilder<DevicesModel> deviceListBuilder() {
    return FutureBuilder<DevicesModel>(
      future: _deviceModel,
      builder: (context, snapshot) {
        print("SomeData ${snapshot.hasData}");
        if (snapshot.hasData) {
          if (snapshot.data.devices.length > 0) {
            return Scrollbar(
              child: ListView.builder(
                itemCount: snapshot.data.devices.length,
                itemBuilder: (context, index) {
                  var device = snapshot.data.devices[index];
                  return DeviceListCard(
                    device: device,
                    timer: timer,
                  );
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
                Text(
                  "Please wait...",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
                SizedBox(
                  height: 10,
                ),
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
