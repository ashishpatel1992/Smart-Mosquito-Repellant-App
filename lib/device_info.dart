// To parse this JSON data, do
//
//     final deviceNodes = deviceNodesFromJson(jsonString);
import 'dart:convert';

DevicesModel devicesModelFromJson(String str) => DevicesModel.fromJson(json.decode(str));

String devicesModelToJson(DevicesModel data) => json.encode(data.toJson());

class DevicesModel {
  DevicesModel({
    this.count,
    this.devices,
  });

  int count;
  List<Device> devices;

  factory DevicesModel.fromJson(Map<String, dynamic> json) => DevicesModel(
    count: json["count"],
    devices: List<Device>.from(json["devices"].map((x) => Device.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "devices": List<dynamic>.from(devices.map((x) => x.toJson())),
  };
}


class Device {
  Device({
    this.deviceId,
    this.deviceName,
    this.level,
    this.mode,
    this.deviceStatus,
    this.lastSeen,
  });

  String deviceId;
  String deviceName;
  double level;
  String mode;
  int deviceStatus;
  int lastSeen;

  factory Device.fromJson(Map<String, dynamic> json) => Device(
    deviceId: json["device_id"],
    deviceName: json["device_name"],
    level: json["level"].toDouble(),
    mode: json["mode"],
    deviceStatus: json["device_status"],
    lastSeen: json["last_seen"],
  );

  Map<String, dynamic> toJson() => {
    "device_id": deviceId,
    "device_name": deviceName,
    "level": level,
    "mode": mode,
    "device_status": deviceStatus,
    "last_seen": lastSeen,
  };
}