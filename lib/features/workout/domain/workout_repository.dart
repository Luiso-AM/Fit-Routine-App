import '../../exercises/domain/exercise.dart';
import 'exercise_performance.dart';
import 'set_values.dart';
import 'workout_session.dart';

abstract interface class WorkoutRepository {
  /// The session in progress, if any, with its exercises and sets.
  /// Re-emitted on every change.
  Stream<WorkoutSession?> watchActive();

  /// Starts a session with a copy of the day's exercises and targets.
  /// Sets are prefilled from the last time each exercise was done.
  ///
  /// Throws [ActiveSessionExistsException] if a session is in progress, or
  /// [WorkoutNotFoundException] if the day does not exist.
  Future<WorkoutSession> startFromRoutineDay(String routineDayId);

  /// Starts an empty session. Throws [ActiveSessionExistsException].
  Future<WorkoutSession> startFree();

  /// Appends [exercises] to a session, each with its default rest and sets
  /// prefilled from the last time it was done.
  ///
  /// Throws [WorkoutNotFoundException].
  Future<void> addExercises(String sessionId, List<Exercise> exercises);

  /// Removes an exercise and its sets. Throws [WorkoutNotFoundException].
  Future<void> removeExercise(String sessionExerciseId);

  /// Appends a set with the values of the exercise's last set.
  ///
  /// Throws [WorkoutNotFoundException].
  Future<void> addSet(String sessionExerciseId);

  /// Removes a set and renumbers the following ones.
  ///
  /// Throws [WorkoutNotFoundException].
  Future<void> removeSet(String setId);

  /// Throws [WorkoutNotFoundException] or [ArgumentError] if [values] are
  /// not valid.
  Future<void> updateSet(String setId, SetValues values);

  /// Marks a set as completed or pending. Completing a set prefills the
  /// next pending set with its weight and reps and, unless the session is
  /// paused, starts the rest timer with the exercise's rest. Marking it
  /// pending leaves the rest timer as it is.
  ///
  /// Throws [WorkoutNotFoundException].
  Future<void> setCompleted(String setId, {required bool completed});

  /// Moves the end of the running rest by [delta]. A rest that would be
  /// over by now ends. Does nothing if no rest is running.
  ///
  /// Throws [WorkoutNotFoundException] or [SessionNotInProgressException].
  Future<void> adjustRest(String sessionId, Duration delta);

  /// Ends the running rest, if any.
  ///
  /// Throws [WorkoutNotFoundException] or [SessionNotInProgressException].
  Future<void> skipRest(String sessionId);

  /// Pausing also ends the running rest, if any.
  ///
  /// Throws [WorkoutNotFoundException] or [SessionNotInProgressException].
  Future<void> pause(String sessionId);

  /// Throws [WorkoutNotFoundException] or [SessionNotInProgressException].
  Future<void> resume(String sessionId);

  /// Ends the session and keeps it in history. A running pause or rest
  /// ends too.
  ///
  /// Throws [WorkoutNotFoundException] or [SessionNotInProgressException].
  Future<void> finish(String sessionId);

  /// Ends the session and leaves it out of history and statistics. A
  /// running pause or rest ends too.
  ///
  /// Throws [WorkoutNotFoundException] or [SessionNotInProgressException].
  Future<void> discard(String sessionId);

  /// The most recent finished (not demo) session where each exercise had
  /// at least one completed set. Exercises never done are left out.
  Future<Map<String, ExercisePerformance>> lastPerformances(
    Iterable<String> exerciseIds,
  );
}

/// A session, session exercise, set or routine day that does not exist.
class WorkoutNotFoundException implements Exception {
  const WorkoutNotFoundException(this.id);

  final String id;

  @override
  String toString() => 'WorkoutNotFoundException: $id';
}

/// Only one session can be in progress at a time.
class ActiveSessionExistsException implements Exception {
  const ActiveSessionExistsException(this.sessionId);

  final String sessionId;

  @override
  String toString() => 'ActiveSessionExistsException: $sessionId';
}

class SessionNotInProgressException implements Exception {
  const SessionNotInProgressException(this.sessionId);

  final String sessionId;

  @override
  String toString() => 'SessionNotInProgressException: $sessionId';
}
