import 'package:app_entrenamiento/features/exercises/domain/enums/difficulty.dart';
import 'package:app_entrenamiento/features/exercises/domain/enums/equipment.dart';
import 'package:app_entrenamiento/features/exercises/domain/enums/exercise_type.dart';
import 'package:app_entrenamiento/features/exercises/domain/enums/muscle_group.dart';
import 'package:app_entrenamiento/features/exercises/domain/exercise.dart';
import 'package:app_entrenamiento/features/exercises/domain/exercise_draft.dart';
import 'package:flutter_test/flutter_test.dart';

const _valid = ExerciseDraft(
  name: 'Remo en T (Barra)',
  primaryMuscle: MuscleGroup.back,
  secondaryMuscles: [MuscleGroup.biceps],
  type: ExerciseType.compound,
  equipment: Equipment.barbell,
  difficulty: Difficulty.intermediate,
);

const _existing = Exercise(
  id: 'existing-id',
  name: 'Curl de Bíceps (Barra)',
  primaryMuscle: MuscleGroup.biceps,
  type: ExerciseType.isolation,
  equipment: Equipment.barbell,
  difficulty: Difficulty.beginner,
);

Set<ExerciseValidationError> validate(
  ExerciseDraft draft, {
  String? editingId,
}) => draft.validate(existing: const [_existing], editingId: editingId);

void main() {
  test('given a complete draft, when validated, then it has no errors', () {
    expect(validate(_valid), isEmpty);
  });

  test('given a blank name, when validated, then the name is required', () {
    expect(validate(_valid.copyWith(name: '   ')), {
      ExerciseValidationError.nameRequired,
    });
  });

  test('given a name over the limit, when validated, then it is too long', () {
    final name = 'a' * (kExerciseNameMaxLength + 1);
    expect(validate(_valid.copyWith(name: name)), {
      ExerciseValidationError.nameTooLong,
    });
  });

  test('given a name at the limit with surrounding spaces, when validated, '
      'then it is accepted', () {
    final name = '  ${'a' * kExerciseNameMaxLength}  ';
    expect(validate(_valid.copyWith(name: name)), isEmpty);
  });

  test('given an existing name with different case and accents, '
      'when validated, then it is a duplicate', () {
    expect(validate(_valid.copyWith(name: ' curl de biceps (barra) ')), {
      ExerciseValidationError.nameDuplicate,
    });
  });

  test('given an exercise keeping its own name while edited, '
      'when validated, then it is not a duplicate', () {
    expect(
      validate(
        _valid.copyWith(name: 'Curl de Bíceps (Barra)'),
        editingId: 'existing-id',
      ),
      isEmpty,
    );
  });

  test('given no muscle, type, equipment or difficulty, when validated, '
      'then each one is required', () {
    expect(validate(ExerciseDraft(name: _valid.name)), {
      ExerciseValidationError.primaryMuscleRequired,
      ExerciseValidationError.typeRequired,
      ExerciseValidationError.equipmentRequired,
      ExerciseValidationError.difficultyRequired,
    });
  });

  test('given the primary muscle also as secondary, when validated, '
      'then it is rejected', () {
    expect(validate(_valid.copyWith(secondaryMuscles: [MuscleGroup.back])), {
      ExerciseValidationError.secondaryIncludesPrimary,
    });
  });

  test(
    'given an exercise, when converted to a draft, then fields are copied',
    () {
      final draft = ExerciseDraft.fromExercise(_existing);
      expect(draft.name, _existing.name);
      expect(draft.primaryMuscle, MuscleGroup.biceps);
      expect(draft.type, ExerciseType.isolation);
      expect(draft.equipment, Equipment.barbell);
      expect(draft.difficulty, Difficulty.beginner);
    },
  );
}
