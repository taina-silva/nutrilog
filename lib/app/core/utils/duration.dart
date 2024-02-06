String durationToString(Duration duration) {
  int timeInMinutes = duration.inMinutes;

  int minutes = timeInMinutes % 60;
  double hours = ((timeInMinutes - minutes) / 60) % 24;

  return '${hours.round()}:$minutes';
}

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
