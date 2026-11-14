import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums/routine_template_type.dart';

part 'routine.freezed.dart';

/// A training routine: its days, in order, and each day's exercises.
@freezed
abstract class Routine with _$Routine {
  const factory Routine({
    required String id,
    required String name,
    @Default('') String notes,

    /// `null` for a custom routine.
    RoutineTemplateType? templateType,
    @Default(<RoutineDay>[]) List<RoutineDay> days,
  }) = _Routine;

  const Routine._();

  int get exerciseCount =>
      days.fold(0, (count, day) => count + day.exercises.length);

  RoutineDay? dayById(String id) =>
      days.where((day) => day.id == id).firstOrNull;
}

@freezed
abstract class RoutineDay with _$RoutineDay {
  const factory RoutineDay({
    required String id,
    required String routineId,
    required String name,
    required int position,

    /// ISO weekday, 1 = Monday ... 7 = Sunday. `null` when not scheduled.
    int? weekday,
    @Default(<RoutineExercise>[]) List<RoutineExercise> exercises,
  }) = _RoutineDay;
}

/// An exercise planned in a routine day, with its targets.
@freezed
abstract class RoutineExercise with _$RoutineExercise {
  const factory RoutineExercise({
    required String id,
    required String routineDayId,
    required String exerciseId,
    required int position,
    required int targetSets,
    required int targetRepsMin,
    required int targetRepsMax,

    /// Always in kg. `null` when not set.
    double? initialWeightKg,
    required int restSeconds,
    @Default('') String notes,
  }) = _RoutineExercise;
}
