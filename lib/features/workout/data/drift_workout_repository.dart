import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/tables/table_mixins.dart';
import '../../exercises/domain/exercise.dart';
import '../../routines/domain/routine_drafts.dart';
import '../domain/enums/session_status.dart';
import '../domain/exercise_performance.dart';
import '../domain/set_prefill.dart';
import '../domain/set_values.dart';
import '../domain/workout_repository.dart';
import '../domain/workout_session.dart';
import 'workout_mapper.dart';
import 'workouts_dao.dart';

class DriftWorkoutRepository implements WorkoutRepository {
  /// [clock] returns the current UTC time; tests can pass a fixed one.
  DriftWorkoutRepository(AppDatabase db, {DateTime Function()? clock})
    : _db = db,
      _dao = WorkoutsDao(db),
      _now = clock ?? nowUtc;

  final AppDatabase _db;
  final WorkoutsDao _dao;
  final DateTime Function() _now;

  @override
  Stream<WorkoutSession?> watchActive() =>
      _dao.watchChanges().asyncMap((_) => _loadActive()).distinct();

  Future<WorkoutSession?> _loadActive() async {
    final row = await _dao.getActiveSession();
    return row == null ? null : _assemble(row);
  }

  Future<WorkoutSession> _assemble(WorkoutSessionRow row) async {
    final (routineName, dayName) = await _dao.getDayNames(row.routineDayId);
    final exercises = await _dao.getSessionExercises(row.id);
    final sets = await _dao.getSets([for (final e in exercises) e.id]);

    final setsByExercise = <String, List<SetEntry>>{};
    for (final set in sets) {
      setsByExercise
          .putIfAbsent(set.sessionExerciseId, () => [])
          .add(set.toDomain());
    }
    return row.toDomain(
      routineName: routineName,
      routineDayName: dayName,
      exercises: [
        for (final e in exercises) e.toDomain(setsByExercise[e.id] ?? const []),
      ],
    );
  }

  // Starting a session.

  @override
  Future<WorkoutSession> startFromRoutineDay(String routineDayId) {
    return _db.transaction(() async {
      await _requireNoActiveSession();
      final day = await _dao.getActiveRoutineDay(routineDayId);
      if (day == null) throw WorkoutNotFoundException(routineDayId);

      final planned = await _dao.getRoutineExercises(day.id);
      final last = await lastPerformances([
        for (final e in planned) e.exerciseId,
      ]);
      final session = await _insertSession(routineDayId: day.id);
      for (final (position, e) in planned.indexed) {
        final sessionExercise = await _dao.insertSessionExercise(
          SessionExercisesCompanion.insert(
            sessionId: session.id,
            exerciseId: e.exerciseId,
            position: position,
            targetSets: Value(e.targetSets),
            targetRepsMin: Value(e.targetRepsMin),
            targetRepsMax: Value(e.targetRepsMax),
            restSeconds: Value(e.restSeconds),
            notes: Value(e.notes),
          ),
        );
        await _insertSets(
          sessionExercise.id,
          initialSetValues(
            count: e.targetSets,
            targetRepsMin: e.targetRepsMin,
            initialWeightKg: e.initialWeightKg,
            last: last[e.exerciseId],
          ),
        );
      }
      return _assemble(session);
    });
  }

  @override
  Future<WorkoutSession> startFree() {
    return _db.transaction(() async {
      await _requireNoActiveSession();
      return _assemble(await _insertSession());
    });
  }

  Future<WorkoutSessionRow> _insertSession({String? routineDayId}) {
    final now = _now();
    return _dao.insertSession(
      WorkoutSessionsCompanion.insert(
        routineDayId: Value(routineDayId),
        startedAt: now,
        createdAt: Value(now),
        updatedAt: Value(now),
      ),
    );
  }

  Future<void> _requireNoActiveSession() async {
    final active = await _dao.getActiveSession();
    if (active != null) throw ActiveSessionExistsException(active.id);
  }

  // Exercises.

  @override
  Future<void> addExercises(String sessionId, List<Exercise> exercises) {
    return _db.transaction(() async {
      await _requireSession(sessionId);
      final last = await lastPerformances([for (final e in exercises) e.id]);
      var position = await _dao.nextExercisePosition(sessionId);
      for (final exercise in exercises) {
        final defaults = RoutineExerciseDraft.defaultsFor(exercise.type);
        final previous = last[exercise.id];
        final sessionExercise = await _dao.insertSessionExercise(
          SessionExercisesCompanion.insert(
            sessionId: sessionId,
            exerciseId: exercise.id,
            position: position++,
            restSeconds: Value(defaults.restSeconds),
          ),
        );
        // Without a plan, repeat what was done last time; without history,
        // start from the default sets and reps for the exercise type.
        await _insertSets(
          sessionExercise.id,
          initialSetValues(
            count: previous?.sets.length ?? defaults.targetSets!,
            targetRepsMin: previous == null ? defaults.targetRepsMin : null,
            last: previous,
          ),
        );
      }
    });
  }

  @override
  Future<void> removeExercise(String sessionExerciseId) async {
    await _requireSessionExercise(sessionExerciseId);
    await _dao.deleteSessionExercise(sessionExerciseId);
  }

  // Sets.

  @override
  Future<void> addSet(String sessionExerciseId) {
    return _db.transaction(() async {
      await _requireSessionExercise(sessionExerciseId);
      final sets = await _dao.getSets([sessionExerciseId]);
      final values = valuesForNewSet([for (final s in sets) s.toDomain()]);
      await _dao.insertSet(_newSet(sessionExerciseId, sets.length + 1, values));
    });
  }

