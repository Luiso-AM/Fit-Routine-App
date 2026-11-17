import '../../exercises/domain/exercise.dart';
import 'exercise_performance.dart';
import 'set_values.dart';
import 'workout_session.dart';

abstract interface class WorkoutRepository {
  /// The session in progress, if any, with its exercises and sets.
  /// Re-emitted on every change.
  Stream<WorkoutSession?> watchActive();

  /// A session of any status with its exercises and sets, or `null` if it
  /// does not exist. Re-emitted on every change.
  Stream<WorkoutSession?> watchSession(String sessionId);

  /// Finished (not demo) sessions that started from [from] (inclusive) to
  /// [to] (exclusive), oldest first, with their exercises and sets.
  /// Re-emitted on every change.
  Stream<List<WorkoutSession>> watchFinished({
    required DateTime from,
    required DateTime to,
  });

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

  /// Marks a set as completed or pending. In a session in progress,
  /// completing a set prefills the next pending set with its weight and
  /// reps and, unless the session is paused, starts the rest timer with the
  /// exercise's rest. Marking it pending leaves the rest timer as it is.
  /// In a finished session only the set changes.
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

  /// Replaces the session's notes. Throws [WorkoutNotFoundException].
  Future<void> updateNotes(String sessionId, String notes);

  /// Leaves a finished session out of history and statistics by marking it
  /// as discarded. Its data is kept.
  ///
  /// Throws [WorkoutNotFoundException] or [SessionNotFinishedException].
  Future<void> removeFromHistory(String sessionId);

  /// The most recent finished (not demo) session where each exercise had
  /// at least one completed set. Exercises never done are left out.
  Future<Map<String, ExercisePerformance>> lastPerformances(
    Iterable<String> exerciseIds,
  );

  /// The latest finished (not demo) session of the same routine day that
  /// started before [session]. `null` for free sessions, or if the day was
  /// not done before.
  Future<WorkoutSession?> previousSessionOf(WorkoutSession session);
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

class SessionNotFinishedException implements Exception {
  const SessionNotFinishedException(this.sessionId);

  final String sessionId;

  @override
  String toString() => 'SessionNotFinishedException: $sessionId';
}

class SessionNotInProgressException implements Exception {
  const SessionNotInProgressException(this.sessionId);

  final String sessionId;

  @override
  String toString() => 'SessionNotInProgressException: $sessionId';
}
