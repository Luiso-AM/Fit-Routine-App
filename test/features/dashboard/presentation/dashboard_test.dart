import 'package:app_entrenamiento/core/utils/calendar_date.dart';
import 'package:app_entrenamiento/features/dashboard/domain/weekly_activity.dart';
import 'package:app_entrenamiento/features/dashboard/presentation/dashboard_screen.dart';
import 'package:app_entrenamiento/features/dashboard/presentation/dashboard_strings.dart';
import 'package:app_entrenamiento/features/profile/domain/body_weight_entry.dart';
import 'package:app_entrenamiento/features/routines/domain/routine.dart';
import 'package:app_entrenamiento/features/workout/domain/enums/session_status.dart';
import 'package:app_entrenamiento/features/workout/presentation/workout_strings.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../../helpers/pump_app.dart';
import '../../workout/presentation/workout_test_data.dart';

Future<void> _tap(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

/// The dashboard works with the device's real date.
final DateTime _now = DateTime.now();

/// [pushRoutine] with its day scheduled on [weekday].
Routine _pushOn(int weekday) => pushRoutine.copyWith(
  days: [pushRoutine.days.single.copyWith(weekday: weekday)],
);

void main() {
  testWidgets('given a new user, when the dashboard opens, '
      'then each card explains what to do', (tester) async {
    await pumpApp(tester);

    expect(find.text(DashboardStrings.greeting('Alex')), findsOneWidget);
    expect(find.text(DashboardStrings.noRoutines), findsOneWidget);
    expect(find.text(DashboardStrings.ofGoal(0, 4)), findsOneWidget);
    expect(find.text('0 min'), findsOneWidget);
    expect(find.text(DashboardStrings.weeks(0)), findsOneWidget);
    expect(find.text(DashboardStrings.noWeight), findsOneWidget);

    await _tap(tester, find.text(DashboardStrings.goToRoutines));
    expect(find.text(DashboardStrings.noRoutines), findsNothing);
  });

  testWidgets('given a routine day scheduled today, when started from the '
      'dashboard, then a session of that day begins', (tester) async {
    final app = await pumpApp(
      tester,
      exercises: workoutExercises,
      routines: [_pushOn(_now.weekday)],
    );

    expect(
      find.text('${DashboardStrings.nextWorkout} · ${DashboardStrings.today}'),
      findsOneWidget,
    );
    expect(find.text('Push'), findsOneWidget);
    expect(find.text('1 ejercicio · Pecho'), findsOneWidget);

    await _tap(tester, find.text(DashboardStrings.start));

    final session = app.workouts.sessions.single;
    expect(session.routineDayId, 'd1');
    expect(session.status, SessionStatus.inProgress);
    expect(find.text(WorkoutStrings.finish), findsOneWidget);
  });

  testWidgets('given the scheduled day was trained today, then the next one '
      'is a week later', (tester) async {
    await pumpApp(
      tester,
      exercises: workoutExercises,
      routines: [_pushOn(_now.weekday)],
      sessions: [
        finishedSession(
          id: 'w1',
          startedAt: DateTime(_now.year, _now.month, _now.day),
          minutes: 1,
          sets: [(60, 8)],
        ),
      ],
    );

    final nextWeek = calendarDate(_now).add(const Duration(days: 7));
    final date = MaterialLocalizations.of(
      tester.element(find.byType(DashboardScreen)),
    ).formatMediumDate(nextWeek);
    expect(
      find.text('${DashboardStrings.nextWorkout} · $date'),
      findsOneWidget,
    );
  });

  testWidgets('given a session in progress, when the dashboard opens, '
      'then it offers to continue it', (tester) async {
    await pumpApp(
      tester,
      exercises: workoutExercises,
      routines: [pushRoutine],
      sessions: [activeSession()],
    );
    // Close the prompt shown at launch without answering it.
    await tester.tapAt(const Offset(8, 8));
    await tester.pumpAndSettle();

    expect(find.text(DashboardStrings.inProgress), findsOneWidget);
    expect(find.text('Push · PPL'), findsOneWidget);
    expect(find.text(DashboardStrings.setsProgress(0, 2)), findsOneWidget);

    await _tap(tester, find.text(DashboardStrings.continueWorkout));
    expect(find.text(WorkoutStrings.finish), findsOneWidget);
  });

  testWidgets('given sessions and weights, when the dashboard opens, then '
      'it shows the week, the streak and the weight change', (tester) async {
    final monday = weekStart(_now);
    final lastMonday = DateTime(monday.year, monday.month, monday.day - 7);
    final today = calendarDate(_now);
    await pumpApp(
      tester,
      exercises: workoutExercises,
      sessions: [
        for (var i = 0; i < 2; i++)
          finishedSession(
            id: 'this-$i',
            startedAt: monday.add(Duration(hours: i)),
            minutes: 45,
            sets: [(60, 8)],
          ),
        for (var i = 0; i < 4; i++)
          finishedSession(
            id: 'last-$i',
            startedAt: DateTime(
              lastMonday.year,
              lastMonday.month,
              lastMonday.day + i,
              18,
            ),
            minutes: 60,
            sets: [(60, 8)],
          ),
      ],
      weights: [
        BodyWeightEntry(id: 'b2', date: today, weightKg: 80.2),
        BodyWeightEntry(
          id: 'b1',
          date: today.subtract(const Duration(days: 8)),
          weightKg: 81,
        ),
      ],
    );

    expect(find.text(DashboardStrings.ofGoal(2, 4)), findsOneWidget);
    expect(find.text('1 h 30 min'), findsOneWidget);
    expect(find.text(DashboardStrings.weeks(1)), findsOneWidget);
    expect(find.text(DashboardStrings.streakHint(4)), findsOneWidget);
    expect(find.text('80.2 kg'), findsOneWidget);
    expect(
      find.text(DashboardStrings.changeSince('−0.8 kg', 8)),
      findsOneWidget,
    );
  });

  testWidgets('given the dashboard, when a quick action is tapped, '
      'then its screen opens', (tester) async {
    await pumpApp(tester);
    final history = find.text(DashboardStrings.history);
    await tester.scrollUntilVisible(history, 200);

    await _tap(tester, history);
    expect(find.text('Historial'), findsOneWidget);
  });
}
