import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/utils/calendar_date.dart';
import '../../routines/domain/routine.dart';
import '../../workout/domain/session_start.dart';

part 'next_workout.freezed.dart';

/// The routine day to train next.
@freezed
abstract class NextWorkout with _$NextWorkout {
  const factory NextWorkout({
    required Routine routine,
    required RoutineDay day,

    /// Calendar date the day is scheduled for, or `null` when it was
    /// picked by following the routine's order.
    DateTime? date,
  }) = _NextWorkout;
}

/// The next routine day to train, or `null` if no routine has a day with
/// exercises.
///
/// Days scheduled on a weekday come first: the first one from today on,
/// or from tomorrow if a session was already finished today. Without any
/// scheduled day, it is the day after the last one trained in its
/// routine, or else the first day of the first routine.
///
/// [routines] and their days are in display order; [finished] are the
/// finished sessions, newest first.
NextWorkout? nextWorkout({
  required List<Routine> routines,
  required List<SessionStart> finished,
  required DateTime now,
}) {
  final trainable = [
    for (final routine in routines)
      for (final day in routine.days)
        if (day.exercises.isNotEmpty) (routine: routine, day: day),
  ];
  if (trainable.isEmpty) return null;

  final today = calendarDate(now.toLocal());
  final scheduled = trainable.where((t) => t.day.weekday != null).toList();
  if (scheduled.isNotEmpty) {
    final trainedToday = finished.any(
      (s) => calendarDate(s.startedAt.toLocal()) == today,
    );
    for (var offset = trainedToday ? 1 : 0; offset <= 7; offset++) {
      final date = DateTime.utc(today.year, today.month, today.day + offset);
      final match = scheduled.where((t) => t.day.weekday == date.weekday);
      if (match.isNotEmpty) {
        final (:routine, :day) = match.first;
        return NextWorkout(routine: routine, day: day, date: date);
      }
    }
  }

  return _afterLastTrained(trainable, finished) ??
      NextWorkout(routine: trainable.first.routine, day: trainable.first.day);
}

/// The trainable day that follows, in its routine, the last day trained.
NextWorkout? _afterLastTrained(
  List<({Routine routine, RoutineDay day})> trainable,
  List<SessionStart> finished,
) {
  for (final session in finished) {
    final dayId = session.routineDayId;
    if (dayId == null) continue;
    for (final routine in trainable.map((t) => t.routine).toSet()) {
      final index = routine.days.indexWhere((d) => d.id == dayId);
      if (index < 0) continue;
      final days = routine.days;
      for (var step = 1; step <= days.length; step++) {
        final day = days[(index + step) % days.length];
        if (day.exercises.isNotEmpty) {
          return NextWorkout(routine: routine, day: day);
        }
      }
    }
  }
  return null;
}
