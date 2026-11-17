import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/tables/routine_tables.dart';
import '../../../core/database/tables/workout_tables.dart';
import '../domain/enums/session_status.dart';

part 'workouts_dao.g.dart';

@DriftAccessor(
  tables: [
    WorkoutSessions,
    SessionExercises,
    SetEntries,
    Routines,
    RoutineDays,
    RoutineExercises,
  ],
)
class WorkoutsDao extends DatabaseAccessor<AppDatabase>
    with _$WorkoutsDaoMixin {
  WorkoutsDao(super.attachedDatabase);

  /// Emits once on listen and again whenever a session or the routine it
  /// came from changes.
  Stream<void> watchChanges() async* {
    yield null;
    yield* attachedDatabase.tableUpdates(
      TableUpdateQuery.onAllTables([
        workoutSessions,
        sessionExercises,
        setEntries,
        routines,
        routineDays,
      ]),
    );
  }

  // Sessions.

  /// The latest real (not demo) session in progress.
  Future<WorkoutSessionRow?> getActiveSession() =>
      (select(workoutSessions)
            ..where(
              (s) =>
                  s.status.equalsValue(SessionStatus.inProgress) &
                  s.isDemo.equals(false),
            )
            ..orderBy([(s) => OrderingTerm.desc(s.startedAt)])
            ..limit(1))
          .getSingleOrNull();

  Future<WorkoutSessionRow?> getSession(String id) => (select(
    workoutSessions,
  )..where((s) => s.id.equals(id))).getSingleOrNull();

  Future<WorkoutSessionRow> insertSession(WorkoutSessionsCompanion row) =>
      into(workoutSessions).insertReturning(row);

  Future<void> updateSession(String id, WorkoutSessionsCompanion changes) =>
      (update(workoutSessions)..where((s) => s.id.equals(id))).write(changes);

  /// Names of a routine day and its routine, even if the routine was
  /// soft-deleted. `(null, null)` if the day no longer exists.
  Future<(String?, String?)> getDayNames(String? dayId) async {
    if (dayId == null) return (null, null);
    final query = select(routineDays).join([
      innerJoin(routines, routines.id.equalsExp(routineDays.routineId)),
    ])..where(routineDays.id.equals(dayId));
    final row = await query.getSingleOrNull();
    if (row == null) return (null, null);
    return (row.readTable(routines).name, row.readTable(routineDays).name);
  }

  // Session exercises.

  Future<List<SessionExerciseRow>> getSessionExercises(String sessionId) =>
      (select(sessionExercises)
            ..where((e) => e.sessionId.equals(sessionId))
            ..orderBy([(e) => OrderingTerm.asc(e.position)]))
          .get();

  Future<SessionExerciseRow?> getSessionExercise(String id) => (select(
    sessionExercises,
  )..where((e) => e.id.equals(id))).getSingleOrNull();

  Future<int> nextExercisePosition(String sessionId) async {
    final max = sessionExercises.position.max();
    final query = selectOnly(sessionExercises)
      ..addColumns([max])
      ..where(sessionExercises.sessionId.equals(sessionId));
    final value = await query.map((row) => row.read(max)).getSingle();
    return value == null ? 0 : value + 1;
  }

  Future<SessionExerciseRow> insertSessionExercise(
    SessionExercisesCompanion row,
  ) => into(sessionExercises).insertReturning(row);

  Future<void> deleteSessionExercise(String id) =>
      (delete(sessionExercises)..where((e) => e.id.equals(id))).go();

  // Sets.

  /// Sets of the given session exercises, by set number.
  Future<List<SetEntryRow>> getSets(Iterable<String> sessionExerciseIds) =>
      (select(setEntries)
            ..where((s) => s.sessionExerciseId.isIn(sessionExerciseIds))
            ..orderBy([(s) => OrderingTerm.asc(s.setNumber)]))
          .get();

  Future<SetEntryRow?> getSet(String id) =>
      (select(setEntries)..where((s) => s.id.equals(id))).getSingleOrNull();

  Future<void> insertSet(SetEntriesCompanion row) =>
      into(setEntries).insert(row);

  Future<void> updateSet(String id, SetEntriesCompanion changes) =>
      (update(setEntries)..where((s) => s.id.equals(id))).write(changes);

  Future<void> deleteSet(String id) =>
      (delete(setEntries)..where((s) => s.id.equals(id))).go();

  // Routine days, to start a session from one.

  /// A day whose routine is active.
  Future<RoutineDayRow?> getActiveRoutineDay(String id) async {
    final query = select(routineDays).join([
      innerJoin(routines, routines.id.equalsExp(routineDays.routineId)),
    ])..where(routineDays.id.equals(id) & routines.deletedAt.isNull());
    return (await query.getSingleOrNull())?.readTable(routineDays);
  }

  Future<List<RoutineExerciseRow>> getRoutineExercises(String dayId) =>
      (select(routineExercises)
            ..where((e) => e.routineDayId.equals(dayId))
            ..orderBy([(e) => OrderingTerm.asc(e.position)]))
          .get();

  // History.

  /// The latest finished, real session where [exerciseId] has a completed
  /// set.
  Future<WorkoutSessionRow?> getLastSessionWith(String exerciseId) async {
    final query =
        select(workoutSessions).join([
            innerJoin(
              sessionExercises,
              sessionExercises.sessionId.equalsExp(workoutSessions.id),
            ),
            innerJoin(
              setEntries,
              setEntries.sessionExerciseId.equalsExp(sessionExercises.id),
            ),
          ])
          ..where(
            sessionExercises.exerciseId.equals(exerciseId) &
                setEntries.isCompleted.equals(true) &
                workoutSessions.status.equalsValue(SessionStatus.completed) &
                workoutSessions.isDemo.equals(false),
          )
          ..orderBy([OrderingTerm.desc(workoutSessions.startedAt)])
          ..limit(1);
    return (await query.getSingleOrNull())?.readTable(workoutSessions);
  }

  /// Completed sets of [exerciseId] in a session, in the order performed.
  Future<List<SetEntryRow>> getCompletedSets(
    String sessionId,
    String exerciseId,
  ) async {
    final query =
        select(setEntries).join([
            innerJoin(
              sessionExercises,
              sessionExercises.id.equalsExp(setEntries.sessionExerciseId),
            ),
          ])
          ..where(
            sessionExercises.sessionId.equals(sessionId) &
                sessionExercises.exerciseId.equals(exerciseId) &
                setEntries.isCompleted.equals(true),
          )
          ..orderBy([
            OrderingTerm.asc(sessionExercises.position),
            OrderingTerm.asc(setEntries.setNumber),
          ]);
    return [for (final row in await query.get()) row.readTable(setEntries)];
  }

  /// The latest finished, real session of [routineDayId] that started
  /// before [before].
  Future<WorkoutSessionRow?> getPreviousSessionOfDay(
    String routineDayId,
    DateTime before,
  ) =>
      (select(workoutSessions)
            ..where(
              (s) =>
                  s.routineDayId.equals(routineDayId) &
                  s.startedAt.isSmallerThanValue(before) &
                  s.status.equalsValue(SessionStatus.completed) &
                  s.isDemo.equals(false),
            )
            ..orderBy([(s) => OrderingTerm.desc(s.startedAt)])
            ..limit(1))
          .getSingleOrNull();

  /// Finished, real sessions that started in [from, to), oldest first.
  Future<List<WorkoutSessionRow>> getFinishedSessions(
    DateTime from,
    DateTime to,
  ) =>
      (select(workoutSessions)
            ..where(
              (s) =>
                  s.startedAt.isBiggerOrEqualValue(from) &
                  s.startedAt.isSmallerThanValue(to) &
                  s.status.equalsValue(SessionStatus.completed) &
                  s.isDemo.equals(false),
            )
            ..orderBy([(s) => OrderingTerm.asc(s.startedAt)]))
          .get();
}
