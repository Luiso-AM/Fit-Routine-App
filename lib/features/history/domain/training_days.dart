import '../../../core/utils/calendar_date.dart';
import '../../workout/domain/workout_session.dart';

/// The local month that contains [moment], as the instant it starts
/// ([from], inclusive) and the instant the next month starts ([to],
/// exclusive), both in UTC.
({DateTime from, DateTime to}) monthRange(DateTime moment) {
  final local = moment.toLocal();
  return (
    from: DateTime(local.year, local.month).toUtc(),
    to: DateTime(local.year, local.month + 1).toUtc(),
  );
}

/// [sessions] grouped by the local calendar day they started on (see
/// [calendarDate]), keeping their order within each day.
Map<DateTime, List<WorkoutSession>> sessionsByDay(
  Iterable<WorkoutSession> sessions,
) {
  final byDay = <DateTime, List<WorkoutSession>>{};
  for (final session in sessions) {
    byDay
        .putIfAbsent(calendarDate(session.startedAt.toLocal()), () => [])
        .add(session);
  }
  return byDay;
}
