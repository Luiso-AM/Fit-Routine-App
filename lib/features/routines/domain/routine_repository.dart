import '../../exercises/domain/exercise.dart';
import 'routine.dart';
import 'routine_drafts.dart';
import 'routine_template.dart';

abstract interface class RoutineRepository {
  /// Active (not soft-deleted) routines with their days and exercises,
  /// oldest first. Re-emitted on every change.
  Stream<List<Routine>> watchAll();

  /// An active routine, or `null` if it does not exist or was deleted.
  Stream<Routine?> watchById(String id);

  /// Creates an empty routine. Throws [RoutineValidationException].
  Future<Routine> create(RoutineDraft draft);

  /// Creates a routine with the template's days and exercises, each with
  /// the default targets for its type.
  Future<Routine> createFromTemplate(RoutineTemplate template);

  /// Throws [RoutineNotFoundException] or [RoutineValidationException].
  Future<void> update(String id, RoutineDraft draft);

  /// Copies a routine with all its days and exercises under [name].
  ///
  /// Throws [RoutineNotFoundException] or [RoutineValidationException].
  Future<Routine> duplicate(String id, {required String name});

  /// Soft-deletes a routine so sessions that used it keep their history.
  ///
  /// Throws [RoutineNotFoundException].
  Future<void> softDelete(String id);

  /// Adds a day at the end. Throws [RoutineNotFoundException] or
  /// [RoutineDayValidationException].
  Future<RoutineDay> addDay(String routineId, RoutineDayDraft draft);

  /// Throws [RoutineNotFoundException] or [RoutineDayValidationException].
  Future<void> updateDay(String dayId, RoutineDayDraft draft);

  /// Deletes a day and its exercises. Sessions that used it keep their
  /// history. Throws [RoutineNotFoundException].
  Future<void> deleteDay(String dayId);

  /// [orderedDayIds] must contain every day of the routine exactly once.
  ///
  /// Throws [RoutineNotFoundException] or [ArgumentError].
  Future<void> reorderDays(String routineId, List<String> orderedDayIds);

  /// Appends [exercises] to a day with the default targets for their type.
  ///
  /// Throws [RoutineNotFoundException].
  Future<void> addExercises(String dayId, List<Exercise> exercises);

  /// Throws [RoutineNotFoundException] or
  /// [RoutineExerciseValidationException].
  Future<void> updateExercise(
    String routineExerciseId,
    RoutineExerciseDraft draft,
  );

  /// Throws [RoutineNotFoundException].
  Future<void> removeExercise(String routineExerciseId);

  /// [orderedIds] must contain every exercise of the day exactly once.
  ///
  /// Throws [RoutineNotFoundException] or [ArgumentError].
  Future<void> reorderExercises(String dayId, List<String> orderedIds);
}

/// A routine, day or routine exercise that does not exist (or whose
/// routine was deleted).
class RoutineNotFoundException implements Exception {
  const RoutineNotFoundException(this.id);

  final String id;

  @override
  String toString() => 'RoutineNotFoundException: $id';
}

class RoutineValidationException implements Exception {
  const RoutineValidationException(this.errors);

  final Set<RoutineValidationError> errors;

  @override
  String toString() => 'RoutineValidationException: $errors';
}

class RoutineDayValidationException implements Exception {
  const RoutineDayValidationException(this.errors);

  final Set<RoutineDayValidationError> errors;

  @override
  String toString() => 'RoutineDayValidationException: $errors';
}

class RoutineExerciseValidationException implements Exception {
  const RoutineExerciseValidationException(this.errors);

  final Set<RoutineExerciseValidationError> errors;

  @override
  String toString() => 'RoutineExerciseValidationException: $errors';
}
