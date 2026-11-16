import 'dart:ui';

import 'package:app_entrenamiento/app/app.dart';
import 'package:app_entrenamiento/app/router.dart';
import 'package:app_entrenamiento/features/exercises/data/exercise_data_providers.dart';
import 'package:app_entrenamiento/features/exercises/domain/exercise.dart';
import 'package:app_entrenamiento/features/profile/data/profile_data_providers.dart';
import 'package:app_entrenamiento/features/profile/domain/body_measurement.dart';
import 'package:app_entrenamiento/features/profile/domain/body_weight_entry.dart';
import 'package:app_entrenamiento/features/profile/domain/user_profile.dart';
import 'package:app_entrenamiento/features/routines/data/routine_data_providers.dart';
import 'package:app_entrenamiento/core/widgets/keep_screen_on.dart';
import 'package:app_entrenamiento/features/routines/domain/routine.dart';
import 'package:app_entrenamiento/features/workout/data/workout_data_providers.dart';
import 'package:app_entrenamiento/features/workout/domain/workout_session.dart';
import 'package:app_entrenamiento/features/workout/presentation/workout_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'fake_body_metrics_repository.dart';
import 'fake_exercise_repository.dart';
import 'fake_profile_repository.dart';
import 'fake_routine_repository.dart';
import 'fake_screen_wake_lock.dart';
import 'fake_workout_repository.dart';
import 'mock_rest_notifier.dart';

/// Fixed "now" of pumped apps: the clock never ticks in widget tests.
final DateTime testNow = DateTime.utc(2026, 11, 14, 10);

/// The fakes behind a pumped app, to inspect what the UI wrote.
typedef PumpedApp = ({
  ProviderContainer container,
  FakeProfileRepository profile,
  FakeBodyMetricsRepository bodyMetrics,
  FakeRoutineRepository routines,
  FakeWorkoutRepository workouts,
  FakeScreenWakeLock wakeLock,
  MockRestNotifier restNotifier,
});

/// Pumps the whole app on a phone-sized screen (360x780 dp) with in-memory
/// fakes, and opens [location].
///
/// The user has [profile] ([testProfile] by default); pass `null` to start
/// before onboarding.
Future<PumpedApp> pumpApp(
  WidgetTester tester, {
  String? location,
  List<Exercise> exercises = const [],
  UserProfile? profile = testProfile,
  List<BodyWeightEntry> weights = const [],
  List<BodyMeasurement> measurements = const [],
  List<Routine> routines = const [],
  List<WorkoutSession> sessions = const [],
}) async {
  tester.view
    ..physicalSize = const Size(1080, 2340)
    ..devicePixelRatio = 3;
  addTearDown(tester.view.reset);

  final bodyMetrics = FakeBodyMetricsRepository(
    weights: weights,
    measurements: measurements,
  );
  final profileRepository = FakeProfileRepository(
    profile: profile,
    bodyMetrics: bodyMetrics,
  );
  final routineRepository = FakeRoutineRepository(
    routines: routines,
    exercises: exercises,
  );
  final workoutRepository = FakeWorkoutRepository(
    sessions: sessions,
    routines: routineRepository,
    clock: () => testNow,
  );
  final wakeLock = FakeScreenWakeLock();
  registerFallbackValue(testNow);
  final restNotifier = MockRestNotifier();
  final container = ProviderContainer(
    overrides: [
      exerciseRepositoryProvider.overrideWithValue(
        FakeExerciseRepository(exercises),
      ),
      profileRepositoryProvider.overrideWithValue(profileRepository),
      bodyMetricsRepositoryProvider.overrideWithValue(bodyMetrics),
      routineRepositoryProvider.overrideWithValue(routineRepository),
      workoutRepositoryProvider.overrideWithValue(workoutRepository),
      screenWakeLockProvider.overrideWithValue(wakeLock),
      restNotificationsProvider.overrideWithValue(restNotifier),
      clockProvider.overrideWith((ref) => Stream.value(testNow)),
    ],
  );
  addTearDown(container.dispose);

  await tester.pumpWidget(
    UncontrolledProviderScope(container: container, child: const App()),
  );
  await tester.pumpAndSettle();
  if (location != null) {
    container.read(routerProvider).go(location);
    await tester.pumpAndSettle();
  }
  return (
    container: container,
    profile: profileRepository,
    bodyMetrics: bodyMetrics,
    routines: routineRepository,
    workouts: workoutRepository,
    wakeLock: wakeLock,
    restNotifier: restNotifier,
  );
}
