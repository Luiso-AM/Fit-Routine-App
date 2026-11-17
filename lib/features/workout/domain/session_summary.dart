import 'package:freezed_annotation/freezed_annotation.dart';

import 'exercise_performance.dart';
import 'workout_session.dart';

part 'session_summary.freezed.dart';

/// Volume of [sets] in kg: Σ weight × reps of the completed ones.
double completedVolumeKg(Iterable<SetEntry> sets) => sets
    .where((s) => s.isCompleted)
    .fold(0, (volume, s) => volume + s.weightKg * s.reps);

/// What a session added up to. Only completed sets count.
@freezed
abstract class SessionTotals with _$SessionTotals {
  const factory SessionTotals({
    required Duration duration,

    /// Session exercises with at least one completed set.
    required int exercises,
    required int sets,
    required int reps,

    /// Always in kg.
    required double volumeKg,
  }) = _SessionTotals;

  /// Totals of [session]. Its duration excludes the time spent paused and
  /// ends when the session ended (or was paused, if it is still running).
  factory SessionTotals.of(WorkoutSession session) {
    final completed = [
      for (final e in session.exercises) e.sets.where((s) => s.isCompleted),
    ];
    return SessionTotals(
      duration: session.activeDuration(session.endedAt ?? session.startedAt),
      exercises: completed.where((sets) => sets.isNotEmpty).length,
      sets: completed.fold(0, (n, sets) => n + sets.length),
      reps: completed.fold(
        0,
        (n, sets) => sets.fold(n, (reps, s) => reps + s.reps),
      ),
      volumeKg: completedVolumeKg(completed.expand((sets) => sets)),
    );
  }
}

/// Change of each total against an earlier session: current − previous.
@freezed
abstract class SessionComparison with _$SessionComparison {
  const factory SessionComparison({
    required String previousSessionId,
    required DateTime previousStartedAt,
    required Duration durationDelta,
    required int exercisesDelta,
    required int setsDelta,
    required int repsDelta,

    /// Always in kg.
    required double volumeDeltaKg,
  }) = _SessionComparison;

  factory SessionComparison.between(
    SessionTotals current,
    WorkoutSession previous,
  ) {
    final before = SessionTotals.of(previous);
    return SessionComparison(
      previousSessionId: previous.id,
      previousStartedAt: previous.startedAt,
      durationDelta: current.duration - before.duration,
      exercisesDelta: current.exercises - before.exercises,
      setsDelta: current.sets - before.sets,
      repsDelta: current.reps - before.reps,
      volumeDeltaKg: current.volumeKg - before.volumeKg,
    );
  }
}

/// What a finished session achieved, to show right after it ends.
@freezed
abstract class SessionSummary with _$SessionSummary {
  const factory SessionSummary({
    required WorkoutSession session,
    required SessionTotals totals,

    /// The completed sets of each session exercise, in session order.
    /// Exercises without completed sets are left out.
    required List<ExercisePerformance> exercises,

    /// Against the previous session of the same routine day, if any.
    SessionComparison? comparison,
  }) = _SessionSummary;

  /// Summarizes [session], compared with [previous] when given.
  factory SessionSummary.of(
    WorkoutSession session, {
    WorkoutSession? previous,
  }) {
    final totals = SessionTotals.of(session);
    return SessionSummary(
      session: session,
      totals: totals,
      exercises: [
        for (final e in session.exercises)
          if (e.completedSets > 0)
            ExercisePerformance(
              sessionId: session.id,
              exerciseId: e.exerciseId,
              performedAt: session.startedAt,
              sets: [...e.sets.where((s) => s.isCompleted)],
            ),
      ],
      comparison: previous == null
          ? null
          : SessionComparison.between(totals, previous),
    );
  }
}
