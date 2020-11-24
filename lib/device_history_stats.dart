import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smrs/api_manager.dart';
import 'package:smrs/constants.dart';
import 'package:smrs/device_history_info.dart';
import 'package:bezier_chart/bezier_chart.dart';

class DeviceHistoryCard extends StatefulWidget {
  String deviceId;

  DeviceHistoryCard(String _deviceId) {
    deviceId = _deviceId;
  }

  @override
  _DeviceHistoryCardState createState() => _DeviceHistoryCardState();
}

class _DeviceHistoryCardState extends State<DeviceHistoryCard> {
  Future<DeviceHistory> deviceHistory;

  // Timer timer;

  @override
  void initState() {
    deviceHistory = APIManager().getDeviceHistory(widget.deviceId);

    print('Device update..');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final fromDate = DateTime(2020, 11, 20);
    final toDate = DateTime.now();

    final date1 = DateTime.now().subtract(Duration(days: 2));
    final date2 = DateTime.now().subtract(Duration(days: 3));
    final date3 = DateTime.now().subtract(Duration(days: 4));
    return Scaffold(backgroundColor: Color(App.bgCardColor),
        appBar: AppBar(
          title: Text("History"),
          actions: [],
        ),
        body: FutureBuilder<DeviceHistory>(
          future: deviceHistory,
          builder: (buildContext, snapshot) {
            if (snapshot.hasData) {
              // TODO Convert into DataPoint<DateTime>(value: 10, xAxis: date1),

              List<DataPoint<DateTime>> dataPoints =
              List<DataPoint<DateTime>>();

              List<DeviceHistoryData> hourlyDataPoints = List<DeviceHistoryData>();
              int _counter = 0;
              int _startTime;
              DateTime _curTime;
              int _endTime;
              List<DeviceHistoryData> tmpPoints = List<DeviceHistoryData>();
              // for (int i = 0; i < snapshot.data.data.length; i++) {
              //   _curTime = DateTime.fromMicrosecondsSinceEpoch(snapshot.data.data[i].lastSeen *1000000);
              //   _startTime = DateTime.fromMicrosecondsSinceEpoch(snapshot.data.data[i].lastSeen *1000000).hour;
              //   _endTime = _startTime+1;
              //
              //   if(_endTime == 24){
              //     _endTime == 0;
              //     i++;
              //   }
              //   double avgLevel = 0;
              //   double levelSum = double.parse(snapshot.data.data[i].level) *100 ;
              //   int _count = 1;
              //   for(;i< snapshot.data.data.length;i++){
              //
              //     int _localHour = DateTime.fromMicrosecondsSinceEpoch(snapshot.data.data[i].lastSeen *1000000).hour;
              //     print('${snapshot.data.data[i].level} $_startTime == $_endTime' );
              //
              //     if(_localHour < _endTime && _localHour == _startTime){
              //
              //       levelSum += (double.parse(snapshot.data.data[i].level) *100);
              //       print(levelSum);
              //       _count++;
              //     }else{
              //       print("I am in else");
              //       i--;
              //       break;
              //     }
              //   }
              //   avgLevel = levelSum / _count;
              //   print(avgLevel);
              //   // hourlyDataPoints.add(DeviceHistoryData(level: avgLevel, lastSeen: _curTime));
              //   dataPoints.add(DataPoint<DateTime>(value: avgLevel, xAxis: _curTime));
              // }
              dataPoints.add(DataPoint<DateTime>(value: 100, xAxis: DateTime.now().subtract(Duration(hours: 14))));
              dataPoints.add(DataPoint<DateTime>(value: 98, xAxis: DateTime.now().subtract(Duration(hours: 13))));
              dataPoints.add(DataPoint<DateTime>(value: 94, xAxis: DateTime.now().subtract(Duration(hours: 12))));
              dataPoints.add(DataPoint<DateTime>(value: 92, xAxis: DateTime.now().subtract(Duration(hours: 11))));
              dataPoints.add(DataPoint<DateTime>(value: 89, xAxis: DateTime.now().subtract(Duration(hours: 10))));
              dataPoints.add(DataPoint<DateTime>(value: 85, xAxis: DateTime.now().subtract(Duration(hours: 9))));
              dataPoints.add(DataPoint<DateTime>(value: 83, xAxis: DateTime.now().subtract(Duration(hours: 8))));
              dataPoints.add(DataPoint<DateTime>(value: 81, xAxis: DateTime.now().subtract(Duration(hours: 7))));
              dataPoints.add(DataPoint<DateTime>(value: 78, xAxis: DateTime.now().subtract(Duration(hours: 6))));
              dataPoints.add(DataPoint<DateTime>(value: 74, xAxis: DateTime.now().subtract(Duration(hours: 5))));
              dataPoints.add(DataPoint<DateTime>(value: 70, xAxis: DateTime.now().subtract(Duration(hours: 4))));
              dataPoints.add(DataPoint<DateTime>(value: 68, xAxis: DateTime.now().subtract(Duration(hours: 3))));
              dataPoints.add(DataPoint<DateTime>(value: 65, xAxis: DateTime.now().subtract(Duration(hours: 2))));
              dataPoints.add(DataPoint<DateTime>(value: 63, xAxis: DateTime.now().subtract(Duration(hours: 1))));
              dataPoints.add(DataPoint<DateTime>(value: 61, xAxis: DateTime.now()));

              // for (int i = 0; i < snapshot.data.data.length; i++) {
              //   // TODO SHOW DATE ON BOTTOM
              //   // print(double.parse(snapshot.data.data[i].level) * 100);
              //   dataPoints.add(DataPoint<DateTime>(
              //       value: double.parse(snapshot.data.data[i].level) * 100,
              //       xAxis: DateTime.fromMicrosecondsSinceEpoch(
              //           snapshot.data.data[i].lastSeen * 1000000)));
              // }

              DateFormat dayFormat = DateFormat("dd-MMM");
              DateFormat timeFormat = DateFormat("jm");
              return Container(
                color: Colors.yellow,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: BezierChart(
                  fromDate: fromDate,
                  bezierChartScale: BezierChartScale.HOURLY,
                  toDate: toDate,
                  selectedDate: toDate,

                  footerDateTimeBuilder: (dateTime, chartScale){
                    return ('${timeFormat.format(dateTime)}\n${dayFormat.format(dateTime)}');
                  } ,
                  series: [
                    BezierLine(
                      label: "Date",
                      // onMissingValue: (dateTime) {
                      //   if (dateTime.day.isEven) {
                      //     10.0;
                      //   }
                      //   return 5.0;
                      // },
                      data: dataPoints,
                    ),
                  ],
                  config: BezierChartConfig(
                    verticalIndicatorStrokeWidth: 3.0,
                    verticalIndicatorColor: Colors.black26,
                    showVerticalIndicator: true,
                    verticalIndicatorFixedPosition: false,
                    backgroundColor: Color(App.bgCardColor),
                    footerHeight: 30.0,
                    pinchZoom: true,
                    showDataPoints: true,
                    bubbleIndicatorValueFormat: NumberFormat.compact(),
                    displayYAxis: true,
                    snap: false,
                    startYAxisFromNonZeroValue: true,
                    stepsYAxis: 5,

                    // stepsYAxis: 10,
                    // displayDataPointWhenNoValue: false,
                    // displayYAxis: true,
                    // displayYAxis: true,
                    // displayLinesXAxis: true,
                  ),
                ),
              );
            } else {
              return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  ));
            }
          },
        ));
  }
}


DeviceHistoryData deviceHistoryDataFromJson(String str) =>
    DeviceHistoryData.fromJson(json.decode(str));

String deviceHistoryDataToJson(DeviceHistoryData data) =>
    json.encode(data.toJson());

class DeviceHistoryData {
  DeviceHistoryData({
    this.level,
    this.lastSeen,
  });

  double level;
  DateTime lastSeen;

  factory DeviceHistoryData.fromJson(Map<String, dynamic> json) =>
      DeviceHistoryData(
        level: json["level"].toDouble(),
        lastSeen: json["last_seen"],
      );

  Map<String, dynamic> toJson() =>
      {
        "level": level,
        "last_seen": lastSeen,
      };
}