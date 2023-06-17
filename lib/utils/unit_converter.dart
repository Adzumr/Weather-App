import 'package:intl/intl.dart';

class UnitConverter {
  static double kelvinToCelsius({double? kelvin}) {
    return kelvin! - 273.15;
  }

  static String formatTime(int timestamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    String formattedTime = DateFormat.jm().format(dateTime);
    return formattedTime;
  }
}
