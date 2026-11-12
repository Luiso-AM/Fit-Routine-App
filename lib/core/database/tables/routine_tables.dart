// Drift check() constraints reference their own column getter by design.
// ignore_for_file: recursive_getters

import 'package:drift/drift.dart';

import '../../../features/routines/domain/enums/routine_template_type.dart';
import 'exercises_table.dart';
import 'table_mixins.dart';

@DataClassName('RoutineRow')
class Routines extends Table with EntityColumns, SoftDeleteColumn {
  TextColumn get name => text()();

  TextColumn get notes => text().withDefault(const Constant(''))();

  /// `null` means a custom routine.
  TextColumn get templateType => textEnum<RoutineTemplateType>().nullable()();
}

@DataClassName('RoutineDayRow')
@TableIndex(name: 'idx_routine_days_routine', columns: {#routineId})
class RoutineDays extends Table with EntityColumns {
  TextColumn get routineId =>
      text().references(Routines, #id, onDelete: KeyAction.cascade)();

  TextColumn get name => text()();

  IntColumn get position => integer()();

  /// ISO weekday, 1 = Monday ... 7 = Sunday (same as [DateTime.weekday]).
  IntColumn get weekday =>
      integer().nullable().check(weekday.isBetweenValues(1, 7))();
}

@DataClassName('RoutineExerciseRow')
@TableIndex(name: 'idx_routine_exercises_day', columns: {#routineDayId})
class RoutineExercises extends Table with EntityColumns {
  TextColumn get routineDayId =>
      text().references(RoutineDays, #id, onDelete: KeyAction.cascade)();

  /// Exercises are soft-deleted, so this reference never cascades.
  TextColumn get exerciseId => text().references(Exercises, #id)();

  IntColumn get position => integer()();

  IntColumn get targetSets =>
      integer().check(targetSets.isBiggerThanValue(0))();

  IntColumn get targetRepsMin =>
      integer().check(targetRepsMin.isBiggerThanValue(0))();

  IntColumn get targetRepsMax =>
      integer().check(targetRepsMax.isBiggerOrEqual(targetRepsMin))();

  RealColumn get initialWeightKg => real().nullable()();

  IntColumn get restSeconds =>
      integer().check(restSeconds.isBiggerOrEqualValue(0))();

  TextColumn get notes => text().withDefault(const Constant(''))();
}
