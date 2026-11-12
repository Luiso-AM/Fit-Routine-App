import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/units/weight_unit.dart';
import 'enums/difficulty.dart';
import 'enums/equipment.dart';
import 'enums/exercise_type.dart';
import 'enums/muscle_group.dart';

part 'exercise.freezed.dart';

@freezed
abstract class Exercise with _$Exercise {
  const factory Exercise({
    required String id,
    required String name,
    required MuscleGroup primaryMuscle,
    @Default(<MuscleGroup>[]) List<MuscleGroup> secondaryMuscles,
    required ExerciseType type,
    required Equipment equipment,
    required Difficulty difficulty,
    @Default('') String instructions,
    @Default('') String commonMistakes,

    /// `null` means the default placeholder image.
    String? imagePath,
    @Default(WeightUnit.kg) WeightUnit preferredUnit,
    @Default(false) bool isCustom,

    /// Reference data shipped with the app.
    @Default(false) bool isSeed,
  }) = _Exercise;

  const Exercise._();

  /// Seed exercises are read-only; only custom ones can be edited or deleted.
  bool get isEditable => !isSeed;
}
