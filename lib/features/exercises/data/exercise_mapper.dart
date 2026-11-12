import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../domain/exercise.dart';
import '../domain/exercise_draft.dart';

extension ExerciseRowMapper on ExerciseRow {
  Exercise toDomain() => Exercise(
    id: id,
    name: name,
    primaryMuscle: primaryMuscle,
    secondaryMuscles: secondaryMuscles,
    type: type,
    equipment: equipment,
    difficulty: difficulty,
    instructions: instructions,
    commonMistakes: commonMistakes,
    imagePath: imagePath,
    preferredUnit: preferredUnit,
    isCustom: isCustom,
    isSeed: isSeed,
  );
}

extension ExerciseSeedMapper on Exercise {
  /// Full row for inserting a seed exercise with its fixed id.
  ExercisesCompanion toSeedCompanion() => ExercisesCompanion.insert(
    id: Value(id),
    name: name,
    primaryMuscle: primaryMuscle,
    secondaryMuscles: Value(secondaryMuscles),
    type: type,
    equipment: equipment,
    difficulty: difficulty,
    instructions: Value(instructions),
    commonMistakes: Value(commonMistakes),
    imagePath: Value(imagePath),
    preferredUnit: Value(preferredUnit),
    isSeed: const Value(true),
  );
}

extension ExerciseDraftMapper on ExerciseDraft {
  /// Editable columns of a validated draft. Required fields must be set.
  ExercisesCompanion toCompanion() => ExercisesCompanion(
    name: Value(name.trim()),
    primaryMuscle: Value(primaryMuscle!),
    secondaryMuscles: Value(secondaryMuscles),
    type: Value(type!),
    equipment: Value(equipment!),
    difficulty: Value(difficulty!),
    instructions: Value(instructions.trim()),
    commonMistakes: Value(commonMistakes.trim()),
    preferredUnit: Value(preferredUnit),
  );
}
