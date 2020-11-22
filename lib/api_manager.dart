import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;

import 'package:smrs/constants.dart';
import 'package:smrs/device_info.dart';

class APIManager {
  Future<DevicesModel> getDevices() async {
    var client = http.Client();
    var deviceModel;

    try {
      var response = await client.get('${App.apiUriBase}/devices');
      if (response.statusCode == 200) {
        var jsonString = response.body;
        // print(jsonString);
        var jsonMap = jsonDecode(jsonString);
        // print(jsonMap);
        deviceModel = DevicesModel.fromJson(jsonMap);
      }
    } catch (ex) {
      print('Error in fetching from API  ${ex}');
      return deviceModel;
    }
    print("Fetch Success");
    return deviceModel;
  }

  Future<Device> getDeviceById(String id) async {
    var client = http.Client();
    Device device;
    // Map<String, dynamic> _map = Map<String, dynamic>();
    // _map['device_id'] = id;
    try {
      print('${App.apiUriBase}device');
      var response = await client.get('${App.apiUriBase}/device/$id');
      // print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = jsonDecode(jsonString);
        device = Device.fromJson(jsonMap);
        return device;
      } else if (response.statusCode == 404) {
        return device = new Device(deviceId: "-1");
      }
    } catch (ex) {
      StateError(ex);
      return device;
    }
    return device;
  }
}
