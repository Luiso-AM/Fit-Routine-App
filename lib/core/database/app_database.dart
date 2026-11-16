import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

// The generated part file uses these symbols, so they are imported here.
import '../../features/exercises/domain/enums/difficulty.dart';
import '../../features/exercises/domain/enums/equipment.dart';
import '../../features/exercises/domain/enums/exercise_type.dart';
import '../../features/exercises/domain/enums/muscle_group.dart';
import '../../features/profile/domain/enums/experience_level.dart';
import '../../features/profile/domain/enums/sex.dart';
import '../../features/profile/domain/enums/training_goal.dart';
import '../../features/routines/domain/enums/routine_template_type.dart';
import '../../features/workout/domain/enums/session_status.dart';
import '../units/weight_unit.dart';
import 'app_database.steps.dart';
import 'converters/enum_list_converter.dart';
import 'tables/body_tables.dart';
import 'tables/exercises_table.dart';
import 'tables/routine_tables.dart';
import 'tables/table_mixins.dart';
import 'tables/user_profile_table.dart';
import 'tables/workout_tables.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    UserProfile,
    BodyWeightEntries,
    BodyMeasurements,
    Exercises,
    Routines,
    RoutineDays,
    RoutineExercises,
    WorkoutSessions,
    SessionExercises,
    SetEntries,
  ],
)
class AppDatabase extends _$AppDatabase {
  /// Pass an [executor] in tests, e.g. `NativeDatabase.memory()`.
  AppDatabase([QueryExecutor? executor])
    : super(executor ?? driftDatabase(name: 'fit_routine'));

  /// Bump on every schema change and add a step in [migration].
  /// Never drop the user's database to "fix" a migration.
  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) => m.createAll(),
    onUpgrade: stepByStep(
      from1To2: (m, schema) async {
        // Session exercises keep a copy of their routine targets.
        final table = schema.sessionExercises;
        await m.addColumn(table, table.targetSets);
        await m.addColumn(table, table.targetRepsMin);
        await m.addColumn(table, table.targetRepsMax);
        await m.addColumn(table, table.restSeconds);
      },
      from2To3: (m, schema) async {
        // Sessions keep the end time of the running rest timer.
        final table = schema.workoutSessions;
        await m.addColumn(table, table.restEndsAt);
      },
    ),
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );
}
