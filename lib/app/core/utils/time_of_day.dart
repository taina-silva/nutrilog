import 'package:flutter/material.dart';

String timeOfDayAsStr(TimeOfDay time) {
  return '${time.hour}:${time.minute}';
}

TimeOfDay timeOfDayFromStr(String str) {
  return TimeOfDay(hour: int.parse(str.split(':')[0]), minute: int.parse(str.split(':')[1]));
}
