import 'package:app_entrenamiento/core/routing/app_routes.dart';
import 'package:app_entrenamiento/features/workout/presentation/workout_strings.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mocktail/mocktail.dart';

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

Finder get _countdown => find.byKey(const Key('rest-countdown'));

String _countdownText(WidgetTester tester) =>
    tester.widget<Text>(_countdown).data!;

void main() {
  final restEnd = testNow.add(const Duration(seconds: 120));

  Future<PumpedApp> pumpActive(
    WidgetTester tester, {
    DateTime? restEndsAt,
  }) async {
    final app = await pumpApp(
      tester,
      location: AppRoutes.workout,
      exercises: workoutExercises,
      sessions: [activeSession().copyWith(restEndsAt: restEndsAt)],
    );
    await _tap(tester, _dialogButton(WorkoutStrings.continueWorkout));
    return app;
  }

  testWidgets('given no rest, when the session opens, '
      'then no rest timer is shown', (tester) async {
    await pumpActive(tester);

    expect(_countdown, findsNothing);
  });

  testWidgets('given a pending set, when it is completed, '
      'then the exercise rest starts and its end is notified', (tester) async {
    final app = await pumpActive(tester);

    await _tap(tester, find.byTooltip(WorkoutStrings.completeSet).first);

    expect(app.workouts.sessions.single.restEndsAt, restEnd);
    expect(_countdownText(tester), '2:00');
    verify(() => app.restNotifier.schedule(restEnd)).called(1);
  });

  testWidgets('given a running rest, when +15 s and then −15 s are tapped, '
      'then the countdown and notification follow', (tester) async {
    final app = await pumpActive(tester);
    await _tap(tester, find.byTooltip(WorkoutStrings.completeSet).first);

    await _tap(tester, find.text(WorkoutStrings.restMore));
    final later = restEnd.add(const Duration(seconds: 15));
    expect(_countdownText(tester), '2:15');
    verify(() => app.restNotifier.schedule(later)).called(1);

    await _tap(tester, find.text(WorkoutStrings.restLess));
    expect(_countdownText(tester), '2:00');
    expect(app.workouts.sessions.single.restEndsAt, restEnd);
  });

  testWidgets('given a running rest, when skipped, '
      'then the timer hides and the notification is cancelled', (tester) async {
    final app = await pumpActive(tester);
    await _tap(tester, find.byTooltip(WorkoutStrings.completeSet).first);

    await _tap(tester, find.text(WorkoutStrings.skipRest));

    expect(_countdown, findsNothing);
    expect(app.workouts.sessions.single.restEndsAt, isNull);
    verify(app.restNotifier.cancel).called(1);
  });

  testWidgets('given a running rest, when the session is paused, '
      'then the rest ends', (tester) async {
    final app = await pumpActive(tester);
    await _tap(tester, find.byTooltip(WorkoutStrings.completeSet).first);

    await _tap(tester, find.byTooltip(WorkoutStrings.pause));

    expect(_countdown, findsNothing);
    verify(app.restNotifier.cancel).called(1);
  });

  testWidgets('given a rest running when the app was closed, '
      'when the session is resumed, then the countdown continues', (
    tester,
  ) async {
    final endsAt = testNow.add(const Duration(seconds: 45));
    final app = await pumpActive(tester, restEndsAt: endsAt);

    expect(_countdownText(tester), '0:45');
    verify(() => app.restNotifier.schedule(endsAt)).called(1);
  });

  testWidgets('given a rest that ended while the app was closed, '
      'when the session is resumed, then no timer is shown', (tester) async {
    await pumpActive(
      tester,
      restEndsAt: testNow.subtract(const Duration(seconds: 5)),
    );

    expect(_countdown, findsNothing);
  });
}
