
import 'dart:convert';

DeviceAdd deviceAddFromJson(String str) => DeviceAdd.fromJson(json.decode(str));

String deviceAddToJson(DeviceAdd data) => json.encode(data.toJson());

class DeviceAdd {
  DeviceAdd({
    this.deviceId,
    this.success,
  });

  String deviceId;
  int success;

  factory DeviceAdd.fromJson(Map<String, dynamic> json) => DeviceAdd(
    deviceId: json["device_id"],
    success: json["success"],
  );

  Map<String, dynamic> toJson() => {
    "device_id": deviceId,
    "success": success,
  };
}
