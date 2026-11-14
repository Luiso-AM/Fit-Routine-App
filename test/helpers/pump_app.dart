import 'dart:ui';

import 'package:app_entrenamiento/app/app.dart';
import 'package:app_entrenamiento/app/router.dart';
import 'package:app_entrenamiento/features/exercises/data/exercise_data_providers.dart';
import 'package:app_entrenamiento/features/exercises/domain/exercise.dart';
import 'package:app_entrenamiento/features/profile/data/profile_data_providers.dart';
import 'package:app_entrenamiento/features/profile/domain/body_measurement.dart';
import 'package:app_entrenamiento/features/profile/domain/body_weight_entry.dart';
import 'package:app_entrenamiento/features/profile/domain/user_profile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'fake_body_metrics_repository.dart';
import 'fake_exercise_repository.dart';
import 'fake_profile_repository.dart';

/// The fakes behind a pumped app, to inspect what the UI wrote.
typedef PumpedApp = ({
  ProviderContainer container,
  FakeProfileRepository profile,
  FakeBodyMetricsRepository bodyMetrics,
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
  final container = ProviderContainer(
    overrides: [
      exerciseRepositoryProvider.overrideWithValue(
        FakeExerciseRepository(exercises),
      ),
      profileRepositoryProvider.overrideWithValue(profileRepository),
      bodyMetricsRepositoryProvider.overrideWithValue(bodyMetrics),
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
  );
}
