import 'package:app_entrenamiento/features/history/domain/training_days.dart';
import 'package:app_entrenamiento/features/workout/domain/workout_session.dart';
import 'package:flutter_test/flutter_test.dart';

/// A session that started at a local time.
WorkoutSession _session(String id, DateTime localStart) =>
    WorkoutSession(id: id, startedAt: localStart.toUtc());

void main() {
  group('monthRange', () {
    test('given a moment in a month, when its range is taken, '
        'then it spans from its first local midnight to the next month', () {
      final range = monthRange(DateTime(2026, 11, 17, 22, 30));

      expect(range.from, DateTime(2026, 11).toUtc());
      expect(range.to, DateTime(2026, 12).toUtc());
      expect(range.from.isUtc && range.to.isUtc, isTrue);
    });

    test('given a moment in December, when its range is taken, '
        'then it ends when January of the next year starts', () {
      final range = monthRange(DateTime(2026, 12, 31, 23, 59));

      expect(range.to, DateTime(2027).toUtc());
    });

    test('given a UTC moment, when its range is taken, '
        'then the month is the local one', () {
      final local = DateTime(2026, 11, 1, 0, 30);

      expect(monthRange(local.toUtc()).from, DateTime(2026, 11).toUtc());
    });
  });

  group('sessionsByDay', () {
    test('given sessions on several days, when grouped, '
        'then each local day lists its sessions in order', () {
      final morning = _session('a', DateTime(2026, 11, 14, 7));
      final evening = _session('b', DateTime(2026, 11, 14, 23, 50));
      final next = _session('c', DateTime(2026, 11, 15, 0, 10));

      expect(sessionsByDay([morning, evening, next]), {
        DateTime.utc(2026, 11, 14): [morning, evening],
        DateTime.utc(2026, 11, 15): [next],
      });
    });

    test('given no sessions, when grouped, then there are no days', () {
      expect(sessionsByDay(const []), isEmpty);
    });
  });
}
