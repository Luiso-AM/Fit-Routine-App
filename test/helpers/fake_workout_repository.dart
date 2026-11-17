import 'package:app_entrenamiento/features/exercises/domain/exercise.dart';
import 'package:app_entrenamiento/features/routines/domain/routine.dart';
import 'package:app_entrenamiento/features/routines/domain/routine_drafts.dart';
import 'package:app_entrenamiento/features/workout/domain/enums/session_status.dart';
import 'package:app_entrenamiento/features/workout/domain/exercise_performance.dart';
import 'package:app_entrenamiento/features/workout/domain/rest_timer.dart';
import 'package:app_entrenamiento/features/workout/domain/set_prefill.dart';
import 'package:app_entrenamiento/features/workout/domain/set_values.dart';
import 'package:app_entrenamiento/features/workout/domain/workout_repository.dart';
import 'package:app_entrenamiento/features/workout/domain/workout_session.dart';

import 'fake_routine_repository.dart';
import 'watchable.dart';

/// In-memory [WorkoutRepository] for widget tests. Follows the same rules
/// as the Drift implementation. Routine days are read from [routines].
class FakeWorkoutRepository with Watchable implements WorkoutRepository {
  FakeWorkoutRepository({
    Iterable<WorkoutSession> sessions = const [],
    this.routines,
    DateTime Function()? clock,
  }) : _sessions = [...sessions],
       _now = clock ?? (() => DateTime.utc(2026, 11, 14, 10));

  final List<WorkoutSession> _sessions;
  final FakeRoutineRepository? routines;
  final DateTime Function() _now;
  int _nextId = 1;

  List<WorkoutSession> get sessions => List.unmodifiable(_sessions);

  String _id(String prefix) => '$prefix-${_nextId++}';

  WorkoutSession? get _active =>
      _sessions.where((s) => s.isInProgress && !s.isDemo).lastOrNull;

  @override
  Stream<WorkoutSession?> watchActive() => watchValue(() => _active);

  @override
  Stream<WorkoutSession?> watchSession(String sessionId) =>
      watchValue(() => _sessions.where((s) => s.id == sessionId).firstOrNull);

  @override
  Stream<List<WorkoutSession>> watchFinished({
    required DateTime from,
    required DateTime to,
  }) => watchValue(
    () => [
      for (final s in _sessions)
        if (s.status == SessionStatus.completed &&
            !s.isDemo &&
            !s.startedAt.isBefore(from) &&
            s.startedAt.isBefore(to))
          s,
    ]..sort((a, b) => a.startedAt.compareTo(b.startedAt)),
  );

  // Lookups and updates.

  int _sessionIndex(String id) {
    final index = _sessions.indexWhere((s) => s.id == id);
    if (index < 0) throw WorkoutNotFoundException(id);
    return index;
  }

  (int, int) _exerciseIndex(String id) {
    for (final (s, session) in _sessions.indexed) {
      final e = session.exercises.indexWhere((x) => x.id == id);
      if (e >= 0) return (s, e);
    }
    throw WorkoutNotFoundException(id);
  }

  (int, int, int) _setIndex(String id) {
    for (final (s, session) in _sessions.indexed) {
      for (final (e, exercise) in session.exercises.indexed) {
        final i = exercise.sets.indexWhere((x) => x.id == id);
        if (i >= 0) return (s, e, i);
      }
    }
    throw WorkoutNotFoundException(id);
  }

  void _replaceSets(int s, int e, List<SetEntry> sets) {
    final exercises = [..._sessions[s].exercises];
    exercises[e] = exercises[e].copyWith(sets: sets);
    _sessions[s] = _sessions[s].copyWith(exercises: exercises);
    notifyChanged();
  }

  List<SetEntry> _newSets(String sessionExerciseId, List<SetValues> values) => [
    for (final (i, v) in values.indexed)
      SetEntry(
        id: _id('set'),
        sessionExerciseId: sessionExerciseId,
        setNumber: i + 1,
        weightKg: v.weightKg,
        reps: v.reps,
        rir: v.rir,
      ),
  ];

  // Starting a session.

  void _requireNoActiveSession() {
    final active = _active;
    if (active != null) throw ActiveSessionExistsException(active.id);
  }

  RoutineDay _day(String id) {
    for (final routine in routines?.routines ?? const <Routine>[]) {
      final day = routine.dayById(id);
      if (day != null) return day;
    }
    throw WorkoutNotFoundException(id);
  }

  String? _routineName(String dayId) => routines?.routines
      .where((r) => r.dayById(dayId) != null)
      .firstOrNull
      ?.name;

