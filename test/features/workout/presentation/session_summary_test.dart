import 'package:app_entrenamiento/core/routing/app_routes.dart';
import 'package:app_entrenamiento/core/units/weight_conversion.dart';
import 'package:app_entrenamiento/core/units/weight_unit.dart';
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

/// A finished session of the "Push" day (or a free one), lasting
/// [minutes], with one exercise whose (weight in kg, reps) [sets] are all
/// completed.
WorkoutSession _finished({
  required String id,
  required DateTime startedAt,
  required int minutes,
  required List<(double, int)> sets,
  String? routineDayId = 'd1',
  String exerciseId = 'bench',
}) => WorkoutSession(
  id: id,
  routineDayId: routineDayId,
  routineName: routineDayId == null ? null : 'PPL',
  routineDayName: routineDayId == null ? null : 'Push',
  startedAt: startedAt,
  endedAt: startedAt.add(Duration(minutes: minutes)),
  status: SessionStatus.completed,
  exercises: [
    SessionExercise(
      id: '$id-e',
      sessionId: id,
      exerciseId: exerciseId,
      position: 0,
      sets: [
        for (final (i, (weightKg, reps)) in sets.indexed)
          SetEntry(
            id: '$id-s$i',
            sessionExerciseId: '$id-e',
            setNumber: i + 1,
            weightKg: weightKg,
            reps: reps,
            isCompleted: true,
          ),
      ],
    ),
  ],
);

void main() {
  testWidgets('given all sets completed, when the session is finished, '
      'then its summary shows the totals', (tester) async {
    await pumpApp(
      tester,
      location: AppRoutes.workout,
      exercises: workoutExercises,
      sessions: [activeSession()],
    );
    await _tap(tester, _dialogButton(WorkoutStrings.continueWorkout));
    await _tap(tester, find.byTooltip(WorkoutStrings.completeSet).first);
    await _tap(tester, find.byTooltip(WorkoutStrings.completeSet).first);

    await _tap(tester, find.text(WorkoutStrings.finish));
    await _tap(tester, _dialogButton(WorkoutStrings.finish));

    // Started at 9:30, finished at 10:00.
    expect(find.text('30:00'), findsOneWidget);
    expect(find.text('960 kg'), findsNWidgets(2));
    expect(find.text('16'), findsOneWidget);
    expect(find.text(bench.name), findsOneWidget);
    expect(find.text('2 × 8 × 60 kg'), findsOneWidget);
    expect(find.text(WorkoutStrings.firstTimeDay), findsOneWidget);
  });

  testWidgets('given a previous session of the same day, when the summary '
      'opens, then each total is compared with it', (tester) async {
    final previous = _finished(
      id: 'before',
      startedAt: DateTime.utc(2026, 11, 12, 9),
      minutes: 50,
      sets: [(60, 8), (60, 8)],
    );
    final current = _finished(
      id: 'now',
      startedAt: DateTime.utc(2026, 11, 14, 9),
      minutes: 55,
      sets: [(62.5, 8), (62.5, 8), (62.5, 6)],
    );
    // An older session of the day is not the one compared with.
    final older = _finished(
      id: 'older',
      startedAt: DateTime.utc(2026, 11, 10, 9),
      minutes: 10,
      sets: [(40, 5)],
    );

    await pumpApp(
      tester,
      location: AppRoutes.workoutSummary(current.id),
      exercises: workoutExercises,
      sessions: [older, previous, current],
    );

    expect(find.text(WorkoutStrings.comparedWith('12 nov')), findsOneWidget);
    expect(find.text('1,375 kg'), findsNWidgets(2));
    expect(find.text('+415 kg'), findsOneWidget);
    expect(find.text('+5:00'), findsOneWidget);
    expect(find.text(WorkoutStrings.noChange), findsOneWidget);
    expect(find.text('+1'), findsOneWidget);
    expect(find.text('+6'), findsOneWidget);
    expect(find.byIcon(Icons.arrow_upward), findsNWidgets(4));
  });

  testWidgets('given a session that did less than the previous one, '
      'when the summary opens, then the decreases are shown', (tester) async {
    final previous = _finished(
      id: 'before',
      startedAt: DateTime.utc(2026, 11, 12, 9),
      minutes: 60,
      sets: [(60, 8), (60, 8)],
    );
    final current = _finished(
      id: 'now',
      startedAt: DateTime.utc(2026, 11, 14, 9),
      minutes: 40,
      sets: [(60, 8)],
    );

    await pumpApp(
      tester,
      location: AppRoutes.workoutSummary(current.id),
      exercises: workoutExercises,
      sessions: [previous, current],
    );

    expect(find.text('−480 kg'), findsOneWidget);
    expect(find.text('−20:00'), findsOneWidget);
    expect(find.text('−1'), findsOneWidget);
    expect(find.text('−8'), findsOneWidget);
    expect(find.byIcon(Icons.arrow_downward), findsNWidgets(4));
  });

  testWidgets('given a free session of an exercise in lb, when the summary '
      'opens, then weights are in lb and nothing is compared', (tester) async {
    final session = _finished(
      id: 'free',
      routineDayId: null,
      exerciseId: fly.id,
      startedAt: DateTime.utc(2026, 11, 14, 9),
      minutes: 20,
      sets: [(toKg(50, WeightUnit.lb), 10)],
    );

    await pumpApp(
      tester,
      location: AppRoutes.workoutSummary(session.id),
      exercises: workoutExercises,
      sessions: [session],
    );

    expect(find.text(WorkoutStrings.freeSession), findsOneWidget);
    expect(find.text('500 lb'), findsNWidgets(2));
    expect(find.text('1 × 10 × 50 lb'), findsOneWidget);
    expect(find.text(WorkoutStrings.firstTimeDay), findsNothing);
    expect(find.byIcon(Icons.arrow_upward), findsNothing);
  });

  testWidgets('given an unknown session, when the summary opens, '
      'then it says so', (tester) async {
    await pumpApp(tester, location: AppRoutes.workoutSummary('missing'));

    expect(find.text(WorkoutStrings.summaryNotFound), findsOneWidget);
  });
}
