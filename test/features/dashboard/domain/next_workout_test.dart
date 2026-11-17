import 'package:app_entrenamiento/features/dashboard/domain/next_workout.dart';
import 'package:app_entrenamiento/features/routines/domain/routine.dart';
import 'package:app_entrenamiento/features/workout/domain/session_start.dart';
import 'package:flutter_test/flutter_test.dart';

/// Wednesday, 18 November 2026, local time.
final DateTime _wednesday = DateTime(2026, 11, 18, 8);

RoutineDay _day(
  String id,
  int position, {
  int? weekday,
  bool empty = false,
  String routineId = 'r1',
}) => RoutineDay(
  id: id,
  routineId: routineId,
  name: id,
  position: position,
  weekday: weekday,
  exercises: [
    if (!empty)
      RoutineExercise(
        id: '$id-e',
        routineDayId: id,
        exerciseId: 'bench',
        position: 0,
        targetSets: 3,
        targetRepsMin: 8,
        targetRepsMax: 10,
        restSeconds: 90,
      ),
  ],
);

Routine _routine(String id, List<RoutineDay> days) =>
    Routine(id: id, name: id, days: days);

SessionStart _trained(DateTime localStart, {String? dayId}) => SessionStart(
  sessionId: 'w-$localStart',
  routineDayId: dayId,
  startedAt: localStart.toUtc(),
);

void main() {
  group('scheduled days', () {
    final ppl = _routine('r1', [
      _day('push', 0, weekday: DateTime.monday),
      _day('pull', 1, weekday: DateTime.wednesday),
      _day('legs', 2, weekday: DateTime.friday),
    ]);

    test('given a day scheduled today and nothing trained today, '
        'then it is today\'s day', () {
      final next = nextWorkout(
        routines: [ppl],
        finished: [_trained(DateTime(2026, 11, 16, 18), dayId: 'push')],
        now: _wednesday,
      );

      expect(next?.day.id, 'pull');
      expect(next?.date, DateTime.utc(2026, 11, 18));
    });

    test('given a session already finished today, '
        'then it is the next scheduled day', () {
      final next = nextWorkout(
        routines: [ppl],
        finished: [_trained(DateTime(2026, 11, 18, 7), dayId: 'pull')],
        now: _wednesday,
      );

      expect(next?.day.id, 'legs');
      expect(next?.date, DateTime.utc(2026, 11, 20));
    });

    test('given the next scheduled day is next week, then the week wraps '
        'and the month changes', () {
      final next = nextWorkout(
        routines: [ppl],
        finished: const [],
        now: DateTime(2026, 11, 28, 10),
      );

      expect(next?.day.id, 'push');
      expect(next?.date, DateTime.utc(2026, 11, 30));
    });

    test('given the only scheduled day is today and it was trained, '
        'then it is the same day next week', () {
      final once = _routine('r1', [_day('full', 0, weekday: 3)]);

      final next = nextWorkout(
        routines: [once],
        finished: [_trained(DateTime(2026, 11, 18, 7))],
        now: _wednesday,
      );

      expect(next?.date, DateTime.utc(2026, 11, 25));
    });

    test('given a scheduled day without exercises, then it is skipped', () {
      final routine = _routine('r1', [
        _day('rest', 0, weekday: DateTime.wednesday, empty: true),
        _day('legs', 1, weekday: DateTime.thursday),
      ]);

      final next = nextWorkout(
        routines: [routine],
        finished: const [],
        now: _wednesday,
      );

      expect(next?.day.id, 'legs');
    });

    test('given two routines on the same weekday, '
        'then the first routine wins', () {
      final other = _routine('r2', [
        _day('other', 0, weekday: DateTime.wednesday, routineId: 'r2'),
      ]);

      final next = nextWorkout(
        routines: [other, ppl],
        finished: const [],
        now: _wednesday,
      );

      expect(next?.routine.id, 'r2');
    });
  });

  group('unscheduled days', () {
    final upperLower = _routine('r1', [
      _day('upper', 0),
      _day('lower', 1),
      _day('empty', 2, empty: true),
    ]);

    test('given a day was trained, then it is the following day', () {
      final next = nextWorkout(
        routines: [upperLower],
        finished: [_trained(DateTime(2026, 11, 17), dayId: 'upper')],
        now: _wednesday,
      );

      expect(next?.day.id, 'lower');
      expect(next?.date, isNull);
    });

    test('given the last day was trained, then the routine starts over, '
        'skipping days without exercises', () {
      final next = nextWorkout(
        routines: [upperLower],
        finished: [_trained(DateTime(2026, 11, 17), dayId: 'lower')],
        now: _wednesday,
      );

      expect(next?.day.id, 'upper');
    });

    test('given the latest sessions were free or of removed days, '
        'then the last known routine day is followed', () {
      final next = nextWorkout(
        routines: [upperLower],
        finished: [
          _trained(DateTime(2026, 11, 17, 18)),
          _trained(DateTime(2026, 11, 17, 8), dayId: 'deleted'),
          _trained(DateTime(2026, 11, 16), dayId: 'upper'),
        ],
        now: _wednesday,
      );

      expect(next?.day.id, 'lower');
    });

    test('given nothing trained, then it is the first day of the first '
        'routine', () {
      final next = nextWorkout(
        routines: [upperLower],
        finished: const [],
        now: _wednesday,
      );

      expect(next?.day.id, 'upper');
    });
  });

  test('given no routine day with exercises, then there is none', () {
    expect(
      nextWorkout(
        routines: [
          _routine('r1', [_day('empty', 0, empty: true)]),
        ],
        finished: const [],
        now: _wednesday,
      ),
      isNull,
    );
    expect(
      nextWorkout(routines: const [], finished: const [], now: _wednesday),
      isNull,
    );
  });
}
