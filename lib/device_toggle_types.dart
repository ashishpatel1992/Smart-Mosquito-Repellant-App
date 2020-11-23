import 'dart:convert';

ToggleTypes toggleTypesFromJson(String str) => ToggleTypes.fromJson(json.decode(str));

String toggleTypesToJson(ToggleTypes data) => json.encode(data.toJson());

class ToggleTypes {
  ToggleTypes({
    this.deviceId,
    this.requestResponse,
    this.requestType,
    this.success,
  });

  String deviceId;
  String requestResponse;
  String requestType;
  int success;

  factory ToggleTypes.fromJson(Map<String, dynamic> json) => ToggleTypes(
    deviceId: json["device_id"],
    requestResponse: json["request_response"],
    requestType: json["request_type"],
    success: json["success"],
  );

  Map<String, dynamic> toJson() => {
    "device_id": deviceId,
    "request_response": requestResponse,
    "request_type": requestType,
    "success": success,
  };
}