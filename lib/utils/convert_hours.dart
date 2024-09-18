String convertToHours(int minutes) {
  int hours = minutes ~/ 60;
  int remainingMinutes = minutes % 60;
  return '${hours}h ${remainingMinutes}m';
}