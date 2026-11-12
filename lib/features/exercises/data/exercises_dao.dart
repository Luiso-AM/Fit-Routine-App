import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/tables/exercises_table.dart';

part 'exercises_dao.g.dart';

@DriftAccessor(tables: [Exercises])
class ExercisesDao extends DatabaseAccessor<AppDatabase>
    with _$ExercisesDaoMixin {
  ExercisesDao(super.attachedDatabase);

  SimpleSelectStatement<$ExercisesTable, ExerciseRow> _active() =>
      select(exercises)..where((e) => e.deletedAt.isNull());

  Stream<List<ExerciseRow>> watchActive() => _active().watch();

  Future<List<ExerciseRow>> getActive() => _active().get();

  Stream<ExerciseRow?> watchActiveById(String id) =>
      (_active()..where((e) => e.id.equals(id))).watchSingleOrNull();

  Future<ExerciseRow?> getActiveById(String id) =>
      (_active()..where((e) => e.id.equals(id))).getSingleOrNull();

  Future<ExerciseRow> insertRow(ExercisesCompanion row) =>
      into(exercises).insertReturning(row);

  Future<void> updateById(String id, ExercisesCompanion changes) =>
      (update(exercises)..where((e) => e.id.equals(id))).write(changes);

  /// Inserts rows whose id does not exist yet; existing rows are untouched.
  Future<void> insertMissing(List<ExercisesCompanion> rows) => batch(
    (b) => b.insertAll(exercises, rows, mode: InsertMode.insertOrIgnore),
  );
}
