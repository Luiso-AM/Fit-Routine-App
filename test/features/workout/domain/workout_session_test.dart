import 'package:app_entrenamiento/features/workout/domain/workout_session.dart';
import 'package:flutter_test/flutter_test.dart';

final _start = DateTime.utc(2026, 11, 14, 10);

SetEntry _set(int number, {bool completed = false}) => SetEntry(
  id: 's$number',
  sessionExerciseId: 'e',
  setNumber: number,
  isCompleted: completed,
);

void main() {
  group('activeDuration', () {
    test('given a running session, then it counts until now minus pauses', () {
      final session = WorkoutSession(
        id: 'w',
        startedAt: _start,
        pausedTotalSeconds: 300,
      );

      expect(
        session.activeDuration(_start.add(const Duration(minutes: 30))),
        const Duration(minutes: 25),
      );
    });

    test('given a paused session, then it stops at the pause', () {
      final session = WorkoutSession(
        id: 'w',
        startedAt: _start,
        pausedAt: _start.add(const Duration(minutes: 10)),
      );

      expect(
        session.activeDuration(_start.add(const Duration(hours: 1))),
        const Duration(minutes: 10),
      );
    });

    test('given an ended session, then it stops at the end', () {
      final session = WorkoutSession(
        id: 'w',
        startedAt: _start,
        endedAt: _start.add(const Duration(minutes: 50)),
        pausedTotalSeconds: 600,
      );

      expect(
        session.activeDuration(_start.add(const Duration(days: 1))),
        const Duration(minutes: 40),
      );
    });

    test('given a clock before the start, then it is zero', () {
      final session = WorkoutSession(id: 'w', startedAt: _start);

      expect(
        session.activeDuration(_start.subtract(const Duration(minutes: 1))),
        Duration.zero,
      );
    });
  });

  group('pausedSecondsUntil', () {
    test('given a running pause, then it adds the time since it began', () {
      final session = WorkoutSession(
        id: 'w',
        startedAt: _start,
        pausedTotalSeconds: 60,
        pausedAt: _start.add(const Duration(minutes: 10)),
      );

      expect(
        session.pausedSecondsUntil(_start.add(const Duration(minutes: 12))),
        180,
      );
    });

    test('given no pause, then it is the stored total', () {
      final session = WorkoutSession(
        id: 'w',
        startedAt: _start,
        pausedTotalSeconds: 60,
      );

      expect(session.pausedSecondsUntil(_start), 60);
    });
  });

  group('progress', () {
    test('given 2 of 4 sets completed, then progress is one half', () {
      final session = WorkoutSession(
        id: 'w',
        startedAt: _start,
        exercises: [
          SessionExercise(
            id: 'a',
            sessionId: 'w',
            exerciseId: 'x',
            position: 0,
            sets: [_set(1, completed: true), _set(2)],
          ),
          SessionExercise(
            id: 'b',
            sessionId: 'w',
            exerciseId: 'y',
            position: 1,
            sets: [_set(1, completed: true), _set(2)],
          ),
        ],
      );

      expect(session.totalSets, 4);
      expect(session.completedSets, 2);
      expect(session.progress, 0.5);
    });

    test('given no sets, then progress is zero', () {
      expect(WorkoutSession(id: 'w', startedAt: _start).progress, 0);
    });
  });
}
