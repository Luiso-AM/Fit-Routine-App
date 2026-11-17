import 'package:app_entrenamiento/features/dashboard/domain/weekly_activity.dart';
import 'package:app_entrenamiento/features/workout/domain/enums/session_status.dart';
import 'package:app_entrenamiento/features/workout/domain/workout_session.dart';
import 'package:flutter_test/flutter_test.dart';

/// Wednesday, 18 November 2026, local time.
final DateTime _wednesday = DateTime(2026, 11, 18, 19, 30);

void main() {
  group('weekStart', () {
    test('given a weekday, when its week start is taken, '
        'then it is the previous Monday at midnight', () {
      expect(weekStart(_wednesday), DateTime(2026, 11, 16));
    });

    test('given a Monday or a Sunday, then the week is Monday to Sunday', () {
      expect(weekStart(DateTime(2026, 11, 16, 0, 1)), DateTime(2026, 11, 16));
      expect(weekStart(DateTime(2026, 11, 22, 23, 59)), DateTime(2026, 11, 16));
    });

    test('given a week across months and years, then it starts in the '
        'earlier one', () {
      expect(weekStart(DateTime(2026, 12, 2)), DateTime(2026, 11, 30));
      expect(weekStart(DateTime(2027, 1, 1)), DateTime(2026, 12, 28));
    });

    test('given a week start, when the next one is taken, '
        'then it is the following Monday', () {
      expect(nextWeekStart(DateTime(2026, 12, 28)), DateTime(2027, 1, 4));
    });
  });

  group('trainedTime', () {
    test('given finished sessions, when summed, '
        'then their active durations add up', () {
      WorkoutSession session(int minutes, {int pausedSeconds = 0}) =>
          WorkoutSession(
            id: '$minutes',
            startedAt: DateTime.utc(2026, 11, 16, 10),
            endedAt: DateTime.utc(2026, 11, 16, 10, minutes),
            pausedTotalSeconds: pausedSeconds,
            status: SessionStatus.completed,
          );

      expect(
        trainedTime([session(50), session(45, pausedSeconds: 300)]),
        const Duration(minutes: 90),
      );
      expect(trainedTime(const []), Duration.zero);
    });
  });

  group('weeklyStreak', () {
    /// [count] sessions in the week that starts on [monday].
    List<DateTime> week(DateTime monday, int count) => [
      for (var i = 0; i < count; i++)
        DateTime(monday.year, monday.month, monday.day + i, 18),
    ];

    final thisWeek = DateTime(2026, 11, 16);
    final lastWeek = DateTime(2026, 11, 9);
    final twoWeeksAgo = DateTime(2026, 11, 2);
    final threeWeeksAgo = DateTime(2026, 10, 26);

    test('given past weeks that reached the goal and a current week that '
        'has not yet, then the current week does not break the streak', () {
      final starts = [
        ...week(thisWeek, 1),
        ...week(lastWeek, 3),
        ...week(twoWeeksAgo, 4),
      ];

      expect(weeklyStreak(starts, goal: 3, now: _wednesday), 2);
    });

    test('given the current week reached the goal, then it counts', () {
      final starts = [...week(thisWeek, 3), ...week(lastWeek, 3)];

      expect(weeklyStreak(starts, goal: 3, now: _wednesday), 2);
    });

    test('given a past week below the goal, '
        'then the streak stops there', () {
      final starts = [
        ...week(lastWeek, 3),
        ...week(twoWeeksAgo, 2),
        ...week(threeWeeksAgo, 3),
      ];

      expect(weeklyStreak(starts, goal: 3, now: _wednesday), 1);
    });

    test('given last week below the goal, then there is no streak', () {
      final starts = [...week(lastWeek, 1), ...week(twoWeeksAgo, 5)];

      expect(weeklyStreak(starts, goal: 3, now: _wednesday), 0);
    });

    test('given weeks across a new year, then they are followed', () {
      final starts = [
        ...week(DateTime(2027, 1, 4), 2),
        ...week(DateTime(2026, 12, 28), 2),
        ...week(DateTime(2026, 12, 21), 2),
      ];

      expect(weeklyStreak(starts, goal: 2, now: DateTime(2027, 1, 6)), 3);
    });

    test('given no sessions or no goal, then there is no streak', () {
      expect(weeklyStreak(const [], goal: 3, now: _wednesday), 0);
      expect(weeklyStreak(week(lastWeek, 3), goal: 0, now: _wednesday), 0);
    });

    test('given UTC start times, then they are placed in local weeks', () {
      final starts = [for (final s in week(lastWeek, 2)) s.toUtc()];

      expect(weeklyStreak(starts, goal: 2, now: _wednesday), 1);
    });
  });
}
