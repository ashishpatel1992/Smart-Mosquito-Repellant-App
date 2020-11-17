class SMRDevice{
  String device_id;
  String device_name;
  double level;
  int mode; // 1 active, 2 turbo mode
  int device_status; // 0 off, 1 On, -1 unreachable
  DateTime last_seen;
  SMRDevice({this.device_id,this.device_name,this.level,this.mode,this.device_status,this.last_seen});


  String getDeviceName(){
    return device_name;
  }
  double getLevel(){
    return level;
  }
  int getMode(){
    return mode;
  }
  int getDeviceStatus(){
    return device_status;
  }
  DateTime lastSeen(){
    return last_seen;
  }
}