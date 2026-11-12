import '../../../core/database/app_database.dart';
import '../domain/exercise.dart';
import 'exercise_mapper.dart';
import 'exercises_dao.dart';
import 'seed/seed_exercises.dart';

/// Inserts the base exercise library.
///
/// Idempotent: seeds are matched by their fixed id, so running it on every
/// app start only adds exercises that are missing and never overwrites the
/// user's changes (such as the preferred unit).
class ExerciseSeeder {
  ExerciseSeeder(AppDatabase db, {this.seeds = seedExercises})
    : _dao = ExercisesDao(db);

  final ExercisesDao _dao;

  /// Exercises to insert; defaults to the shipped library.
  final List<Exercise> seeds;

  Future<void> run() =>
      _dao.insertMissing([for (final seed in seeds) seed.toSeedCompanion()]);
}
