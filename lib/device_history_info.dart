// To parse this JSON data, do
//
//     final deviceHistory = deviceHistoryFromJson(jsonString);

import 'dart:convert';

DeviceHistory deviceHistoryFromJson(String str) => DeviceHistory.fromJson(json.decode(str));

String deviceHistoryToJson(DeviceHistory data) => json.encode(data.toJson());

class DeviceHistory {
  DeviceHistory({
    this.data,
    this.deviceId,
    this.deviceName,
  });

  List<Datum> data;
  String deviceId;
  String deviceName;

  factory DeviceHistory.fromJson(Map<String, dynamic> json) => DeviceHistory(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    deviceId: json["device_id"],
    deviceName: json["device_name"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "device_id": deviceId,
    "device_name": deviceName,
  };
}

class Datum {
  Datum({
    this.deviceStatus,
    this.lastSeen,
    this.level,
    this.mode,
    this.motion,
    this.stTime,
  });

  String deviceStatus;
  int lastSeen;
  String level;
  String mode;
  String motion;
  String stTime;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    deviceStatus: json["device_status"],
    lastSeen: json["last_seen"],
    level: json["level"],
    mode: json["mode"],
    motion: json["motion"],
    stTime: json["st_time"],
  );

  Map<String, dynamic> toJson() => {
    "device_status": deviceStatus,
    "last_seen": lastSeen,
    "level": level,
    "mode": mode,
    "motion": motion,
    "st_time": stTime,
  };
}
