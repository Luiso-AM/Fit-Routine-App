import 'package:app_entrenamiento/core/routing/app_routes.dart';
import 'package:app_entrenamiento/features/history/presentation/history_strings.dart';
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

Finder _dialogButton(String label) =>
    find.descendant(of: find.byType(AlertDialog), matching: find.text(label));

Finder _appBarText(String text) =>
    find.descendant(of: find.byType(AppBar), matching: find.text(text));

/// The history works with the device's real date.
final DateTime _now = DateTime.now();

DateTime _today(int hour) => DateTime(_now.year, _now.month, _now.day, hour);

void main() {
  testWidgets('given a session today, when the history opens, '
      'then today is selected and lists it', (tester) async {
    await pumpApp(
      tester,
      location: AppRoutes.progress,
      exercises: workoutExercises,
      sessions: [
        finishedSession(
          id: 'w1',
          startedAt: _today(7),
          minutes: 45,
          sets: [(60, 8), (60, 8)],
        ),
      ],
    );

    expect(find.text(HistoryStrings.title), findsOneWidget);
    expect(find.text(HistoryStrings.monthCount(1)), findsOneWidget);
    expect(find.text('Push'), findsOneWidget);
    expect(find.textContaining('1 ejercicio · 2 series'), findsOneWidget);
    expect(find.text('45:00'), findsOneWidget);
  });

  testWidgets('given a session last month, when going back a month and '
      'selecting its day, then it is listed', (tester) async {
    final lastMonth = DateTime(_now.year, _now.month - 1, 15, 9);
    await pumpApp(
      tester,
      location: AppRoutes.progress,
      exercises: workoutExercises,
      sessions: [
        finishedSession(
          id: 'w1',
          routineDayId: null,
          startedAt: lastMonth,
          minutes: 30,
          sets: [(60, 8)],
        ),
      ],
    );
    expect(find.text(HistoryStrings.monthCount(0)), findsOneWidget);
    expect(find.text(HistoryStrings.noSessionsOnDay), findsOneWidget);

    await _tap(tester, find.byTooltip(HistoryStrings.previousMonth));
    expect(find.text(HistoryStrings.monthCount(1)), findsOneWidget);
    await _tap(tester, find.text('15'));

    expect(find.text(HistoryStrings.freeSession), findsOneWidget);
    expect(find.text('30:00'), findsOneWidget);
  });

  testWidgets('given the current month, then the next month is not '
      'reachable', (tester) async {
    await pumpApp(tester, location: AppRoutes.progress);

    final next = tester.widget<IconButton>(
      find.widgetWithIcon(IconButton, Icons.chevron_right),
    );
    expect(next.onPressed, isNull);
  });

  testWidgets('given a listed session, when tapped, then its detail shows '
      'its totals, notes and comparison', (tester) async {
    await pumpApp(
      tester,
      location: AppRoutes.progress,
      exercises: workoutExercises,
      sessions: [
        finishedSession(
          id: 'before',
          startedAt: _today(7).subtract(const Duration(days: 40)),
          minutes: 40,
          sets: [(60, 8)],
        ),
        finishedSession(
          id: 'w1',
          startedAt: _today(7),
          minutes: 45,
          sets: [(60, 8), (60, 8)],
          notes: 'Buena energía',
        ),
      ],
    );

    await _tap(tester, find.text('Push'));

    expect(_appBarText(WorkoutStrings.sessionTitle), findsOneWidget);
    expect(find.text('960 kg'), findsNWidgets(2));
    expect(find.text('+480 kg'), findsOneWidget);
    expect(find.text(WorkoutStrings.sessionNotes), findsOneWidget);
    expect(find.text('Buena energía'), findsOneWidget);
    expect(find.text(WorkoutStrings.done), findsNothing);
  });

  testWidgets('given a past session, when its notes and a pending set are '
      'edited, then they are saved and the detail updates', (tester) async {
    final app = await pumpApp(
      tester,
      location: AppRoutes.historySession('w1'),
      exercises: workoutExercises,
      sessions: [
        finishedSession(
          id: 'w1',
          startedAt: _today(7),
          minutes: 45,
          sets: [(60, 8)],
          pendingSets: [(60, 8), (50, 5)],
        ),
      ],
    );
    expect(find.text('480 kg'), findsNWidgets(2));

    await _tap(tester, find.byTooltip(WorkoutStrings.editSession));
    expect(_appBarText(WorkoutStrings.editTitle), findsOneWidget);
    expect(find.text(WorkoutStrings.lastTime), findsNothing);
    await tester.enterText(
      find.byKey(const Key('session-notes-field')),
      'Me dolió el hombro',
    );
    await _tap(tester, find.byTooltip(WorkoutStrings.completeSet).first);
    await _tap(tester, find.text(WorkoutStrings.done));

    final session = app.workouts.sessions.single;
    expect(session.notes, 'Me dolió el hombro');
    final [_, second, third] = session.exercises.single.sets;
    expect(second.isCompleted, isTrue);
    expect((third.weightKg, third.reps, third.isCompleted), (50.0, 5, false));
    expect(session.restEndsAt, isNull);
    expect(_appBarText(WorkoutStrings.sessionTitle), findsOneWidget);
    expect(find.text('960 kg'), findsNWidgets(2));
    expect(find.text('Me dolió el hombro'), findsOneWidget);
  });

  testWidgets('given a past session, when removed from history, then it is '
      'discarded and no longer listed', (tester) async {
    final app = await pumpApp(
      tester,
      location: AppRoutes.progress,
      exercises: workoutExercises,
      sessions: [
        finishedSession(
          id: 'w1',
          startedAt: _today(7),
          minutes: 45,
          sets: [(60, 8)],
        ),
      ],
    );
    await _tap(tester, find.text('Push'));

    await _tap(tester, find.byTooltip(WorkoutStrings.more));
    await _tap(tester, find.text(WorkoutStrings.removeFromHistory));
    expect(find.text(WorkoutStrings.removeFromHistoryMessage), findsOneWidget);
    await _tap(tester, _dialogButton(WorkoutStrings.removeFromHistory));

    expect(app.workouts.sessions.single.status, SessionStatus.discarded);
    expect(find.text(HistoryStrings.title), findsOneWidget);
    expect(find.text(WorkoutStrings.removedFromHistory), findsOneWidget);
    expect(find.text('Push'), findsNothing);
    expect(find.text(HistoryStrings.monthCount(0)), findsOneWidget);
  });
}
