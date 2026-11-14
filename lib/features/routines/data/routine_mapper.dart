import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../domain/routine.dart';
import '../domain/routine_drafts.dart';

extension RoutineExerciseRowMapper on RoutineExerciseRow {
  RoutineExercise toDomain() => RoutineExercise(
    id: id,
    routineDayId: routineDayId,
    exerciseId: exerciseId,
    position: position,
    targetSets: targetSets,
    targetRepsMin: targetRepsMin,
    targetRepsMax: targetRepsMax,
    initialWeightKg: initialWeightKg,
    restSeconds: restSeconds,
    notes: notes,
  );
}

extension RoutineDayRowMapper on RoutineDayRow {
  RoutineDay toDomain(List<RoutineExercise> exercises) => RoutineDay(
    id: id,
    routineId: routineId,
    name: name,
    position: position,
    weekday: weekday,
    exercises: exercises,
  );
}

extension RoutineRowMapper on RoutineRow {
  Routine toDomain(List<RoutineDay> days) => Routine(
    id: id,
    name: name,
    notes: notes,
    templateType: templateType,
    days: days,
  );
}

extension RoutineDraftMapper on RoutineDraft {
  RoutinesCompanion toCompanion() =>
      RoutinesCompanion(name: Value(name.trim()), notes: Value(notes.trim()));
}

extension RoutineDayDraftMapper on RoutineDayDraft {
  RoutineDaysCompanion toCompanion() =>
      RoutineDaysCompanion(name: Value(name.trim()), weekday: Value(weekday));
}

extension RoutineExerciseDraftMapper on RoutineExerciseDraft {
  /// Target columns of a validated draft. Required fields must be set.
  RoutineExercisesCompanion toCompanion() => RoutineExercisesCompanion(
    targetSets: Value(targetSets!),
    targetRepsMin: Value(targetRepsMin!),
    targetRepsMax: Value(targetRepsMax!),
    initialWeightKg: Value(initialWeightKg),
    restSeconds: Value(restSeconds!),
    notes: Value(notes.trim()),
  );
}
