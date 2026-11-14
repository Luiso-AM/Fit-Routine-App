import 'package:freezed_annotation/freezed_annotation.dart';

import '../../exercises/domain/enums/exercise_type.dart';
import 'routine.dart';

part 'routine_drafts.freezed.dart';

const int kRoutineNameMaxLength = 60;
const int kRoutineNotesMaxLength = 500;
const int kRoutineDayNameMaxLength = 30;
const int kMinTargetSets = 1;
const int kMaxTargetSets = 20;
const int kMinTargetReps = 1;
const int kMaxTargetReps = 100;
const int kMaxInitialWeightKg = 1000;
const int kMaxRestSeconds = 600;

enum RoutineValidationError { nameRequired, nameTooLong, notesTooLong }

/// Name and notes of a routine.
@freezed
abstract class RoutineDraft with _$RoutineDraft {
  const factory RoutineDraft({
    @Default('') String name,
    @Default('') String notes,
  }) = _RoutineDraft;

  const RoutineDraft._();

  factory RoutineDraft.fromRoutine(Routine routine) =>
      RoutineDraft(name: routine.name, notes: routine.notes);

  Set<RoutineValidationError> validate() {
    final trimmed = name.trim();
    return {
      if (trimmed.isEmpty) RoutineValidationError.nameRequired,
      if (trimmed.length > kRoutineNameMaxLength)
        RoutineValidationError.nameTooLong,
      if (notes.trim().length > kRoutineNotesMaxLength)
        RoutineValidationError.notesTooLong,
    };
  }
}

enum RoutineDayValidationError { nameRequired, nameTooLong, weekdayOutOfRange }

@freezed
abstract class RoutineDayDraft with _$RoutineDayDraft {
  const factory RoutineDayDraft({
    @Default('') String name,

    /// ISO weekday (1 = Monday), or `null` when not scheduled.
    int? weekday,
  }) = _RoutineDayDraft;

  const RoutineDayDraft._();

  factory RoutineDayDraft.fromDay(RoutineDay day) =>
      RoutineDayDraft(name: day.name, weekday: day.weekday);

  Set<RoutineDayValidationError> validate() {
    final trimmed = name.trim();
    final day = weekday;
    return {
      if (trimmed.isEmpty) RoutineDayValidationError.nameRequired,
      if (trimmed.length > kRoutineDayNameMaxLength)
        RoutineDayValidationError.nameTooLong,
      if (day != null && (day < DateTime.monday || day > DateTime.sunday))
        RoutineDayValidationError.weekdayOutOfRange,
    };
  }
}

enum RoutineExerciseValidationError {
  setsRequired,
  setsOutOfRange,
  repsMinRequired,
  repsMaxRequired,
  repsOutOfRange,
  repsRangeInverted,
  weightOutOfRange,
  restRequired,
  restOutOfRange,
  notesTooLong,
}

/// Targets of an exercise in a routine day, as entered in the form.
@freezed
abstract class RoutineExerciseDraft with _$RoutineExerciseDraft {
  const factory RoutineExerciseDraft({
    int? targetSets,
    int? targetRepsMin,
    int? targetRepsMax,

    /// Always in kg; the form converts from the exercise's unit.
    double? initialWeightKg,
    int? restSeconds,
    @Default('') String notes,
  }) = _RoutineExerciseDraft;

  const RoutineExerciseDraft._();

  /// Targets used when an exercise is added to a day or a template.
  factory RoutineExerciseDraft.defaultsFor(ExerciseType type) =>
      RoutineExerciseDraft(
        targetSets: 3,
        targetRepsMin: 10,
        targetRepsMax: 12,
        restSeconds: switch (type) {
          ExerciseType.compound => 120,
          ExerciseType.isolation => 90,
        },
      );

  factory RoutineExerciseDraft.fromExercise(RoutineExercise e) =>
      RoutineExerciseDraft(
        targetSets: e.targetSets,
        targetRepsMin: e.targetRepsMin,
        targetRepsMax: e.targetRepsMax,
        initialWeightKg: e.initialWeightKg,
        restSeconds: e.restSeconds,
        notes: e.notes,
      );

  Set<RoutineExerciseValidationError> validate() {
    final errors = <RoutineExerciseValidationError>{};

    final sets = targetSets;
    if (sets == null) {
      errors.add(RoutineExerciseValidationError.setsRequired);
    } else if (sets < kMinTargetSets || sets > kMaxTargetSets) {
      errors.add(RoutineExerciseValidationError.setsOutOfRange);
    }

    final min = targetRepsMin;
    final max = targetRepsMax;
    if (min == null) errors.add(RoutineExerciseValidationError.repsMinRequired);
    if (max == null) errors.add(RoutineExerciseValidationError.repsMaxRequired);
    bool outOfRange(int reps) => reps < kMinTargetReps || reps > kMaxTargetReps;
    if ((min != null && outOfRange(min)) || (max != null && outOfRange(max))) {
      errors.add(RoutineExerciseValidationError.repsOutOfRange);
    } else if (min != null && max != null && min > max) {
      errors.add(RoutineExerciseValidationError.repsRangeInverted);
    }

    final weight = initialWeightKg;
    if (weight != null && (weight < 0 || weight > kMaxInitialWeightKg)) {
      errors.add(RoutineExerciseValidationError.weightOutOfRange);
    }

    final rest = restSeconds;
    if (rest == null) {
      errors.add(RoutineExerciseValidationError.restRequired);
    } else if (rest < 0 || rest > kMaxRestSeconds) {
      errors.add(RoutineExerciseValidationError.restOutOfRange);
    }

    if (notes.trim().length > kRoutineNotesMaxLength) {
      errors.add(RoutineExerciseValidationError.notesTooLong);
    }
    return errors;
  }
}