  @override
  Future<WorkoutSession> startFromRoutineDay(String routineDayId) async {
    _requireNoActiveSession();
    final day = _day(routineDayId);
    final last = await lastPerformances([
      for (final e in day.exercises) e.exerciseId,
    ]);
    final sessionId = _id('session');
    final session = WorkoutSession(
      id: sessionId,
      routineDayId: day.id,
      routineName: _routineName(day.id),
      routineDayName: day.name,
      startedAt: _now(),
      exercises: [
        for (final (position, e) in day.exercises.indexed)
          () {
            final id = _id('entry');
            return SessionExercise(
              id: id,
              sessionId: sessionId,
              exerciseId: e.exerciseId,
              position: position,
              targetSets: e.targetSets,
              targetRepsMin: e.targetRepsMin,
              targetRepsMax: e.targetRepsMax,
              restSeconds: e.restSeconds,
              notes: e.notes,
              sets: _newSets(
                id,
                initialSetValues(
                  count: e.targetSets,
                  targetRepsMin: e.targetRepsMin,
                  initialWeightKg: e.initialWeightKg,
                  last: last[e.exerciseId],
                ),
              ),
            );
          }(),
      ],
    );
    _sessions.add(session);
    notifyChanged();
    return session;
  }

  @override
  Future<WorkoutSession> startFree() async {
    _requireNoActiveSession();
    final session = WorkoutSession(id: _id('session'), startedAt: _now());
    _sessions.add(session);
    notifyChanged();
    return session;
  }

  // Exercises.

  @override
  Future<void> addExercises(String sessionId, List<Exercise> exercises) async {
    final s = _sessionIndex(sessionId);
    final last = await lastPerformances([for (final e in exercises) e.id]);
    final current = _sessions[s].exercises;
    var position = current.isEmpty ? 0 : current.last.position + 1;
    final added = <SessionExercise>[];
    for (final exercise in exercises) {
      final defaults = RoutineExerciseDraft.defaultsFor(exercise.type);
      final previous = last[exercise.id];
      final id = _id('entry');
      added.add(
        SessionExercise(
          id: id,
          sessionId: sessionId,
          exerciseId: exercise.id,
          position: position++,
          restSeconds: defaults.restSeconds,
          sets: _newSets(
            id,
            initialSetValues(
              count: previous?.sets.length ?? defaults.targetSets!,
              targetRepsMin: previous == null ? defaults.targetRepsMin : null,
              last: previous,
            ),
          ),
        ),
      );
    }
    _sessions[s] = _sessions[s].copyWith(exercises: [...current, ...added]);
    notifyChanged();
  }

  @override
  Future<void> removeExercise(String sessionExerciseId) async {
    final (s, e) = _exerciseIndex(sessionExerciseId);
    _sessions[s] = _sessions[s].copyWith(
      exercises: [..._sessions[s].exercises]..removeAt(e),
    );
    notifyChanged();
  }

  // Sets.

  @override
  Future<void> addSet(String sessionExerciseId) async {
    final (s, e) = _exerciseIndex(sessionExerciseId);
    final sets = _sessions[s].exercises[e].sets;
    final values = valuesForNewSet(sets);
    _replaceSets(s, e, [
      ...sets,
      SetEntry(
        id: _id('set'),
        sessionExerciseId: sessionExerciseId,
        setNumber: sets.length + 1,
        weightKg: values.weightKg,
        reps: values.reps,
      ),
    ]);
  }

  @override
  Future<void> removeSet(String setId) async {
    final (s, e, i) = _setIndex(setId);
    final sets = [..._sessions[s].exercises[e].sets]..removeAt(i);
    _replaceSets(s, e, [
      for (final (n, set) in sets.indexed) set.copyWith(setNumber: n + 1),
    ]);
  }

  @override
  Future<void> updateSet(String setId, SetValues values) async {
    final errors = values.validate();
    if (errors.isNotEmpty) {
      throw ArgumentError.value(values, 'values', errors.join(', '));
    }
    final (s, e, i) = _setIndex(setId);
    final sets = [..._sessions[s].exercises[e].sets];
    sets[i] = sets[i].copyWith(
      weightKg: values.weightKg,
      reps: values.reps,
      rir: values.rir,
    );
    _replaceSets(s, e, sets);
  }

