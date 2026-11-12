import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/units/weight_unit.dart';
import '../../../core/utils/text_normalize.dart';
import 'enums/difficulty.dart';
import 'enums/equipment.dart';
import 'enums/exercise_type.dart';
import 'enums/muscle_group.dart';
import 'exercise.dart';

part 'exercise_draft.freezed.dart';

/// Maximum length of an exercise name.
const int kExerciseNameMaxLength = 60;

enum ExerciseValidationError {
  nameRequired,
  nameTooLong,
  nameDuplicate,
  primaryMuscleRequired,
  secondaryIncludesPrimary,
  typeRequired,
  equipmentRequired,
  difficultyRequired,
}

/// Editable data of a custom exercise, as entered in the form.
@freezed
abstract class ExerciseDraft with _$ExerciseDraft {
  const factory ExerciseDraft({
    @Default('') String name,
    MuscleGroup? primaryMuscle,
    @Default(<MuscleGroup>[]) List<MuscleGroup> secondaryMuscles,
    ExerciseType? type,
    Equipment? equipment,
    Difficulty? difficulty,
    @Default('') String instructions,
    @Default('') String commonMistakes,
    @Default(WeightUnit.kg) WeightUnit preferredUnit,
  }) = _ExerciseDraft;

  const ExerciseDraft._();

  factory ExerciseDraft.fromExercise(Exercise exercise) => ExerciseDraft(
    name: exercise.name,
    primaryMuscle: exercise.primaryMuscle,
    secondaryMuscles: exercise.secondaryMuscles,
    type: exercise.type,
    equipment: exercise.equipment,
    difficulty: exercise.difficulty,
    instructions: exercise.instructions,
    commonMistakes: exercise.commonMistakes,
    preferredUnit: exercise.preferredUnit,
  );

  /// Checks the draft against the business rules.
  ///
  /// [existing] are the active exercises, used to reject duplicate names
  /// (ignoring case and accents). Pass [editingId] when editing so the
  /// exercise does not collide with itself.
  Set<ExerciseValidationError> validate({
    required Iterable<Exercise> existing,
    String? editingId,
  }) {
    final errors = <ExerciseValidationError>{};
    final trimmed = name.trim();

    if (trimmed.isEmpty) {
      errors.add(ExerciseValidationError.nameRequired);
    } else if (trimmed.length > kExerciseNameMaxLength) {
      errors.add(ExerciseValidationError.nameTooLong);
    } else {
      final normalized = normalizeText(trimmed);
      final isDuplicate = existing.any(
        (e) => e.id != editingId && normalizeText(e.name) == normalized,
      );
      if (isDuplicate) errors.add(ExerciseValidationError.nameDuplicate);
    }

    if (primaryMuscle == null) {
      errors.add(ExerciseValidationError.primaryMuscleRequired);
    } else if (secondaryMuscles.contains(primaryMuscle)) {
      errors.add(ExerciseValidationError.secondaryIncludesPrimary);
    }
    if (type == null) {
      errors.add(ExerciseValidationError.typeRequired);
    }
    if (equipment == null) {
      errors.add(ExerciseValidationError.equipmentRequired);
    }
    if (difficulty == null) {
      errors.add(ExerciseValidationError.difficultyRequired);
    }
    return errors;
  }
}
