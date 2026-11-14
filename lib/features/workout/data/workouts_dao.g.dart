// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workouts_dao.dart';

// ignore_for_file: type=lint
mixin _$WorkoutsDaoMixin on DatabaseAccessor<AppDatabase> {
  $RoutinesTable get routines => attachedDatabase.routines;
  $RoutineDaysTable get routineDays => attachedDatabase.routineDays;
  $WorkoutSessionsTable get workoutSessions => attachedDatabase.workoutSessions;
  $ExercisesTable get exercises => attachedDatabase.exercises;
  $SessionExercisesTable get sessionExercises =>
      attachedDatabase.sessionExercises;
  $SetEntriesTable get setEntries => attachedDatabase.setEntries;
  $RoutineExercisesTable get routineExercises =>
      attachedDatabase.routineExercises;
  WorkoutsDaoManager get managers => WorkoutsDaoManager(this);
}

class WorkoutsDaoManager {
  final _$WorkoutsDaoMixin _db;
  WorkoutsDaoManager(this._db);
  $$RoutinesTableTableManager get routines =>
      $$RoutinesTableTableManager(_db.attachedDatabase, _db.routines);
  $$RoutineDaysTableTableManager get routineDays =>
      $$RoutineDaysTableTableManager(_db.attachedDatabase, _db.routineDays);
  $$WorkoutSessionsTableTableManager get workoutSessions =>
      $$WorkoutSessionsTableTableManager(
        _db.attachedDatabase,
        _db.workoutSessions,
      );
  $$ExercisesTableTableManager get exercises =>
      $$ExercisesTableTableManager(_db.attachedDatabase, _db.exercises);
  $$SessionExercisesTableTableManager get sessionExercises =>
      $$SessionExercisesTableTableManager(
        _db.attachedDatabase,
        _db.sessionExercises,
      );
  $$SetEntriesTableTableManager get setEntries =>
      $$SetEntriesTableTableManager(_db.attachedDatabase, _db.setEntries);
  $$RoutineExercisesTableTableManager get routineExercises =>
      $$RoutineExercisesTableTableManager(
        _db.attachedDatabase,
        _db.routineExercises,
      );
}
