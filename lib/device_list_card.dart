import 'package:flutter/material.dart';
import 'package:smrs/device_info.dart';
import 'package:smrs/constants.dart';
import 'package:smrs/device_card.dart';

class DeviceListCard extends StatelessWidget {
  const DeviceListCard({
    Key key,
    @required this.device,
  }) : super(key: key);

  final Device device;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DeviceCard(device).getDevice()),
        );
      },
      child: Container(
        height: 100,
        margin: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Card(
              color: Colors.transparent,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              // elevation: 5,
              child: AspectRatio(
                aspectRatio: 1,
                child: Image.asset(
                  "assets/mosquito_repellent.png",
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(
              width: 16,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    device.deviceId,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    device.deviceName == null ? "" : device.deviceName,
                    style: TextStyle(color: Colors.white),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "${(device.level * 100).ceil()} %",
                    style: TextStyle(color: Colors.white),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "${App.dateTimeToString(device.lastSeen)}",
                    style: TextStyle(color: Colors.white),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
