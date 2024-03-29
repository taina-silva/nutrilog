Duration durationFromString(String duration) {
  int hours = 0;
  int minutes = 0;
  int micros;

  List<String> parts = duration.split(':');

  if (parts.length > 2) hours = int.parse(parts[parts.length - 3]);
  if (parts.length > 1) minutes = int.parse(parts[parts.length - 2]);
  micros = (double.parse(parts[parts.length - 1]) * 1000000).round();

  return Duration(hours: hours, minutes: minutes, microseconds: micros);
}

String durationToString(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");

  String twoDigitHours = twoDigits(duration.inHours);
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60).abs());
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60).abs());

  String str = '';

  if (twoDigitHours != '00') str += '${twoDigitHours}h';
  if (twoDigitMinutes != '00') str += '${twoDigitMinutes}min';
  if (twoDigitSeconds != '00') str += '${twoDigitMinutes}s';

  return str;
}

String totalHoursFromDurationsAsStr(List<Duration> durations) {
  int seconds = 0;

  for (Duration duration in durations) {
    seconds += duration.inSeconds;
  }

  double hours = seconds / 3600;
  bool isInteger = (hours % 1) == 0;

  return '${hours.toStringAsFixed(isInteger ? 0 : 2)} h';
}
