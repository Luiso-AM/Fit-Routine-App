import '../../workout/domain/session_summary.dart';
import '../../workout/domain/workout_session.dart';

/// Midnight of the Monday that starts the local week containing [moment],
/// as a local time.
DateTime weekStart(DateTime moment) {
  final local = moment.toLocal();
  return DateTime(local.year, local.month, local.day - (local.weekday - 1));
}

/// Midnight of the Monday after [weekStart], as a local time. Built from
/// the calendar rather than by adding 7 days, so a daylight saving change
/// within the week does not shift it.
DateTime nextWeekStart(DateTime weekStart) =>
    DateTime(weekStart.year, weekStart.month, weekStart.day + 7);

/// Time spent training in [sessions], pauses excluded.
Duration trainedTime(Iterable<WorkoutSession> sessions) => sessions.fold(
  Duration.zero,
  (total, session) => total + SessionTotals.of(session).duration,
);

/// Weeks in a row, ending this week, in which at least [goal] sessions
/// were finished. [starts] are when each finished session started.
///
/// The week of [now] is still under way: it counts once it reaches the
/// goal, but until then it does not break the streak.
int weeklyStreak(
  Iterable<DateTime> starts, {
  required int goal,
  required DateTime now,
}) {
  if (goal <= 0) return 0;
  final perWeek = <DateTime, int>{};
  for (final start in starts) {
    final week = weekStart(start);
    perWeek[week] = (perWeek[week] ?? 0) + 1;
  }
  bool reached(DateTime week) => (perWeek[week] ?? 0) >= goal;

  final current = weekStart(now);
  var streak = reached(current) ? 1 : 0;
  var week = _previousWeekStart(current);
  while (reached(week)) {
    streak++;
    week = _previousWeekStart(week);
  }
  return streak;
}

DateTime _previousWeekStart(DateTime weekStart) =>
    DateTime(weekStart.year, weekStart.month, weekStart.day - 7);
