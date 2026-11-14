import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/tables/table_mixins.dart';
import '../../exercises/domain/enums/exercise_type.dart';
import '../../exercises/domain/exercise.dart';
import '../domain/routine.dart';
import '../domain/routine_drafts.dart';
import '../domain/routine_repository.dart';
import '../domain/routine_template.dart';
import 'routine_mapper.dart';
import 'routines_dao.dart';

class DriftRoutineRepository implements RoutineRepository {
  DriftRoutineRepository(AppDatabase db) : _db = db, _dao = RoutinesDao(db);

  final AppDatabase _db;
  final RoutinesDao _dao;

  @override
  Stream<List<Routine>> watchAll() =>
      _dao.watchChanges().asyncMap((_) => _loadAll());

  @override
  Stream<Routine?> watchById(String id) =>
      _dao.watchChanges().asyncMap((_) => _load(id)).distinct();

  Future<List<Routine>> _loadAll() async =>
      _assemble(await _dao.getActiveRoutines());

  Future<Routine?> _load(String id) async {
    final row = await _dao.getActiveRoutine(id);
    return row == null ? null : (await _assemble([row])).single;
  }

  Future<List<Routine>> _assemble(List<RoutineRow> rows) async {
    final days = await _dao.getDays([for (final r in rows) r.id]);
    final exercises = await _dao.getExercises([for (final d in days) d.id]);

    final exercisesByDay = <String, List<RoutineExercise>>{};
    for (final row in exercises) {
      exercisesByDay
          .putIfAbsent(row.routineDayId, () => [])
          .add(row.toDomain());
    }
    final daysByRoutine = <String, List<RoutineDay>>{};
    for (final day in days) {
      daysByRoutine
          .putIfAbsent(day.routineId, () => [])
          .add(day.toDomain(exercisesByDay[day.id] ?? const []));
    }
    return [
      for (final row in rows) row.toDomain(daysByRoutine[row.id] ?? const []),
    ];
  }

  @override
  Future<Routine> create(RoutineDraft draft) async {
    _validateRoutine(draft);
    final row = await _dao.insertRoutine(draft.toCompanion());
    return row.toDomain(const []);
  }

  @override
  Future<Routine> createFromTemplate(RoutineTemplate template) {
    return _db.transaction(() async {
      final routine = await _dao.insertRoutine(
        RoutinesCompanion.insert(
          name: template.name,
          templateType: Value(template.type),
        ),
      );
      final types = await _dao.getExerciseTypes(
        template.days.expand((d) => d.exerciseIds),
      );
      for (final (position, day) in template.days.indexed) {
        final dayRow = await _dao.insertDay(
          RoutineDaysCompanion.insert(
            routineId: routine.id,
            name: day.name,
            position: position,
          ),
        );
        var exercisePosition = 0;
        for (final exerciseId in day.exerciseIds) {
          // Seed exercises always exist; skip defensively if one does not.
          final type = types[exerciseId];
          if (type == null) continue;
          await _insertExercise(
            dayRow.id,
            exerciseId,
            type,
            exercisePosition++,
          );
        }
      }
      return (await _load(routine.id))!;
    });
  }

  @override
  Future<void> update(String id, RoutineDraft draft) async {
    _validateRoutine(draft);
    await _requireRoutine(id);
    await _dao.updateRoutine(
      id,
      draft.toCompanion().copyWith(updatedAt: Value(nowUtc())),
    );
  }

  @override
  Future<Routine> duplicate(String id, {required String name}) {
    return _db.transaction(() async {
      final source = await _load(id);
      if (source == null) throw RoutineNotFoundException(id);
      final draft = RoutineDraft(name: name, notes: source.notes);
      _validateRoutine(draft);

      final copy = await _dao.insertRoutine(
        draft.toCompanion().copyWith(templateType: Value(source.templateType)),
      );
      for (final day in source.days) {
        final dayCopy = await _dao.insertDay(
          RoutineDaysCompanion.insert(
            routineId: copy.id,
            name: day.name,
            position: day.position,
            weekday: Value(day.weekday),
          ),
        );
        for (final e in day.exercises) {
          await _dao.insertExercise(
            RoutineExercisesCompanion.insert(
              routineDayId: dayCopy.id,
              exerciseId: e.exerciseId,
              position: e.position,
              targetSets: e.targetSets,
              targetRepsMin: e.targetRepsMin,
              targetRepsMax: e.targetRepsMax,
              initialWeightKg: Value(e.initialWeightKg),
              restSeconds: e.restSeconds,
              notes: Value(e.notes),
            ),
          );
        }
      }
      return (await _load(copy.id))!;
    });
  }

  @override
  Future<void> softDelete(String id) async {
    await _requireRoutine(id);
    final now = nowUtc();
    await _dao.updateRoutine(
      id,
      RoutinesCompanion(deletedAt: Value(now), updatedAt: Value(now)),
    );
  }

