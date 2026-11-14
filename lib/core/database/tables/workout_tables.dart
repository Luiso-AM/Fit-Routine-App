// Drift check() constraints reference their own column getter by design.
// ignore_for_file: recursive_getters

import 'package:drift/drift.dart';

import '../../../features/workout/domain/enums/session_status.dart';
import 'exercises_table.dart';
import 'routine_tables.dart';
import 'table_mixins.dart';

@DataClassName('WorkoutSessionRow')
@TableIndex(name: 'idx_workout_sessions_status', columns: {#status})
@TableIndex(name: 'idx_workout_sessions_started_at', columns: {#startedAt})
@TableIndex(name: 'idx_workout_sessions_routine_day', columns: {#routineDayId})
class WorkoutSessions extends Table with EntityColumns {
  /// `null` for free sessions, or when the routine day was removed later.
  TextColumn get routineDayId => text().nullable().references(
    RoutineDays,
    #id,
    onDelete: KeyAction.setNull,
  )();

  DateTimeColumn get startedAt => dateTime()();

  DateTimeColumn get endedAt => dateTime().nullable()();

  IntColumn get pausedTotalSeconds => integer()
      .withDefault(const Constant(0))
      .check(pausedTotalSeconds.isBiggerOrEqualValue(0))();

  DateTimeColumn get pausedAt => dateTime().nullable()();

  TextColumn get status => textEnum<SessionStatus>().withDefault(
    Constant(SessionStatus.inProgress.name),
  )();

  TextColumn get notes => text().withDefault(const Constant(''))();

  /// Sample data created from the debug menu; excluded from stats.
  BoolColumn get isDemo => boolean().withDefault(const Constant(false))();
}

@DataClassName('SessionExerciseRow')
@TableIndex(name: 'idx_session_exercises_session', columns: {#sessionId})
@TableIndex(name: 'idx_session_exercises_exercise', columns: {#exerciseId})
class SessionExercises extends Table with EntityColumns {
  TextColumn get sessionId =>
      text().references(WorkoutSessions, #id, onDelete: KeyAction.cascade)();

  /// Exercises are soft-deleted, so this reference never cascades.
  TextColumn get exerciseId => text().references(Exercises, #id)();

  IntColumn get position => integer()();

  // Targets copied from the routine when the session starts, so editing the
  // routine later does not change history. `null` for exercises added
  // during the session or in free sessions.
  IntColumn get targetSets =>
      integer().nullable().check(targetSets.isBiggerThanValue(0))();

  IntColumn get targetRepsMin =>
      integer().nullable().check(targetRepsMin.isBiggerThanValue(0))();

  IntColumn get targetRepsMax => integer().nullable().check(
    targetRepsMax.isBiggerOrEqual(targetRepsMin),
  )();

  /// Rest after each completed set, used by the rest timer.
  IntColumn get restSeconds =>
      integer().nullable().check(restSeconds.isBiggerOrEqualValue(0))();

  TextColumn get notes => text().withDefault(const Constant(''))();
}

@DataClassName('SetEntryRow')
@TableIndex(
  name: 'idx_set_entries_session_exercise',
  columns: {#sessionExerciseId},
)
class SetEntries extends Table with EntityColumns {
  TextColumn get sessionExerciseId =>
      text().references(SessionExercises, #id, onDelete: KeyAction.cascade)();

  IntColumn get setNumber => integer().check(setNumber.isBiggerThanValue(0))();

  /// Always kg, never rounded.
  RealColumn get weightKg => real()
      .withDefault(const Constant(0))
      .check(weightKg.isBiggerOrEqualValue(0))();

  IntColumn get reps => integer()
      .withDefault(const Constant(0))
      .check(reps.isBiggerOrEqualValue(0))();

  /// Reps in reserve, optional.
  IntColumn get rir =>
      integer().nullable().check(rir.isBiggerOrEqualValue(0))();

  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();

  DateTimeColumn get completedAt => dateTime().nullable()();
}
