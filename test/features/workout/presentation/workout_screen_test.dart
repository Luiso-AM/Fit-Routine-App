import 'package:app_entrenamiento/core/routing/app_routes.dart';
import 'package:app_entrenamiento/core/strings/app_strings.dart';
import 'package:app_entrenamiento/core/units/weight_unit.dart';
import 'package:app_entrenamiento/features/exercises/data/exercise_data_providers.dart';
import 'package:app_entrenamiento/features/routines/presentation/routine_strings.dart';
import 'package:app_entrenamiento/features/workout/domain/enums/session_status.dart';
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

Finder _appBarText(String text) =>
    find.descendant(of: find.byType(AppBar), matching: find.text(text));

void main() {
  group('no session in progress', () {
    testWidgets('given no routines, when the tab opens, '
        'then it offers a free session and explains routines', (tester) async {
      final app = await pumpApp(tester, location: AppRoutes.workout);

      expect(find.text(WorkoutStrings.startFreeSession), findsOneWidget);
      expect(find.text(WorkoutStrings.noRoutines), findsOneWidget);
      expect(app.wakeLock.enabled, isFalse);
    });

    testWidgets('given a routine, when one of its days is tapped, '
        'then a session starts with its exercises', (tester) async {
      final app = await pumpApp(
        tester,
        location: AppRoutes.workout,
        exercises: workoutExercises,
        routines: [pushRoutine],
      );

      await _tap(tester, find.text('Push'));

      expect(_appBarText('Push'), findsOneWidget);
      expect(_appBarText('PPL'), findsOneWidget);
      expect(find.text(bench.name), findsOneWidget);
      expect(find.text(WorkoutStrings.setsProgress(0, 3)), findsOneWidget);
      expect(app.workouts.sessions.single.routineDayId, 'd1');
      expect(app.wakeLock.enabled, isTrue);
    });

    testWidgets('given a free session, when exercises are picked, '
        'then they are added with their sets', (tester) async {
      final app = await pumpApp(
        tester,
        location: AppRoutes.workout,
        exercises: workoutExercises,
      );
      await _tap(tester, find.text(WorkoutStrings.startFreeSession));
      expect(_appBarText(WorkoutStrings.freeSession), findsOneWidget);
      expect(find.text(WorkoutStrings.noExercises), findsOneWidget);

      await _tap(tester, find.text(WorkoutStrings.addExercise));
      await _tap(tester, find.text(fly.name));
      await _tap(tester, find.text(AppStrings.pickerAddSelected(1)));

      expect(find.text(fly.name), findsOneWidget);
      expect(find.text(WorkoutStrings.noHistory), findsOneWidget);
      final entry = app.workouts.sessions.single.exercises.single;
      expect(entry.exerciseId, fly.id);
      expect(entry.sets, hasLength(3));
    });
  });

  group('starting from a routine day', () {
    testWidgets('given a routine day, when its start button is tapped, '
        'then the workout tab opens with the session', (tester) async {
      final app = await pumpApp(
        tester,
        location: AppRoutes.routineDay('r1', 'd1'),
        exercises: workoutExercises,
        routines: [pushRoutine],
      );

      await _tap(tester, find.text(RoutineStrings.startWorkout));

      expect(_appBarText('Push'), findsOneWidget);
      expect(find.text(bench.name), findsOneWidget);
      expect(app.workouts.sessions.single.isInProgress, isTrue);
    });

    testWidgets('given a session in progress, when another is started, '
        'then the user can discard it and start the new one', (tester) async {
      final app = await pumpApp(
        tester,
        location: AppRoutes.routineDay('r1', 'd1'),
        exercises: workoutExercises,
        routines: [pushRoutine],
        sessions: [activeSession()],
      );

      await _tap(tester, find.text(RoutineStrings.startWorkout));
      expect(find.text(WorkoutStrings.activeExistsTitle), findsOneWidget);
      await _tap(tester, find.text(WorkoutStrings.discardAndStart));

      final [old, started] = app.workouts.sessions;
      expect(old.status, SessionStatus.discarded);
      expect(started.isInProgress, isTrue);
      expect(find.text(WorkoutStrings.setsProgress(0, 3)), findsOneWidget);
    });

    testWidgets('given a session in progress, when another is started, '
        'then the user can continue the current one', (tester) async {
      final app = await pumpApp(
        tester,
        location: AppRoutes.routineDay('r1', 'd1'),
        exercises: workoutExercises,
        routines: [pushRoutine],
        sessions: [activeSession()],
      );

      await _tap(tester, find.text(RoutineStrings.startWorkout));
      await _tap(tester, find.text(WorkoutStrings.continueActive));

      expect(app.workouts.sessions, hasLength(1));
      expect(find.text(WorkoutStrings.setsProgress(0, 2)), findsOneWidget);
    });
  });

  group('session in progress', () {
    Future<PumpedApp> pumpActive(WidgetTester tester) => pumpApp(
      tester,
      location: AppRoutes.workout,
      exercises: workoutExercises,
      sessions: [activeSession()],
    );

    testWidgets('given a session, when it renders, '
        'then it shows the clock, targets and sets', (tester) async {
      await pumpActive(tester);

      // Started at 9:30, "now" is 10:00 in tests.
      expect(find.text('30:00'), findsOneWidget);
      expect(find.textContaining('2 × 6–8'), findsOneWidget);
      expect(find.text(WorkoutStrings.setsProgress(0, 2)), findsOneWidget);
      expect(find.text('Peso (kg)'), findsOneWidget);
    });

    testWidgets('given a session, when paused and resumed, '
        'then the state is saved and shown', (tester) async {
      final app = await pumpActive(tester);

      await _tap(tester, find.byTooltip(WorkoutStrings.pause));
      expect(find.text(WorkoutStrings.paused), findsOneWidget);
      expect(app.workouts.sessions.single.isPaused, isTrue);

      await _tap(tester, find.byTooltip(WorkoutStrings.resume));
      expect(find.text(WorkoutStrings.paused), findsNothing);
      expect(app.workouts.sessions.single.isPaused, isFalse);
    });

    testWidgets('given pending sets, when finished, '
        'then the user is warned and the session is saved', (tester) async {
      final app = await pumpActive(tester);

      await _tap(tester, find.text(WorkoutStrings.finish));
      expect(find.text(WorkoutStrings.finishPendingMessage(2)), findsOneWidget);
      await _tap(
        tester,
        find.descendant(
          of: find.byType(AlertDialog),
          matching: find.text(WorkoutStrings.finish),
        ),
      );

      expect(app.workouts.sessions.single.status, SessionStatus.completed);
      expect(find.text(WorkoutStrings.finished), findsOneWidget);
      expect(find.text(WorkoutStrings.startFreeSession), findsOneWidget);
      expect(app.wakeLock.enabled, isFalse);
    });

    testWidgets('given a session, when discarded from the menu, '
        'then it is left out of history', (tester) async {
      final app = await pumpActive(tester);

      await _tap(tester, find.byTooltip(WorkoutStrings.more));
      await _tap(tester, find.text(WorkoutStrings.discard));
      await _tap(
        tester,
        find.descendant(
          of: find.byType(AlertDialog),
          matching: find.text(WorkoutStrings.discard),
        ),
      );

      expect(app.workouts.sessions.single.status, SessionStatus.discarded);
      expect(find.text(WorkoutStrings.discarded), findsOneWidget);
    });

    testWidgets('given an exercise in kg, when its unit is tapped, '
        'then it switches to lb and is remembered', (tester) async {
      final app = await pumpActive(tester);

      await _tap(tester, find.widgetWithText(TextButton, 'kg'));

      expect(find.text('Peso (lb)'), findsOneWidget);
      expect(find.text('132.3'), findsNWidgets(2));
      final stored = await app.container
          .read(exerciseRepositoryProvider)
          .getById(bench.id);
      expect(stored!.preferredUnit, WeightUnit.lb);
    });

    testWidgets('given a set, when edited with the steppers, '
        'then each change is saved at once', (tester) async {
      final app = await pumpActive(tester);

      await _tap(tester, find.text('8').first);
      await _tap(
        tester,
        find.byTooltip('${WorkoutStrings.increase} Peso (kg)'),
      );
      await _tap(tester, find.byTooltip('${WorkoutStrings.decrease} Reps'));
      await _tap(tester, find.byTooltip('${WorkoutStrings.increase} RIR'));

      final set = app.workouts.sessions.single.exercises.single.sets.first;
      expect((set.weightKg, set.reps, set.rir), (62.5, 7, 0));
    });

    testWidgets('given a set, when removed from its editor, '
        'then the others are renumbered', (tester) async {
      final app = await pumpActive(tester);

      await _tap(tester, find.text('8').first);
      await _tap(tester, find.text(WorkoutStrings.removeSet));

      final sets = app.workouts.sessions.single.exercises.single.sets;
      expect([for (final s in sets) (s.id, s.setNumber)], [('s2', 1)]);
    });

    testWidgets('given an exercise, when added a set, '
        'then it copies the last one', (tester) async {
      final app = await pumpActive(tester);

      await _tap(tester, find.text(WorkoutStrings.addSet));

      final sets = app.workouts.sessions.single.exercises.single.sets;
      expect(sets, hasLength(3));
      expect((sets.last.weightKg, sets.last.reps), (60.0, 8));
    });

    testWidgets('given an exercise, when removed and confirmed, '
        'then it leaves the session', (tester) async {
      final app = await pumpActive(tester);

      await _tap(tester, find.byTooltip(WorkoutStrings.exerciseActions));
      await _tap(tester, find.text(WorkoutStrings.removeExercise));
      await _tap(
        tester,
        find.descendant(
          of: find.byType(AlertDialog),
          matching: find.text(WorkoutStrings.removeExercise),
        ),
      );

      expect(app.workouts.sessions.single.exercises, isEmpty);
      expect(find.text(WorkoutStrings.noExercises), findsOneWidget);
    });

    testWidgets('given a session, when another tab opens, '
        'then the screen is no longer kept on', (tester) async {
      final app = await pumpActive(tester);
      expect(app.wakeLock.enabled, isTrue);

      await _tap(
        tester,
        find.descendant(
          of: find.byType(NavigationBar),
          matching: find.text(AppStrings.tabProfile),
        ),
      );

      expect(app.wakeLock.enabled, isFalse);
    });
  });
}