  @override
  Future<void> removeSet(String setId) {
    return _db.transaction(() async {
      final removed = await _requireSet(setId);
      await _dao.deleteSet(setId);
      final now = _now();
      for (final set in await _dao.getSets([removed.sessionExerciseId])) {
        if (set.setNumber < removed.setNumber) continue;
        await _dao.updateSet(
          set.id,
          SetEntriesCompanion(
            setNumber: Value(set.setNumber - 1),
            updatedAt: Value(now),
          ),
        );
      }
    });
  }

  @override
  Future<void> updateSet(String setId, SetValues values) async {
    final errors = values.validate();
    if (errors.isNotEmpty) {
      throw ArgumentError.value(values, 'values', errors.join(', '));
    }
    await _requireSet(setId);
    await _dao.updateSet(
      setId,
      SetEntriesCompanion(
        weightKg: Value(values.weightKg),
        reps: Value(values.reps),
        rir: Value(values.rir),
        updatedAt: Value(_now()),
      ),
    );
  }

  @override
  Future<void> setCompleted(String setId, {required bool completed}) {
    return _db.transaction(() async {
      final row = await _requireSet(setId);
      final now = _now();
      await _dao.updateSet(
        setId,
        SetEntriesCompanion(
          isCompleted: Value(completed),
          completedAt: Value(completed ? now : null),
          updatedAt: Value(now),
        ),
      );
      if (!completed) return;

      final sets = [
        for (final s in await _dao.getSets([row.sessionExerciseId]))
          s.toDomain(),
      ];
      final next = setToPrefillAfter(sets, row.toDomain());
      if (next == null) return;
      await _dao.updateSet(
        next.id,
        SetEntriesCompanion(
          weightKg: Value(row.weightKg),
          reps: Value(row.reps),
          updatedAt: Value(now),
        ),
      );
    });
  }

  Future<void> _insertSets(String sessionExerciseId, List<SetValues> values) =>
      _dao.batch(
        (batch) => batch.insertAll(_dao.setEntries, [
          for (final (i, v) in values.indexed)
            _newSet(sessionExerciseId, i + 1, v),
        ]),
      );

  SetEntriesCompanion _newSet(
    String sessionExerciseId,
    int setNumber,
    SetValues values,
  ) {
    final now = _now();
    return SetEntriesCompanion.insert(
      sessionExerciseId: sessionExerciseId,
      setNumber: setNumber,
      weightKg: Value(values.weightKg),
      reps: Value(values.reps),
      rir: Value(values.rir),
      createdAt: Value(now),
      updatedAt: Value(now),
    );
  }

  // Session lifecycle.

  @override
  Future<void> pause(String sessionId) async {
    final session = await _requireInProgress(sessionId);
    if (session.isPaused) return;
    final now = _now();
    await _dao.updateSession(
      sessionId,
      WorkoutSessionsCompanion(pausedAt: Value(now), updatedAt: Value(now)),
    );
  }

  @override
  Future<void> resume(String sessionId) async {
    final session = await _requireInProgress(sessionId);
    if (!session.isPaused) return;
    final now = _now();
    await _dao.updateSession(
      sessionId,
      WorkoutSessionsCompanion(
        pausedTotalSeconds: Value(session.pausedSecondsUntil(now)),
        pausedAt: const Value(null),
        updatedAt: Value(now),
      ),
    );
  }

  @override
  Future<void> finish(String sessionId) =>
      _end(sessionId, SessionStatus.completed);

  @override
  Future<void> discard(String sessionId) =>
      _end(sessionId, SessionStatus.discarded);

  Future<void> _end(String sessionId, SessionStatus status) async {
    final session = await _requireInProgress(sessionId);
    final now = _now();
    await _dao.updateSession(
      sessionId,
      WorkoutSessionsCompanion(
        status: Value(status),
        endedAt: Value(now),
        pausedTotalSeconds: Value(session.pausedSecondsUntil(now)),
        pausedAt: const Value(null),
        updatedAt: Value(now),
      ),
    );
  }

  // History.

  @override
  Future<Map<String, ExercisePerformance>> lastPerformances(
    Iterable<String> exerciseIds,
  ) async {
    final result = <String, ExercisePerformance>{};
    for (final exerciseId in exerciseIds.toSet()) {
      final session = await _dao.getLastSessionWith(exerciseId);
      if (session == null) continue;
      final sets = await _dao.getCompletedSets(session.id, exerciseId);
      result[exerciseId] = ExercisePerformance(
        sessionId: session.id,
        exerciseId: exerciseId,
        performedAt: session.startedAt,
        sets: [for (final s in sets) s.toDomain()],
      );
    }
    return result;
  }

  // Lookups.

  Future<WorkoutSessionRow> _requireSession(String id) async {
    final row = await _dao.getSession(id);
    if (row == null) throw WorkoutNotFoundException(id);
    return row;
  }

  Future<WorkoutSession> _requireInProgress(String id) async {
    final session = (await _requireSession(id)).toDomain();
    if (!session.isInProgress) throw SessionNotInProgressException(id);
    return session;
  }

  Future<SessionExerciseRow> _requireSessionExercise(String id) async {
    final row = await _dao.getSessionExercise(id);
    if (row == null) throw WorkoutNotFoundException(id);
    return row;
  }

  Future<SetEntryRow> _requireSet(String id) async {
    final row = await _dao.getSet(id);
    if (row == null) throw WorkoutNotFoundException(id);
    return row;
  }
}
