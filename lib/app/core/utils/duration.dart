String durationToString(Duration duration) {
  int timeInMinutes = duration.inMinutes;

  int minutes = timeInMinutes % 60;
  double hours = ((timeInMinutes - minutes) / 60) % 24;

  return '$hours:$minutes';
}

Duration durationFromString(String duration) {
  // TODO
  return const Duration(hours: 1, minutes: 45);
}
