import 'package:app_entrenamiento/core/units/weight_conversion.dart';
import 'package:app_entrenamiento/core/units/weight_unit.dart';
import 'package:app_entrenamiento/features/workout/domain/enums/session_status.dart';
import 'package:app_entrenamiento/features/workout/domain/session_summary.dart';
import 'package:app_entrenamiento/features/workout/domain/workout_session.dart';
import 'package:flutter_test/flutter_test.dart';

final DateTime _start = DateTime.utc(2026, 11, 14, 9);

var _nextId = 0;

SetEntry _set(double weightKg, int reps, {bool completed = true}) => SetEntry(
  id: 'set-${++_nextId}',
  sessionExerciseId: 'e',
  setNumber: 1,
  weightKg: weightKg,
  reps: reps,
  isCompleted: completed,
);

SessionExercise _exercise(String exerciseId, List<SetEntry> sets) =>
    SessionExercise(
      id: 'entry-${++_nextId}',
      sessionId: 'w',
      exerciseId: exerciseId,
      position: _nextId,
      sets: sets,
    );

WorkoutSession _session(
  List<SessionExercise> exercises, {
  String id = 'w',
  Duration length = const Duration(minutes: 60),
  int pausedSeconds = 0,
}) => WorkoutSession(
  id: id,
  routineDayId: 'd1',
  startedAt: _start,
  endedAt: _start.add(length),
  pausedTotalSeconds: pausedSeconds,
  status: SessionStatus.completed,
  exercises: exercises,
);

void main() {
  group('completedVolumeKg', () {
    test('given completed and pending sets, when summed, '
        'then only completed sets count', () {
      expect(
        completedVolumeKg([
          _set(60, 8),
          _set(62.5, 6),
          _set(100, 10, completed: false),
        ]),
        60 * 8 + 62.5 * 6,
      );
    });

    test('given no sets, when summed, then the volume is zero', () {
      expect(completedVolumeKg(const []), 0);
    });
  });

  group('SessionTotals', () {
    test('given a finished session with pending sets, when totalled, '
        'then pending sets and exercises without completed sets are '
        'left out', () {
      final session = _session([
        _exercise('bench', [
          _set(60, 8),
          _set(60, 7),
          _set(60, 6, completed: false),
        ]),
        _exercise('fly', [_set(20, 12, completed: false)]),
        _exercise('dips', [_set(0, 10)]),
      ]);

      expect(
        SessionTotals.of(session),
        const SessionTotals(
          duration: Duration(minutes: 60),
          exercises: 2,
          sets: 3,
          reps: 25,
          volumeKg: 60 * 8 + 60 * 7.0,
        ),
      );
    });

    test('given a session paused for a while, when totalled, '
        'then the duration excludes the pause', () {
      final session = _session(const [], pausedSeconds: 600);

      expect(SessionTotals.of(session).duration, const Duration(minutes: 50));
    });

    test('given an empty session, when totalled, then every total is zero', () {
      final totals = SessionTotals.of(_session(const []));

      expect(
        (totals.exercises, totals.sets, totals.reps, totals.volumeKg),
        (0, 0, 0, 0.0),
      );
    });

    test('given weights entered in lb, when totalled, '
        'then the volume is in kg without rounding', () {
      final weightKg = toKg(135, WeightUnit.lb);
      final session = _session([
        _exercise('bench', [_set(weightKg, 5)]),
      ]);

      expect(SessionTotals.of(session).volumeKg, weightKg * 5);
    });
  });

  group('SessionSummary', () {
    test('given a session, when summarized, then each exercise with '
        'completed sets is listed in order with only those sets', () {
      final bench = _exercise('bench', [
        _set(60, 8),
        _set(60, 6, completed: false),
      ]);
      final fly = _exercise('fly', [_set(20, 12, completed: false)]);
      final dips = _exercise('dips', [_set(0, 10)]);

      final summary = SessionSummary.of(_session([bench, fly, dips]));

      expect(
        [for (final e in summary.exercises) e.exerciseId],
        ['bench', 'dips'],
      );
      expect(summary.exercises.first.sets, [bench.sets.first]);
      expect(summary.exercises.first.performedAt, _start);
      expect(summary.comparison, isNull);
    });

    test('given a previous session, when summarized, '
        'then each total is compared with it', () {
      final previous = _session(
        [
          _exercise('bench', [_set(60, 8), _set(60, 8)]),
        ],
        id: 'before',
        length: const Duration(minutes: 50),
      );
      final current = _session([
        _exercise('bench', [_set(62.5, 8), _set(62.5, 8), _set(62.5, 6)]),
        _exercise('dips', [_set(0, 10)]),
      ]);

      final comparison = SessionSummary.of(
        current,
        previous: previous,
      ).comparison;

      expect(
        comparison,
        SessionComparison(
          previousSessionId: 'before',
          previousStartedAt: _start,
          durationDelta: const Duration(minutes: 10),
          exercisesDelta: 1,
          setsDelta: 2,
          repsDelta: 16,
          volumeDeltaKg: 62.5 * 22 - 60 * 16,
        ),
      );
    });

    test('given a previous session that did more, when compared, '
        'then the changes are negative', () {
      final previous = _session([
        _exercise('bench', [_set(80, 10), _set(80, 10)]),
      ], id: 'before');
      final current = _session([
        _exercise('bench', [_set(80, 10)]),
      ], length: const Duration(minutes: 40));

      final comparison = SessionSummary.of(
        current,
        previous: previous,
      ).comparison!;

      expect(comparison.durationDelta, const Duration(minutes: -20));
      expect(comparison.setsDelta, -1);
      expect(comparison.repsDelta, -10);
      expect(comparison.volumeDeltaKg, -800);
    });
  });
}
