import '../../../core/units/weight_unit.dart';
import 'exercise.dart';
import 'exercise_draft.dart';

abstract interface class ExerciseRepository {
  /// Active (not soft-deleted) exercises, re-emitted on every change.
  Stream<List<Exercise>> watchAll();

  /// An active exercise, or `null` if it does not exist or was deleted.
  Stream<Exercise?> watchById(String id);

  Future<Exercise?> getById(String id);

  /// Creates a custom exercise.
  ///
  /// Throws [ExerciseValidationException] if the draft is invalid.
  Future<Exercise> create(ExerciseDraft draft);

  /// Updates a custom exercise.
  ///
  /// Throws [ExerciseNotFoundException], [ExerciseNotEditableException] for
  /// seed exercises, or [ExerciseValidationException].
  Future<void> update(String id, ExerciseDraft draft);

  /// Soft-deletes a custom exercise so history that references it survives.
  ///
  /// Throws [ExerciseNotFoundException] or [ExerciseNotEditableException].
  Future<void> softDelete(String id);

  /// Allowed for every exercise, including seed ones.
  Future<void> setPreferredUnit(String id, WeightUnit unit);
}

class ExerciseNotFoundException implements Exception {
  const ExerciseNotFoundException(this.id);

  final String id;

  @override
  String toString() => 'ExerciseNotFoundException: $id';
}

class ExerciseNotEditableException implements Exception {
  const ExerciseNotEditableException(this.id);

  final String id;

  @override
  String toString() => 'ExerciseNotEditableException: $id';
}

class ExerciseValidationException implements Exception {
  const ExerciseValidationException(this.errors);

  final Set<ExerciseValidationError> errors;

  @override
  String toString() => 'ExerciseValidationException: $errors';
}
