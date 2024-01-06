import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateExtension on DateTime {
  bool isAtSameDay(DateTime other) {
    return month == other.month && year == other.year && day == other.day;
  }

  bool isAtSameMonth(DateTime other) {
    return month == other.month && year == other.year;
  }

  int numberOfMonthsTo(DateTime to) {
    return ((to.year - year) * 12) + (to.month - month);
  }

  String duration(String otherStr) {
    DateTime other = DateTime.parse(otherStr);
    Duration diff = other.difference(this);
    int minutes = diff.inMinutes;
    int hours = minutes ~/ 60;
    minutes = minutes - (hours * 60);

    return (hours > 0 ? '${hours}h ' : '0h ') + (minutes > 0 ? '${minutes}min' : '0min');
  }

  int durationInDays(DateTime other) {
    Duration diff = other.difference(this);
    return diff.inDays;
  }

  String datetimeWithOffset() {
    DateTime now = this;
    Duration offset = now.timeZoneOffset;
    String dateTime = DateFormat('yyyy-MM-ddTHH:mm:ss').format(now);

    String utcHourOffset =
        (offset.isNegative ? '-' : '+') + offset.inHours.abs().toString().padLeft(2, '0');
    String utcMinuteOffset = (offset.inMinutes - offset.inHours * 60).toString().padLeft(2, '0');
    String dateTimeWithOffset = '$dateTime$utcHourOffset:$utcMinuteOffset';

    return dateTimeWithOffset;
  }

  DateTime datetimeWithTimeReset() {
    String strDt = '$year$prettyMonthNumber$prettyDayNumber';
    DateTime date = DateTime.parse(strDt);
    return date;
  }

  String get monthNameLong => _monthslong[month]!;

  String get monthNameShort => _monthsShort[month]!;

  String get prettyDayNumber => day < 10 ? '0$day' : '$day';

  String get prettyMonthNumber => month < 10 ? '0$month' : '$month';

  // ignore: long-parameter-list
  DateTime copyWith({
    int? overrideYear,
    int? overrideMonth,
    int? overrideDay,
    int? overrideHour,
    int? overrideMinute,
    int? overrideSecond,
    int? overrideMillisecond,
    int? overrideMicrosecond,
  }) {
    return DateTime(
      overrideYear ?? year,
      overrideMonth ?? month,
      overrideDay ?? day,
      overrideHour ?? hour,
      overrideMinute ?? minute,
      overrideSecond ?? second,
      overrideMillisecond ?? millisecond,
      overrideMicrosecond ?? microsecond,
    );
  }

  DateTime addTimeOfDay(TimeOfDay timeOfDay) {
    return DateTime(
      year,
      month,
      day,
      timeOfDay.hour,
      timeOfDay.minute,
    );
  }

  static const Map<int, String> _monthslong = {
    1: 'Janeiro',
    2: 'Fevereiro',
    3: 'Março',
    4: 'Abril',
    5: 'Maio',
    6: 'Junho',
    7: 'Julho',
    8: 'Agosto',
    9: 'Setembro',
    10: 'Outubro',
    11: 'Novembro',
    12: 'Dezembro',
  };

  static const Map<int, String> _monthsShort = {
    1: 'Jan',
    2: 'Fev',
    3: 'Mar',
    4: 'Abr',
    5: 'Mai',
    6: 'Jun',
    7: 'Jul',
    8: 'Ago',
    9: 'Set',
    10: 'Out',
    11: 'Nov',
    12: 'Dez',
  };
}
