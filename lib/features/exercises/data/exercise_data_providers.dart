import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/database/database_provider.dart';
import '../domain/exercise_repository.dart';
import 'drift_exercise_repository.dart';
import 'exercise_seeder.dart';

part 'exercise_data_providers.g.dart';

/// Exposes the repository through its domain interface.
@Riverpod(keepAlive: true)
ExerciseRepository exerciseRepository(Ref ref) =>
    DriftExerciseRepository(ref.watch(appDatabaseProvider));

@Riverpod(keepAlive: true)
ExerciseSeeder exerciseSeeder(Ref ref) =>
    ExerciseSeeder(ref.watch(appDatabaseProvider));
