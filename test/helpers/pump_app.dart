import 'dart:ui';

import 'package:app_entrenamiento/app/app.dart';
import 'package:app_entrenamiento/app/router.dart';
import 'package:app_entrenamiento/features/exercises/data/exercise_data_providers.dart';
import 'package:app_entrenamiento/features/exercises/domain/exercise.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'fake_exercise_repository.dart';

/// Pumps the whole app on a phone-sized screen (360x780 dp) with in-memory
/// fakes, and opens [location].
Future<ProviderContainer> pumpApp(
  WidgetTester tester, {
  String? location,
  List<Exercise> exercises = const [],
}) async {
  tester.view
    ..physicalSize = const Size(1080, 2340)
    ..devicePixelRatio = 3;
  addTearDown(tester.view.reset);

  final container = ProviderContainer(
    overrides: [
      exerciseRepositoryProvider.overrideWithValue(
        FakeExerciseRepository(exercises),
      ),
    ],
  );
  addTearDown(container.dispose);

  await tester.pumpWidget(
    UncontrolledProviderScope(container: container, child: const App()),
  );
  if (location != null) container.read(routerProvider).go(location);
  await tester.pumpAndSettle();
  return container;
}
