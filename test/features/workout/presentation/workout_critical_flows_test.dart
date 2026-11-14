import 'package:app_entrenamiento/core/routing/app_routes.dart';
import 'package:app_entrenamiento/core/strings/app_strings.dart';
import 'package:app_entrenamiento/features/dashboard/presentation/dashboard_screen.dart';
import 'package:app_entrenamiento/features/workout/domain/enums/session_status.dart';
import 'package:app_entrenamiento/features/workout/domain/workout_session.dart';
import 'package:app_entrenamiento/features/workout/presentation/workout_strings.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../../helpers/pump_app.dart';
import 'workout_test_data.dart';

Future<void> _tap(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

Finder _dialogButton(String label) =>
    find.descendant(of: find.byType(AlertDialog), matching: find.text(label));

List<SetEntry> _sets(PumpedApp app) =>
    app.workouts.sessions.single.exercises.single.sets;

void main() {
  group('completing a set', () {
    Future<PumpedApp> pumpActive(WidgetTester tester) async {
      final app = await pumpApp(
        tester,
        location: AppRoutes.workout,
        exercises: workoutExercises,
        sessions: [activeSession()],
      );
      await _tap(tester, _dialogButton(WorkoutStrings.continueWorkout));
      return app;
    }

    testWidgets('given a pending set, when its check is tapped, '
        'then it is saved as completed and progress advances', (tester) async {
      final app = await pumpActive(tester);

      await _tap(tester, find.byTooltip(WorkoutStrings.completeSet).first);

      final [first, second] = _sets(app);
      expect(first.isCompleted, isTrue);
      expect(first.completedAt, testNow);
      expect(second.isCompleted, isFalse);
      expect(find.text(WorkoutStrings.setsProgress(1, 2)), findsOneWidget);
      expect(find.byTooltip(WorkoutStrings.undoSet), findsOneWidget);
    });

    testWidgets('given a set with new values, when completed from its '
        'editor, then the next set is prefilled with them', (tester) async {
      final app = await pumpActive(tester);

      await _tap(tester, find.text('8').first);
      await tester.enterText(find.byKey(const Key('set-weight-field')), '65');
      await tester.enterText(find.byKey(const Key('set-reps-field')), '6');
      await tester.pumpAndSettle();
      await _tap(
        tester,
        find.widgetWithText(FilledButton, WorkoutStrings.completeSet),
      );

      final [first, second] = _sets(app);
      expect((first.weightKg, first.reps, first.isCompleted), (65.0, 6, true));
      expect(
        (second.weightKg, second.reps, second.isCompleted),
        (65.0, 6, false),
      );
      expect(find.text('65'), findsNWidgets(2));
    });

    testWidgets('given a completed set, when its check is tapped again, '
        'then it is pending again', (tester) async {
      final app = await pumpActive(tester);
      await _tap(tester, find.byTooltip(WorkoutStrings.completeSet).first);

      await _tap(tester, find.byTooltip(WorkoutStrings.undoSet));

      expect(_sets(app).every((s) => !s.isCompleted), isTrue);
      expect(find.text(WorkoutStrings.setsProgress(0, 2)), findsOneWidget);
    });

    testWidgets('given all sets completed, when finished, '
        'then the session is saved without a pending-sets warning', (
      tester,
    ) async {
      final app = await pumpActive(tester);
      await _tap(tester, find.byTooltip(WorkoutStrings.completeSet).first);
      await _tap(tester, find.byTooltip(WorkoutStrings.completeSet).first);

      await _tap(tester, find.text(WorkoutStrings.finish));
      expect(find.text(WorkoutStrings.finishMessage), findsOneWidget);
      await _tap(tester, _dialogButton(WorkoutStrings.finish));

      final session = app.workouts.sessions.single;
      expect(session.status, SessionStatus.completed);
      expect(session.completedSets, 2);
    });
  });

  group('resuming a session', () {
    testWidgets('given a session in progress at launch, when the app opens, '
        'then it offers to continue it', (tester) async {
      await pumpApp(
        tester,
        exercises: workoutExercises,
        sessions: [activeSession()],
      );

      expect(find.text(WorkoutStrings.resumeTitle), findsOneWidget);
      expect(find.text(WorkoutStrings.resumeMessage('Push')), findsOneWidget);
    });

    testWidgets('given the prompt, when continue is tapped, '
        'then the session opens with its saved sets', (tester) async {
      final session = activeSession();
      final entry = session.exercises.single;
      final [first, second] = entry.sets;
      final resumed = session.copyWith(
        exercises: [
          entry.copyWith(
            sets: [first.copyWith(weightKg: 70, isCompleted: true), second],
          ),
        ],
      );
      await pumpApp(tester, exercises: workoutExercises, sessions: [resumed]);

      await _tap(tester, _dialogButton(WorkoutStrings.continueWorkout));

      expect(find.text(WorkoutStrings.resumeTitle), findsNothing);
      expect(find.text(bench.name), findsOneWidget);
      expect(find.text('70'), findsOneWidget);
      expect(find.text(WorkoutStrings.setsProgress(1, 2)), findsOneWidget);
    });

    testWidgets('given the prompt, when discard is confirmed, '
        'then the session is left out and the tab is empty', (tester) async {
      final app = await pumpApp(
        tester,
        exercises: workoutExercises,
        sessions: [activeSession()],
      );

      await _tap(tester, _dialogButton(WorkoutStrings.discard));
      await _tap(tester, _dialogButton(WorkoutStrings.discard));

      expect(app.workouts.sessions.single.status, SessionStatus.discarded);
      expect(find.byType(DashboardScreen), findsOneWidget);
      await _tap(
        tester,
        find.descendant(
          of: find.byType(NavigationBar),
          matching: find.text(AppStrings.tabWorkout),
        ),
      );
      expect(find.text(WorkoutStrings.startFreeSession), findsOneWidget);
    });

    testWidgets('given the prompt, when dismissed, '
        'then the session stays in progress in the workout tab', (
      tester,
    ) async {
      final app = await pumpApp(
        tester,
        exercises: workoutExercises,
        sessions: [activeSession()],
      );

      await tester.tapAt(const Offset(8, 8));
      await tester.pumpAndSettle();
      await _tap(
        tester,
        find.descendant(
          of: find.byType(NavigationBar),
          matching: find.text(AppStrings.tabWorkout),
        ),
      );

      expect(app.workouts.sessions.single.isInProgress, isTrue);
      expect(find.text(bench.name), findsOneWidget);
    });

    testWidgets('given no session at launch, when one is started, '
        'then the prompt is not shown', (tester) async {
      await pumpApp(tester, location: AppRoutes.workout);

      await _tap(tester, find.text(WorkoutStrings.startFreeSession));
      await _tap(
        tester,
        find.descendant(
          of: find.byType(NavigationBar),
          matching: find.text(AppStrings.tabHome),
        ),
      );

      expect(find.text(WorkoutStrings.resumeTitle), findsNothing);
    });
  });
}
