import 'package:app_entrenamiento/features/workout/domain/exercise_performance.dart';
import 'package:app_entrenamiento/features/workout/domain/set_prefill.dart';
import 'package:app_entrenamiento/features/workout/domain/set_values.dart';
import 'package:app_entrenamiento/features/workout/domain/workout_session.dart';
import 'package:flutter_test/flutter_test.dart';

SetEntry _set(
  int number, {
  double weightKg = 0,
  int reps = 0,
  int? rir,
  bool completed = false,
}) => SetEntry(
  id: 's$number',
  sessionExerciseId: 'e',
  setNumber: number,
  weightKg: weightKg,
  reps: reps,
  rir: rir,
  isCompleted: completed,
);

ExercisePerformance _last(List<SetEntry> sets) => ExercisePerformance(
  sessionId: 'old',
  exerciseId: 'x',
  performedAt: DateTime.utc(2026),
  sets: sets,
);

void main() {
  group('initialSetValues', () {
    test('given no history, when prefilled, '
        'then sets use the initial weight and the minimum target reps', () {
      expect(
        initialSetValues(count: 2, targetRepsMin: 8, initialWeightKg: 40),
        [
          const SetValues(weightKg: 40, reps: 8),
          const SetValues(weightKg: 40, reps: 8),
        ],
      );
    });

    test('given nothing to go on, when prefilled, then sets are zero', () {
      expect(initialSetValues(count: 1), [const SetValues()]);
    });

    test('given a shorter last session, when prefilled, '
        'then weights match set by set and repeat the last one', () {
      final values = initialSetValues(
        count: 3,
        targetRepsMin: 10,
        initialWeightKg: 20,
        last: _last([
          _set(1, weightKg: 60, reps: 12),
          _set(2, weightKg: 55, reps: 9),
        ]),
      );

      expect([for (final v in values) v.weightKg], [60, 55, 55]);
      expect([for (final v in values) v.reps], [10, 10, 10]);
    });

    test('given no rep target, when prefilled, '
        'then reps come from the last session', () {
      final values = initialSetValues(
        count: 1,
        last: _last([_set(1, weightKg: 60, reps: 12)]),
      );

      expect(values, [const SetValues(weightKg: 60, reps: 12)]);
    });
  });

  group('setToPrefillAfter', () {
    test('given a pending next set, then it is returned', () {
      final sets = [_set(1, completed: true), _set(2), _set(3)];

      expect(setToPrefillAfter(sets, sets.first), sets[1]);
    });

    test('given a completed next set, then nothing is prefilled', () {
      final sets = [_set(1, completed: true), _set(2, completed: true)];

      expect(setToPrefillAfter(sets, sets.first), isNull);
    });

    test('given the last set, then nothing is prefilled', () {
      final sets = [_set(1), _set(2, completed: true)];

      expect(setToPrefillAfter(sets, sets.last), isNull);
    });
  });

  group('valuesForNewSet', () {
    test('given sets, then the new one copies the last without RIR', () {
      expect(
        valuesForNewSet([_set(1, weightKg: 50, reps: 8, rir: 2)]),
        const SetValues(weightKg: 50, reps: 8),
      );
    });

    test('given no sets, then the new one is zero', () {
      expect(valuesForNewSet(const []), const SetValues());
    });
  });
}
