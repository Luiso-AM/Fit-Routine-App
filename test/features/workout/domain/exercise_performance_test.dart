import 'package:app_entrenamiento/features/workout/domain/exercise_performance.dart';
import 'package:app_entrenamiento/features/workout/domain/workout_session.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('given consecutive equal sets, when grouped, '
      'then they merge and keep their order', () {
    var number = 0;
    SetEntry set(double weightKg, int reps) => SetEntry(
      id: '${++number}',
      sessionExerciseId: 'e',
      setNumber: number,
      weightKg: weightKg,
      reps: reps,
      isCompleted: true,
    );
    final performance = ExercisePerformance(
      sessionId: 'w',
      exerciseId: 'x',
      performedAt: DateTime.utc(2026),
      sets: [set(60, 10), set(60, 10), set(60, 8), set(60, 10)],
    );

    expect(performance.groups, const [
      SetGroup(count: 2, reps: 10, weightKg: 60),
      SetGroup(count: 1, reps: 8, weightKg: 60),
      SetGroup(count: 1, reps: 10, weightKg: 60),
    ]);
  });
}
