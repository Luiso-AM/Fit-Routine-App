import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/tables/exercises_table.dart';
import '../../../core/database/tables/routine_tables.dart';
import '../../exercises/domain/enums/exercise_type.dart';

part 'routines_dao.g.dart';

@DriftAccessor(tables: [Routines, RoutineDays, RoutineExercises, Exercises])
class RoutinesDao extends DatabaseAccessor<AppDatabase>
    with _$RoutinesDaoMixin {
  RoutinesDao(super.attachedDatabase);

  /// Emits once on listen and again whenever a routine table changes.
  Stream<void> watchChanges() async* {
    yield null;
    yield* attachedDatabase.tableUpdates(
      TableUpdateQuery.onAllTables([routines, routineDays, routineExercises]),
    );
  }

  // Routines.

  Future<List<RoutineRow>> getActiveRoutines() =>
      (select(routines)
            ..where((r) => r.deletedAt.isNull())
            ..orderBy([(r) => OrderingTerm.asc(r.createdAt)]))
          .get();

  Future<RoutineRow?> getActiveRoutine(String id) => (select(
    routines,
  )..where((r) => r.id.equals(id) & r.deletedAt.isNull())).getSingleOrNull();

  Future<RoutineRow> insertRoutine(RoutinesCompanion row) =>
      into(routines).insertReturning(row);

  Future<void> updateRoutine(String id, RoutinesCompanion changes) =>
      (update(routines)..where((r) => r.id.equals(id))).write(changes);

  // Days.

  Future<List<RoutineDayRow>> getDays(Iterable<String> routineIds) =>
      (select(routineDays)
            ..where((d) => d.routineId.isIn(routineIds))
            ..orderBy([(d) => OrderingTerm.asc(d.position)]))
          .get();

  /// A day whose routine is active.
  Future<RoutineDayRow?> getActiveDay(String id) async {
    final query = select(routineDays).join([
      innerJoin(routines, routines.id.equalsExp(routineDays.routineId)),
    ])..where(routineDays.id.equals(id) & routines.deletedAt.isNull());
    return (await query.getSingleOrNull())?.readTable(routineDays);
  }

  Future<RoutineDayRow> insertDay(RoutineDaysCompanion row) =>
      into(routineDays).insertReturning(row);

  Future<void> updateDay(String id, RoutineDaysCompanion changes) =>
      (update(routineDays)..where((d) => d.id.equals(id))).write(changes);

  Future<void> deleteDay(String id) =>
      (delete(routineDays)..where((d) => d.id.equals(id))).go();

  // Routine exercises.

  Future<List<RoutineExerciseRow>> getExercises(Iterable<String> dayIds) =>
      (select(routineExercises)
            ..where((e) => e.routineDayId.isIn(dayIds))
            ..orderBy([(e) => OrderingTerm.asc(e.position)]))
          .get();

  /// A routine exercise whose routine is active.
  Future<RoutineExerciseRow?> getActiveExercise(String id) async {
    final query = select(routineExercises).join([
      innerJoin(
        routineDays,
        routineDays.id.equalsExp(routineExercises.routineDayId),
      ),
      innerJoin(routines, routines.id.equalsExp(routineDays.routineId)),
    ])..where(routineExercises.id.equals(id) & routines.deletedAt.isNull());
    return (await query.getSingleOrNull())?.readTable(routineExercises);
  }

  Future<void> insertExercise(RoutineExercisesCompanion row) =>
      into(routineExercises).insert(row);

  Future<void> updateExercise(String id, RoutineExercisesCompanion changes) =>
      (update(routineExercises)..where((e) => e.id.equals(id))).write(changes);

  Future<void> deleteExercise(String id) =>
      (delete(routineExercises)..where((e) => e.id.equals(id))).go();

  /// Types of the given exercises, by id. Missing ids are left out.
  Future<Map<String, ExerciseType>> getExerciseTypes(
    Iterable<String> ids,
  ) async {
    final rows = await (select(exercises)..where((e) => e.id.isIn(ids))).get();
    return {for (final row in rows) row.id: row.type};
  }
}
