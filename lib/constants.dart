import 'dart:ui';
import 'package:intl/intl.dart';
class App{
  static int baseColor = 0xFF183447;
  static int bgColor = 0xFF183447;
  static int bgCardColor = 0xFF152C3C;
  static int btnColor = 0xFF009688;
  static String appName = 'SMRS';

  static String apiUriBase = "https://py-test-mosquito.herokuapp.com"; // "https://bdcc4a743681.ngrok.io/"
  static int apiRefreshRate = 5;
  static Map<int, Color> colorSwatch = {
    50: Color.fromRGBO(24, 52, 71, .1),
    100: Color.fromRGBO(24, 52, 71, .2),
    200: Color.fromRGBO(24, 52, 71, .3),
    300: Color.fromRGBO(24, 52, 71, .4),
    400: Color.fromRGBO(24, 52, 71, .5),
    500: Color.fromRGBO(24, 52, 71, .6),
    600: Color.fromRGBO(24, 52, 71, .7),
    700: Color.fromRGBO(24, 52, 71, .8),
    800: Color.fromRGBO(24, 52, 71, .9),
    900: Color.fromRGBO(24, 52, 71, 1),
  };
  static String DEVICE_ON = "1";
  static String DEVICE_OFF = "0";
  static String DEVICE_MODE_ACTIVE = "1";
  static String DEVICE_MODE_NORMAL = "0";
  static String DEVICE_TEXT_ACTIVE = "ACTIVE MODE";
  static String DEVICE_TEXT_NORMAL = "NORMAL MODE";
  static int SNACKBAR_DELAY = 4;
  static int SNACKBAR_DELAY_ADD_DEVICE = 3;
  static String dateTimeToString(int value){
    // print(value);
    DateFormat dateFormat = DateFormat('dd-MMM-y HH:mm:ss');
    DateTime now = DateTime.now();
    // print(now.microsecondsSinceEpoch);
    DateTime dateTime = DateTime.fromMicrosecondsSinceEpoch(( value *1000000 )); //microseconds to seconds
    return dateFormat.format(dateTime);

  }
}