  @override
  Future<RoutineDay> addDay(String routineId, RoutineDayDraft draft) {
    _validateDay(draft);
    return _db.transaction(() async {
      await _requireRoutine(routineId);
      final count = (await _dao.getDays([routineId])).length;
      final row = await _dao.insertDay(
        draft.toCompanion().copyWith(
          routineId: Value(routineId),
          position: Value(count),
        ),
      );
      return row.toDomain(const []);
    });
  }

  @override
  Future<void> updateDay(String dayId, RoutineDayDraft draft) async {
    _validateDay(draft);
    await _requireDay(dayId);
    await _dao.updateDay(
      dayId,
      draft.toCompanion().copyWith(updatedAt: Value(nowUtc())),
    );
  }

  @override
  Future<void> deleteDay(String dayId) {
    return _db.transaction(() async {
      final day = await _requireDay(dayId);
      await _dao.deleteDay(dayId);
      final remaining = await _dao.getDays([day.routineId]);
      await _writeDayPositions([for (final d in remaining) d.id]);
    });
  }

  @override
  Future<void> reorderDays(String routineId, List<String> orderedDayIds) {
    return _db.transaction(() async {
      await _requireRoutine(routineId);
      final current = await _dao.getDays([routineId]);
      _requireSameIds(current.map((d) => d.id), orderedDayIds);
      await _writeDayPositions(orderedDayIds);
    });
  }

  @override
  Future<void> addExercises(String dayId, List<Exercise> exercises) {
    return _db.transaction(() async {
      await _requireDay(dayId);
      var position = (await _dao.getExercises([dayId])).length;
      for (final exercise in exercises) {
        await _insertExercise(dayId, exercise.id, exercise.type, position++);
      }
    });
  }

  @override
  Future<void> updateExercise(
    String routineExerciseId,
    RoutineExerciseDraft draft,
  ) async {
    final errors = draft.validate();
    if (errors.isNotEmpty) throw RoutineExerciseValidationException(errors);
    await _requireExercise(routineExerciseId);
    await _dao.updateExercise(
      routineExerciseId,
      draft.toCompanion().copyWith(updatedAt: Value(nowUtc())),
    );
  }

  @override
  Future<void> removeExercise(String routineExerciseId) {
    return _db.transaction(() async {
      final row = await _requireExercise(routineExerciseId);
      await _dao.deleteExercise(routineExerciseId);
      final remaining = await _dao.getExercises([row.routineDayId]);
      await _writeExercisePositions([for (final e in remaining) e.id]);
    });
  }

  @override
  Future<void> reorderExercises(String dayId, List<String> orderedIds) {
    return _db.transaction(() async {
      await _requireDay(dayId);
      final current = await _dao.getExercises([dayId]);
      _requireSameIds(current.map((e) => e.id), orderedIds);
      await _writeExercisePositions(orderedIds);
    });
  }

  Future<void> _insertExercise(
    String dayId,
    String exerciseId,
    ExerciseType type,
    int position,
  ) => _dao.insertExercise(
    RoutineExerciseDraft.defaultsFor(type).toCompanion().copyWith(
      routineDayId: Value(dayId),
      exerciseId: Value(exerciseId),
      position: Value(position),
    ),
  );

  Future<void> _writeDayPositions(List<String> ids) async {
    final now = nowUtc();
    for (final (position, id) in ids.indexed) {
      await _dao.updateDay(
        id,
        RoutineDaysCompanion(position: Value(position), updatedAt: Value(now)),
      );
    }
  }

  Future<void> _writeExercisePositions(List<String> ids) async {
    final now = nowUtc();
    for (final (position, id) in ids.indexed) {
      await _dao.updateExercise(
        id,
        RoutineExercisesCompanion(
          position: Value(position),
          updatedAt: Value(now),
        ),
      );
    }
  }

  static void _requireSameIds(Iterable<String> current, List<String> ordered) {
    final expected = current.toSet();
    if (ordered.length != expected.length || !expected.containsAll(ordered)) {
      throw ArgumentError.value(
        ordered,
        'ordered',
        'must list every item once',
      );
    }
  }

  Future<RoutineRow> _requireRoutine(String id) async =>
      await _dao.getActiveRoutine(id) ?? (throw RoutineNotFoundException(id));

  Future<RoutineDayRow> _requireDay(String id) async =>
      await _dao.getActiveDay(id) ?? (throw RoutineNotFoundException(id));

  Future<RoutineExerciseRow> _requireExercise(String id) async =>
      await _dao.getActiveExercise(id) ?? (throw RoutineNotFoundException(id));

  static void _validateRoutine(RoutineDraft draft) {
    final errors = draft.validate();
    if (errors.isNotEmpty) throw RoutineValidationException(errors);
  }

  static void _validateDay(RoutineDayDraft draft) {
    final errors = draft.validate();
    if (errors.isNotEmpty) throw RoutineDayValidationException(errors);
  }
}
