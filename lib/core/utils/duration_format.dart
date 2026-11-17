/// Formats a duration as a clock: `m:ss` under an hour, `h:mm:ss` from
/// one hour on. Negative durations show as `0:00`.
String formatClock(Duration duration) {
  final total = duration.isNegative ? 0 : duration.inSeconds;
  final hours = total ~/ 3600;
  final minutes = (total % 3600) ~/ 60;
  final seconds = (total % 60).toString().padLeft(2, '0');
  if (hours == 0) return '$minutes:$seconds';
  return '$hours:${minutes.toString().padLeft(2, '0')}:$seconds';
}

/// Formats a total time in whole minutes: `45 min`, `2 h`, `2 h 15 min`.
/// Seconds are dropped; negative durations show as `0 min`.
String formatHoursMinutes(Duration duration) {
  final minutes = duration.isNegative ? 0 : duration.inMinutes;
  final hours = minutes ~/ 60;
  final rest = minutes % 60;
  if (hours == 0) return '$rest min';
  return rest == 0 ? '$hours h' : '$hours h $rest min';
}
