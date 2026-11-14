import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums/session_status.dart';

part 'workout_session.freezed.dart';

/// A workout, from its start until it is finished or discarded.
@freezed
abstract class WorkoutSession with _$WorkoutSession {
  const factory WorkoutSession({
    required String id,

    /// `null` for free sessions, or when the routine day was removed.
    String? routineDayId,

    /// Names of the routine and day the session started from, if they
    /// still exist.
    String? routineName,
    String? routineDayName,
    required DateTime startedAt,
    DateTime? endedAt,
    @Default(0) int pausedTotalSeconds,

    /// Set while the session is paused.
    DateTime? pausedAt,
    @Default(SessionStatus.inProgress) SessionStatus status,
    @Default('') String notes,
    @Default(false) bool isDemo,
    @Default(<SessionExercise>[]) List<SessionExercise> exercises,
  }) = _WorkoutSession;

  const WorkoutSession._();

  bool get isPaused => pausedAt != null;

  bool get isInProgress => status == SessionStatus.inProgress;

  bool get isFree => routineDayId == null;

  int get totalSets => exercises.fold(0, (n, e) => n + e.sets.length);

  int get completedSets => exercises.fold(0, (n, e) => n + e.completedSets);

  /// Completed sets over all sets, from 0 to 1. 0 when there are no sets.
  double get progress => totalSets == 0 ? 0 : completedSets / totalSets;

  /// Time spent training: from the start until the end (or [now]), minus
  /// the time spent paused. A running pause counts up to [now].
  Duration activeDuration(DateTime now) {
    final end = endedAt ?? pausedAt ?? now;
    final elapsed = end.difference(startedAt).inSeconds - pausedTotalSeconds;
    return Duration(seconds: elapsed < 0 ? 0 : elapsed);
  }

  /// Total paused seconds once a running pause, if any, ends at [now].
  int pausedSecondsUntil(DateTime now) {
    final since = pausedAt;
    if (since == null) return pausedTotalSeconds;
    final running = now.difference(since).inSeconds;
    return pausedTotalSeconds + (running < 0 ? 0 : running);
  }

  SessionExercise? exerciseById(String id) =>
      exercises.where((e) => e.id == id).firstOrNull;
}

/// An exercise performed in a session, with the targets copied from the
/// routine when the session started.
@freezed
abstract class SessionExercise with _$SessionExercise {
  const factory SessionExercise({
    required String id,
    required String sessionId,
    required String exerciseId,
    required int position,

    /// Targets, `null` for exercises without a routine plan.
    int? targetSets,
    int? targetRepsMin,
    int? targetRepsMax,
    int? restSeconds,
    @Default('') String notes,

    /// Ordered by set number.
    @Default(<SetEntry>[]) List<SetEntry> sets,
  }) = _SessionExercise;

  const SessionExercise._();

  int get completedSets => sets.where((s) => s.isCompleted).length;

  bool get hasRepTarget => targetRepsMin != null && targetRepsMax != null;
}

@freezed
abstract class SetEntry with _$SetEntry {
  const factory SetEntry({
    required String id,
    required String sessionExerciseId,

    /// 1-based, contiguous within the exercise.
    required int setNumber,

    /// Always in kg, never rounded.
    @Default(0) double weightKg,
    @Default(0) int reps,

    /// Reps in reserve, optional.
    int? rir,
    @Default(false) bool isCompleted,
    DateTime? completedAt,
  }) = _SetEntry;
}
