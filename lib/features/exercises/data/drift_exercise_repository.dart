import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/tables/table_mixins.dart';
import '../../../core/units/weight_unit.dart';
import '../domain/exercise.dart';
import '../domain/exercise_draft.dart';
import '../domain/exercise_repository.dart';
import 'exercise_mapper.dart';
import 'exercises_dao.dart';

class DriftExerciseRepository implements ExerciseRepository {
  DriftExerciseRepository(AppDatabase db) : _dao = ExercisesDao(db);

  final ExercisesDao _dao;

  @override
  Stream<List<Exercise>> watchAll() => _dao.watchActive().map(
    (rows) => [for (final row in rows) row.toDomain()],
  );

  @override
  Stream<Exercise?> watchById(String id) =>
      _dao.watchActiveById(id).map((row) => row?.toDomain());

  @override
  Future<Exercise?> getById(String id) async =>
      (await _dao.getActiveById(id))?.toDomain();

  @override
  Future<Exercise> create(ExerciseDraft draft) async {
    await _validate(draft);
    final row = await _dao.insertRow(
      draft.toCompanion().copyWith(isCustom: const Value(true)),
    );
    return row.toDomain();
  }

  @override
  Future<void> update(String id, ExerciseDraft draft) async {
    await _requireEditable(id);
    await _validate(draft, editingId: id);
    await _dao.updateById(
      id,
      draft.toCompanion().copyWith(updatedAt: Value(nowUtc())),
    );
  }

  @override
  Future<void> softDelete(String id) async {
    await _requireEditable(id);
    final now = nowUtc();
    await _dao.updateById(
      id,
      ExercisesCompanion(deletedAt: Value(now), updatedAt: Value(now)),
    );
  }

  @override
  Future<void> setPreferredUnit(String id, WeightUnit unit) async {
    if (await _dao.getActiveById(id) == null) {
      throw ExerciseNotFoundException(id);
    }
    await _dao.updateById(
      id,
      ExercisesCompanion(
        preferredUnit: Value(unit),
        updatedAt: Value(nowUtc()),
      ),
    );
  }

  Future<void> _requireEditable(String id) async {
    final row = await _dao.getActiveById(id);
    if (row == null) throw ExerciseNotFoundException(id);
    if (row.isSeed) throw ExerciseNotEditableException(id);
  }

  Future<void> _validate(ExerciseDraft draft, {String? editingId}) async {
    final existing = [for (final row in await _dao.getActive()) row.toDomain()];
    final errors = draft.validate(existing: existing, editingId: editingId);
    if (errors.isNotEmpty) throw ExerciseValidationException(errors);
  }
}