  @override
  Future<void> setCompleted(String setId, {required bool completed}) async {
    final (s, e, i) = _setIndex(setId);
    final sets = [..._sessions[s].exercises[e].sets];
    final set = sets[i] = sets[i].copyWith(
      isCompleted: completed,
      completedAt: completed ? _now() : null,
    );
    final session = _sessions[s];
    if (!session.isInProgress) return _replaceSets(s, e, sets);
    if (completed && !session.isPaused) {
      final endsAt = RestTimer.endAfter(
        session.exercises[e].restSeconds,
        _now(),
      );
      if (endsAt != null) _sessions[s] = session.copyWith(restEndsAt: endsAt);
    }
    if (completed) {
      final next = setToPrefillAfter(sets, set);
      if (next != null) {
        final n = sets.indexOf(next);
        sets[n] = next.copyWith(weightKg: set.weightKg, reps: set.reps);
      }
    }
    _replaceSets(s, e, sets);
  }

  // Session lifecycle.

  int _inProgressIndex(String id) {
    final index = _sessionIndex(id);
    if (!_sessions[index].isInProgress) {
      throw SessionNotInProgressException(id);
    }
    return index;
  }

  @override
  Future<void> adjustRest(String sessionId, Duration delta) async {
    final s = _inProgressIndex(sessionId);
    final endsAt = _sessions[s].restEndsAt;
    final now = _now();
    if (!RestTimer.isRunning(endsAt, now)) return;
    _sessions[s] = _sessions[s].copyWith(
      restEndsAt: RestTimer.adjust(endsAt!, delta, now),
    );
    notifyChanged();
  }

  @override
  Future<void> skipRest(String sessionId) async {
    final s = _inProgressIndex(sessionId);
    if (_sessions[s].restEndsAt == null) return;
    _sessions[s] = _sessions[s].copyWith(restEndsAt: null);
    notifyChanged();
  }

  @override
  Future<void> pause(String sessionId) async {
    final s = _inProgressIndex(sessionId);
    if (_sessions[s].isPaused) return;
    _sessions[s] = _sessions[s].copyWith(pausedAt: _now(), restEndsAt: null);
    notifyChanged();
  }

  @override
  Future<void> resume(String sessionId) async {
    final s = _inProgressIndex(sessionId);
    final session = _sessions[s];
    if (!session.isPaused) return;
    _sessions[s] = session.copyWith(
      pausedTotalSeconds: session.pausedSecondsUntil(_now()),
      pausedAt: null,
    );
    notifyChanged();
  }

  @override
  Future<void> finish(String sessionId) =>
      _end(sessionId, SessionStatus.completed);

  @override
  Future<void> discard(String sessionId) =>
      _end(sessionId, SessionStatus.discarded);

  Future<void> _end(String sessionId, SessionStatus status) async {
    final s = _inProgressIndex(sessionId);
    final session = _sessions[s];
    final now = _now();
    _sessions[s] = session.copyWith(
      status: status,
      endedAt: now,
      pausedTotalSeconds: session.pausedSecondsUntil(now),
      pausedAt: null,
      restEndsAt: null,
    );
    notifyChanged();
  }

  // History.

  @override
  Future<void> updateNotes(String sessionId, String notes) async {
    final s = _sessionIndex(sessionId);
    _sessions[s] = _sessions[s].copyWith(notes: notes);
    notifyChanged();
  }

  @override
  Future<void> removeFromHistory(String sessionId) async {
    final s = _sessionIndex(sessionId);
    if (_sessions[s].status != SessionStatus.completed) {
      throw SessionNotFinishedException(sessionId);
    }
    _sessions[s] = _sessions[s].copyWith(status: SessionStatus.discarded);
    notifyChanged();
  }

  @override
  Future<Map<String, ExercisePerformance>> lastPerformances(
    Iterable<String> exerciseIds,
  ) async {
    final finished = [
      for (final s in _sessions)
        if (s.status == SessionStatus.completed && !s.isDemo) s,
    ]..sort((a, b) => b.startedAt.compareTo(a.startedAt));
    final result = <String, ExercisePerformance>{};
    for (final exerciseId in exerciseIds.toSet()) {
      for (final session in finished) {
        final sets = [
          for (final e in session.exercises)
            if (e.exerciseId == exerciseId)
              ...e.sets.where((s) => s.isCompleted),
        ];
        if (sets.isEmpty) continue;
        result[exerciseId] = ExercisePerformance(
          sessionId: session.id,
          exerciseId: exerciseId,
          performedAt: session.startedAt,
          sets: sets,
        );
        break;
      }
    }
    return result;
  }

  @override
  Future<WorkoutSession?> previousSessionOf(WorkoutSession session) async {
    final dayId = session.routineDayId;
    if (dayId == null) return null;
    final earlier = [
      for (final s in _sessions)
        if (s.routineDayId == dayId &&
            s.status == SessionStatus.completed &&
            !s.isDemo &&
            s.startedAt.isBefore(session.startedAt))
          s,
    ]..sort((a, b) => b.startedAt.compareTo(a.startedAt));
    return earlier.firstOrNull;
  }
}
