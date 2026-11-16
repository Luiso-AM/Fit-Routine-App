import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/database/database_provider.dart';
import '../domain/rest_notifier.dart';
import '../domain/workout_repository.dart';
import 'drift_workout_repository.dart';
import 'local_rest_notifier.dart';

part 'workout_data_providers.g.dart';

/// Exposes the repository through its domain interface.
@Riverpod(keepAlive: true)
WorkoutRepository workoutRepository(Ref ref) =>
    DriftWorkoutRepository(ref.watch(appDatabaseProvider));

/// Notifies the end of a rest through its domain interface.
@Riverpod(keepAlive: true)
RestNotifier restNotifier(Ref ref) => LocalRestNotifier();
