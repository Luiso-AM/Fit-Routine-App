import 'package:app_entrenamiento/core/utils/text_normalize.dart';
import 'package:app_entrenamiento/features/exercises/data/seed/seed_exercises.dart';
import 'package:app_entrenamiento/features/exercises/domain/enums/muscle_group.dart';
import 'package:app_entrenamiento/features/exercises/domain/exercise_draft.dart';
import 'package:flutter_test/flutter_test.dart';

final _uuidV4 = RegExp(
  r'^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$',
);

/// `Exercise Name (Equipment)`.
final _namePattern = RegExp(r'^[^()]+ \([^()]+\)$');

void main() {
  test('given the seed library, then every id is a unique UUID v4', () {
    final ids = [for (final e in seedExercises) e.id];
    expect(ids, everyElement(matches(_uuidV4)));
    expect(ids.toSet(), hasLength(ids.length));
  });

  test(
    'given the seed library, then names are unique ignoring case and accents',
    () {
      final names = [for (final e in seedExercises) normalizeText(e.name)];
      expect(names.toSet(), hasLength(names.length));
    },
  );

  test('given the seed library, then names follow "Name (Equipment)"', () {
    for (final exercise in seedExercises) {
      expect(exercise.name, matches(_namePattern), reason: exercise.name);
    }
  });

  test('given the seed library, then every muscle has 2 to 6 exercises', () {
    for (final muscle in MuscleGroup.values) {
      final count = seedExercises.where((e) => e.primaryMuscle == muscle);
      expect(count.length, inInclusiveRange(2, 6), reason: muscle.name);
    }
  });

  test('given the seed library, then every exercise passes draft validation '
      'and has instructions and common mistakes', () {
    for (final exercise in seedExercises) {
      final errors = ExerciseDraft.fromExercise(exercise)
          .validate(existing: seedExercises, editingId: exercise.id);
      expect(errors, isEmpty, reason: exercise.name);
      expect(exercise.instructions, isNotEmpty, reason: exercise.name);
      expect(exercise.commonMistakes, isNotEmpty, reason: exercise.name);
    }
  });
}
