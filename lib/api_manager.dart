import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:http/http.dart' as http;

import 'package:smrs/constants.dart';
import 'package:smrs/device_add_info.dart';
import 'package:smrs/device_info.dart';
import 'package:smrs/device_toggle_types.dart';
import 'device_history_info.dart';

class APIManager {


  static Future<ToggleTypes> toggleCommons(String deviceId, String requestType, String request) async{
    var client = http.Client();
    var toggleTypeData;
    var map = new Map<String,dynamic>();
    map['device_id'] = deviceId;
    map['request_type'] = requestType;
    map['request'] = request;
    try {
      var response = await client.post('${App.apiUriBase}/device',body: jsonEncode(map),headers: {HttpHeaders.CONTENT_TYPE: "application/json"} );

      // print(jsonEncode(response));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        print(jsonString);
        var jsonMap = jsonDecode(jsonString);
        // print(jsonMap);
        toggleTypeData = ToggleTypes.fromJson(jsonMap);
      }
    } catch (ex) {
      print('Error in fetching from API  ${ex}');
      return toggleTypeData;
    }
    print("Fetch Success");
    return toggleTypeData;
  }
  Future<DeviceAdd> addNewDevice(String deviceId, String deviceName) async{
    var client = http.Client();
    var addDevice;
    var map = new Map<String,dynamic>();
    map['device_id'] = deviceId;
    map['device_name'] = deviceName;
    try {
      var response = await client.post('${App.apiUriBase}/device/add',body: jsonEncode(map),headers: {HttpHeaders.CONTENT_TYPE: "application/json"} );

      // print(jsonEncode(response));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        print(jsonString);
        var jsonMap = jsonDecode(jsonString);
        // print(jsonMap);
        addDevice = DeviceAdd.fromJson(jsonMap);
      }
    } catch (ex) {
      print('Error in fetching from API  ${ex}');
      return addDevice;
    }
    print("Fetch Success");
    return addDevice;
  }

  static Future<ToggleTypes> toggleMode(String deviceId, String request) async{
    return toggleCommons(deviceId,"mode", request);
  }
  static Future<ToggleTypes> toggleOnOff(String deviceId,String request) async{
    return toggleCommons(deviceId,"onoff", request);
  }
  Future<DeviceHistory> getDeviceHistory(String deviceId) async {
    var client = http.Client();
    var toggleTypeData;
    var map = new Map<String,dynamic>();
    map['device_id'] = deviceId;
    try {
      var response = await client.post('${App.apiUriBase}/device/history/$deviceId',body: jsonEncode(map),headers: {HttpHeaders.CONTENT_TYPE: "application/json"} );

      // print(jsonEncode(response));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        print(jsonString);
        var jsonMap = jsonDecode(jsonString);
        // print(jsonMap);
        toggleTypeData = ToggleTypes.fromJson(jsonMap);
      }
    } catch (ex) {
      print('Error in fetching from API  ${ex}');
      return toggleTypeData;
    }
    print("Fetch Success");
    return toggleTypeData;
  }
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
      print('${App.apiUriBase}/device');
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
