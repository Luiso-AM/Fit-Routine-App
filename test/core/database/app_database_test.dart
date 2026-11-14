import 'package:app_entrenamiento/core/database/app_database.dart';
import 'package:app_entrenamiento/core/units/weight_unit.dart';
import 'package:app_entrenamiento/features/exercises/domain/enums/difficulty.dart';
import 'package:app_entrenamiento/features/exercises/domain/enums/equipment.dart';
import 'package:app_entrenamiento/features/exercises/domain/enums/exercise_type.dart';
import 'package:app_entrenamiento/features/exercises/domain/enums/muscle_group.dart';
import 'package:app_entrenamiento/features/profile/domain/enums/experience_level.dart';
import 'package:app_entrenamiento/features/profile/domain/enums/training_goal.dart';
import 'package:app_entrenamiento/features/routines/domain/enums/routine_template_type.dart';
import 'package:app_entrenamiento/features/workout/domain/enums/session_status.dart';
import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

final _uuidV4 = RegExp(
  r'^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$',
);

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  Future<List<String>> sqliteObjects(String type) async {
    final rows = await db
        .customSelect(
          "SELECT name FROM sqlite_master WHERE type = ? AND name NOT LIKE 'sqlite_%'",
          variables: [Variable.withString(type)],
        )
        .get();
    return [for (final row in rows) row.read<String>('name')];
  }

  Future<String> insertExercise({String name = 'Press de banca'}) async {
    final row = await db
        .into(db.exercises)
        .insertReturning(
          ExercisesCompanion.insert(
            name: name,
            primaryMuscle: MuscleGroup.chest,
            type: ExerciseType.compound,
            equipment: Equipment.barbell,
            difficulty: Difficulty.intermediate,
          ),
        );
    return row.id;
  }

  Future<String> insertRoutineDay() async {
    final routine = await db
        .into(db.routines)
        .insertReturning(RoutinesCompanion.insert(name: 'PPL'));
    final day = await db
        .into(db.routineDays)
        .insertReturning(
          RoutineDaysCompanion.insert(
            routineId: routine.id,
            name: 'Push',
            position: 0,
          ),
        );
    return day.id;
  }

  /// Inserts a session with one exercise and one set, returning their ids.
  Future<({String sessionId, String sessionExerciseId, String setId})>
  insertSessionWithSet({String? routineDayId}) async {
    final exerciseId = await insertExercise();
    final session = await db
        .into(db.workoutSessions)
        .insertReturning(
          WorkoutSessionsCompanion.insert(
            routineDayId: Value(routineDayId),
            startedAt: DateTime.utc(2026, 11, 12, 18),
          ),
        );
    final sessionExercise = await db
        .into(db.sessionExercises)
        .insertReturning(
          SessionExercisesCompanion.insert(
            sessionId: session.id,
            exerciseId: exerciseId,
            position: 0,
          ),
        );
    final set = await db
        .into(db.setEntries)
        .insertReturning(
          SetEntriesCompanion.insert(
            sessionExerciseId: sessionExercise.id,
            setNumber: 1,
            weightKg: const Value(61.23497),
            reps: const Value(8),
          ),
        );
    return (
      sessionId: session.id,
      sessionExerciseId: sessionExercise.id,
      setId: set.id,
    );
  }

  group('schema', () {
    test(
      'given a new database, when it opens, then all tables exist',
      () async {
        expect(
          await sqliteObjects('table'),
          unorderedEquals([
            'user_profile',
            'body_weight_entries',
            'body_measurements',
            'exercises',
            'routines',
            'routine_days',
            'routine_exercises',
            'workout_sessions',
            'session_exercises',
            'set_entries',
          ]),
        );
      },
    );

    test(
      'given a new database, when it opens, then query indexes exist',
      () async {
        expect(
          await sqliteObjects('index'),
          containsAll([
            'idx_set_entries_session_exercise',
            'idx_session_exercises_session',
            'idx_session_exercises_exercise',
            'idx_workout_sessions_status',
            'idx_workout_sessions_started_at',
          ]),
        );
      },
    );

    test(
      'given a new database, when it opens, then foreign keys are enforced',
      () async {
        final row = await db.customSelect('PRAGMA foreign_keys').getSingle();
        expect(row.read<int>('foreign_keys'), 1);
      },
    );

    test('given the app database, then the schema version is 2', () {
      expect(db.schemaVersion, 2);
    });
  });

  group('defaults', () {
    test('given a row without id or timestamps, when inserted, '
        'then it gets a UUID v4 and UTC timestamps', () async {
      final before = DateTime.now().toUtc();
      final routine = await db
          .into(db.routines)
          .insertReturning(RoutinesCompanion.insert(name: 'Full Body'));

      expect(routine.id, matches(_uuidV4));
      expect(routine.createdAt.isUtc, isTrue);
      expect(routine.updatedAt.isUtc, isTrue);
      expect(
        routine.createdAt.isBefore(before.subtract(const Duration(seconds: 1))),
        isFalse,
      );
      expect(routine.deletedAt, isNull);
      expect(routine.notes, '');
      expect(routine.templateType, isNull);
    });

    test('given a minimal exercise, when inserted, '
        'then it defaults to kg, no image and not seed or custom', () async {
      final id = await insertExercise();
      final exercise = await (db.select(
        db.exercises,
      )..where((e) => e.id.equals(id))).getSingle();

      expect(exercise.preferredUnit, WeightUnit.kg);
      expect(exercise.imagePath, isNull);
      expect(exercise.secondaryMuscles, isEmpty);
      expect(exercise.isSeed, isFalse);
      expect(exercise.isCustom, isFalse);
    });

    test('given a new session, when inserted, '
        'then it is in progress, not demo and has no pauses', () async {
      final ids = await insertSessionWithSet();
      final session = await (db.select(
        db.workoutSessions,
      )..where((s) => s.id.equals(ids.sessionId))).getSingle();

      expect(session.status, SessionStatus.inProgress);
      expect(session.isDemo, isFalse);
      expect(session.pausedTotalSeconds, 0);
      expect(session.pausedAt, isNull);
      expect(session.endedAt, isNull);
    });
  });

  group('round trip', () {
    test('given a profile with enums and an equipment list, when read back, '
        'then all values are preserved', () async {
      await db
          .into(db.userProfile)
          .insert(
            UserProfileCompanion.insert(
              alias: 'Luis',
              heightCm: 175.5,
              experienceLevel: ExperienceLevel.intermediate,
              goal: TrainingGoal.hypertrophy,
              daysPerWeek: 4,
              sessionDurationMin: 60,
              birthDate: Value(DateTime.utc(1995, 3, 14)),
              equipment: const Value([Equipment.barbell, Equipment.dumbbell]),
            ),
          );

      final profile = await db.select(db.userProfile).getSingle();
      expect(profile.alias, 'Luis');
      expect(profile.sex, isNull);
      expect(profile.heightCm, 175.5);
      expect(profile.experienceLevel, ExperienceLevel.intermediate);
      expect(profile.goal, TrainingGoal.hypertrophy);
      expect(profile.birthDate, DateTime.utc(1995, 3, 14));
      expect(profile.equipment, [Equipment.barbell, Equipment.dumbbell]);
    });

    test('given an exercise with secondary muscles and lb preference, '
        'when read back, then the list and unit are preserved', () async {
      final row = await db
          .into(db.exercises)
          .insertReturning(
            ExercisesCompanion.insert(
              name: 'Press militar',
              primaryMuscle: MuscleGroup.shoulders,
              type: ExerciseType.compound,
              equipment: Equipment.barbell,
              difficulty: Difficulty.intermediate,
              secondaryMuscles: const Value([MuscleGroup.triceps]),
              preferredUnit: const Value(WeightUnit.lb),
            ),
          );

      final raw = await db
          .customSelect(
            'SELECT secondary_muscles, preferred_unit FROM exercises WHERE id = ?',
            variables: [Variable.withString(row.id)],
          )
          .getSingle();
      expect(raw.read<String>('secondary_muscles'), '["triceps"]');
      expect(raw.read<String>('preferred_unit'), 'lb');
      expect(row.secondaryMuscles, [MuscleGroup.triceps]);
      expect(row.preferredUnit, WeightUnit.lb);
    });

    test('given a routine with a day and an exercise, when read back, '
        'then targets and template are preserved', () async {
      final exerciseId = await insertExercise();
      final routine = await db
          .into(db.routines)
          .insertReturning(
            RoutinesCompanion.insert(
              name: 'Push Pull Legs',
              templateType: const Value(RoutineTemplateType.pushPullLegs),
            ),
          );
      final day = await db
          .into(db.routineDays)
          .insertReturning(
            RoutineDaysCompanion.insert(
              routineId: routine.id,
              name: 'Push',
              position: 0,
              weekday: const Value(DateTime.monday),
            ),
          );
      await db
          .into(db.routineExercises)
          .insert(
            RoutineExercisesCompanion.insert(
              routineDayId: day.id,
              exerciseId: exerciseId,
              position: 0,
              targetSets: 3,
              targetRepsMin: 8,
              targetRepsMax: 12,
              restSeconds: 120,
              initialWeightKg: const Value(60),
            ),
          );

      final stored = await db.select(db.routineExercises).getSingle();
      expect(routine.templateType, RoutineTemplateType.pushPullLegs);
      expect(day.weekday, DateTime.monday);
      expect(stored.targetSets, 3);
      expect(stored.targetRepsMin, 8);
      expect(stored.targetRepsMax, 12);
      expect(stored.initialWeightKg, 60);
      expect(stored.restSeconds, 120);
    });

    test('given a set with a fractional kg weight, when read back, '
        'then the weight is not rounded', () async {
      final ids = await insertSessionWithSet();
      final set = await (db.select(
        db.setEntries,
      )..where((s) => s.id.equals(ids.setId))).getSingle();

      expect(set.weightKg, 61.23497);
      expect(set.reps, 8);
      expect(set.rir, isNull);
      expect(set.isCompleted, isFalse);
    });

    test('given body weight and measurements, when read back, '
        'then values and UTC dates are preserved', () async {
      final date = DateTime.utc(2026, 11, 1);
      await db
          .into(db.bodyWeightEntries)
          .insert(
            BodyWeightEntriesCompanion.insert(date: date, weightKg: 78.4),
          );
      await db
          .into(db.bodyMeasurements)
          .insert(
            BodyMeasurementsCompanion.insert(
              date: date,
              waistCm: const Value(82),
            ),
          );

      final weight = await db.select(db.bodyWeightEntries).getSingle();
      final measurement = await db.select(db.bodyMeasurements).getSingle();
      expect(weight.weightKg, 78.4);
      expect(weight.date, date);
      expect(weight.date.isUtc, isTrue);
      expect(measurement.waistCm, 82);
      expect(measurement.chestCm, isNull);
      expect(measurement.bodyFatPct, isNull);
    });
  });

  group('integrity', () {
    test('given a set for a missing session exercise, when inserted, '
        'then the foreign key rejects it', () async {
      expect(
        db
            .into(db.setEntries)
            .insert(
              SetEntriesCompanion.insert(
                sessionExerciseId: 'missing',
                setNumber: 1,
              ),
            ),
        throwsA(isA<SqliteException>()),
      );
    });

    test(
      'given a session with exercises and sets, when the session is deleted, '
      'then its exercises and sets are deleted too',
      () async {
        final ids = await insertSessionWithSet();

        await (db.delete(
          db.workoutSessions,
        )..where((s) => s.id.equals(ids.sessionId))).go();

        expect(await db.select(db.sessionExercises).get(), isEmpty);
        expect(await db.select(db.setEntries).get(), isEmpty);
        expect(await db.select(db.exercises).get(), hasLength(1));
      },
    );

    test('given a session linked to a routine day, when the day is deleted, '
        'then the session is kept without the link', () async {
      final dayId = await insertRoutineDay();
      final ids = await insertSessionWithSet(routineDayId: dayId);

      await (db.delete(db.routineDays)..where((d) => d.id.equals(dayId))).go();

      final session = await (db.select(
        db.workoutSessions,
      )..where((s) => s.id.equals(ids.sessionId))).getSingle();
      expect(session.routineDayId, isNull);
      expect(await db.select(db.setEntries).get(), hasLength(1));
    });

    test('given an exercise used in a session, when it is hard-deleted, '
        'then the foreign key prevents it', () async {
      await insertSessionWithSet();

      expect(db.delete(db.exercises).go(), throwsA(isA<SqliteException>()));
    });

    test('given an invalid weekday, when a routine day is inserted, '
        'then the check constraint rejects it', () async {
      final routine = await db
          .into(db.routines)
          .insertReturning(RoutinesCompanion.insert(name: 'Test'));

      expect(
        db
            .into(db.routineDays)
            .insert(
              RoutineDaysCompanion.insert(
                routineId: routine.id,
                name: 'Día',
                position: 0,
                weekday: const Value(8),
              ),
            ),
        throwsA(isA<SqliteException>()),
      );
    });

    test('given a rep range with max below min, when inserted, '
        'then the check constraint rejects it', () async {
      final exerciseId = await insertExercise();
      final dayId = await insertRoutineDay();

      expect(
        db
            .into(db.routineExercises)
            .insert(
              RoutineExercisesCompanion.insert(
                routineDayId: dayId,
                exerciseId: exerciseId,
                position: 0,
                targetSets: 3,
                targetRepsMin: 12,
                targetRepsMax: 8,
                restSeconds: 90,
              ),
            ),
        throwsA(isA<SqliteException>()),
      );
    });
  });
}
