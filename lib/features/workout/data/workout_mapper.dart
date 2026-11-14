import '../../../core/database/app_database.dart';
import '../domain/workout_session.dart';

extension SetEntryRowMapper on SetEntryRow {
  SetEntry toDomain() => SetEntry(
    id: id,
    sessionExerciseId: sessionExerciseId,
    setNumber: setNumber,
    weightKg: weightKg,
    reps: reps,
    rir: rir,
    isCompleted: isCompleted,
    completedAt: completedAt,
  );
}

extension SessionExerciseRowMapper on SessionExerciseRow {
  SessionExercise toDomain(List<SetEntry> sets) => SessionExercise(
    id: id,
    sessionId: sessionId,
    exerciseId: exerciseId,
    position: position,
    targetSets: targetSets,
    targetRepsMin: targetRepsMin,
    targetRepsMax: targetRepsMax,
    restSeconds: restSeconds,
    notes: notes,
    sets: sets,
  );
}

extension WorkoutSessionRowMapper on WorkoutSessionRow {
  WorkoutSession toDomain({
    String? routineName,
    String? routineDayName,
    List<SessionExercise> exercises = const [],
  }) => WorkoutSession(
    id: id,
    routineDayId: routineDayId,
    routineName: routineName,
    routineDayName: routineDayName,
    startedAt: startedAt,
    endedAt: endedAt,
    pausedTotalSeconds: pausedTotalSeconds,
    pausedAt: pausedAt,
    status: status,
    notes: notes,
    isDemo: isDemo,
    exercises: exercises,
  );
}
