import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;

import 'package:smrs/constants.dart';
import 'package:smrs/device_info.dart';

class APIManager{
  Future<DevicesModel> getDevices() async{
    var client = http.Client();
    var deviceModel;

    try{
      var response = await client.get('${App.apiUriBase}/devices');
      if(response.statusCode == 200){
        var jsonString = response.body;
        var jsonMap = jsonDecode(jsonString);
        print(jsonMap);
        deviceModel = DevicesModel.fromJson(jsonMap);

      }
    }catch(ex){
      print('Error in fetching from API  ${ex}');
      return deviceModel;
    }
    print("Fetch Success");
    return deviceModel;
  }
}