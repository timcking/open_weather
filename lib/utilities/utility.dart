import 'package:intl/intl.dart';

int calcHour(epochDate) {
  DateTime localDate = new DateTime.fromMillisecondsSinceEpoch(epochDate * 1000);
  var format = new DateFormat('H');
  var hour = format.format(localDate);

  return int.parse(hour);
}
