import 'package:app_entrenamiento/core/database/app_database.dart';
import 'package:app_entrenamiento/core/units/weight_unit.dart';
import 'package:app_entrenamiento/features/exercises/data/drift_exercise_repository.dart';
import 'package:app_entrenamiento/features/exercises/data/exercise_seeder.dart';
import 'package:app_entrenamiento/features/exercises/data/seed/seed_exercises.dart';
import 'package:app_entrenamiento/features/exercises/domain/enums/difficulty.dart';
import 'package:app_entrenamiento/features/exercises/domain/enums/equipment.dart';
import 'package:app_entrenamiento/features/exercises/domain/enums/exercise_type.dart';
import 'package:app_entrenamiento/features/exercises/domain/enums/muscle_group.dart';
import 'package:app_entrenamiento/features/exercises/domain/exercise_draft.dart';
import 'package:app_entrenamiento/features/exercises/domain/exercise_repository.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

const _draft = ExerciseDraft(
  name: 'Remo en T (Barra)',
  primaryMuscle: MuscleGroup.back,
  secondaryMuscles: [MuscleGroup.biceps],
  type: ExerciseType.compound,
  equipment: Equipment.barbell,
  difficulty: Difficulty.intermediate,
  instructions: '  Paso 1  ',
  preferredUnit: WeightUnit.lb,
);

void main() {
  late AppDatabase db;
  late DriftExerciseRepository repository;
  final seed = seedExercises.first;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    repository = DriftExerciseRepository(db);
    await ExerciseSeeder(db).run();
  });

  tearDown(() async {
    await db.close();
  });

  group('seeder', () {
    test('given an empty database, when seeded, '
        'then every seed exercise exists marked as seed', () async {
      final all = await repository.watchAll().first;
      expect(all, hasLength(seedExercises.length));
      expect(all.every((e) => e.isSeed && !e.isCustom), isTrue);
    });

    test(
      'given a seeded database, when seeded again, then nothing is duplicated',
      () async {
        await ExerciseSeeder(db).run();
        expect(
          await repository.watchAll().first,
          hasLength(seedExercises.length),
        );
      },
    );

    test('given a seed whose unit the user changed, when seeded again, '
        'then the change is kept', () async {
      await repository.setPreferredUnit(seed.id, WeightUnit.lb);
      await ExerciseSeeder(db).run();
      expect((await repository.getById(seed.id))!.preferredUnit, WeightUnit.lb);
    });
  });

  group('create', () {
    test('given a valid draft, when created, then it is stored as custom '
        'with trimmed text', () async {
      final created = await repository.create(_draft);

      final stored = await repository.getById(created.id);
      expect(stored, created);
      expect(stored!.isCustom, isTrue);
      expect(stored.isSeed, isFalse);
      expect(stored.instructions, 'Paso 1');
      expect(stored.preferredUnit, WeightUnit.lb);
      expect(stored.secondaryMuscles, [MuscleGroup.biceps]);
    });

    test('given a draft with a seed name, when created, '
        'then it fails as a duplicate', () async {
      expect(
        repository.create(_draft.copyWith(name: seed.name.toUpperCase())),
        throwsA(
          isA<ExerciseValidationException>().having((e) => e.errors, 'errors', {
            ExerciseValidationError.nameDuplicate,
          }),
        ),
      );
    });

    test(
      'given a new exercise, when watching all, then the stream emits it',
      () async {
        final stream = repository.watchAll();
        expect(
          stream,
          emitsThrough(
            predicate<List<Object>>(
              (list) => list.length == seedExercises.length + 1,
            ),
          ),
        );
        await repository.create(_draft);
      },
    );
  });

  group('update', () {
    test('given a custom exercise, when updated, '
        'then fields and updatedAt change', () async {
      final created = await repository.create(_draft);
      final before = (await (db.select(
        db.exercises,
      )..where((e) => e.id.equals(created.id))).getSingle()).updatedAt;
      await Future<void>.delayed(const Duration(milliseconds: 5));

      await repository.update(
        created.id,
        _draft.copyWith(name: 'Remo en T (Máquina)'),
      );

      final row = await (db.select(
        db.exercises,
      )..where((e) => e.id.equals(created.id))).getSingle();
      expect(row.name, 'Remo en T (Máquina)');
      expect(row.updatedAt.isAfter(before), isTrue);
      expect(row.createdAt.isBefore(row.updatedAt), isTrue);
    });

    test('given a seed exercise, when updated, then it is rejected', () async {
      expect(
        repository.update(seed.id, ExerciseDraft.fromExercise(seed)),
        throwsA(isA<ExerciseNotEditableException>()),
      );
    });

    test(
      'given a missing exercise, when updated, then it is not found',
      () async {
        expect(
          repository.update('missing', _draft),
          throwsA(isA<ExerciseNotFoundException>()),
        );
      },
    );
  });

  group('softDelete', () {
    test('given a custom exercise, when soft-deleted, '
        'then it disappears but its row is kept', () async {
      final created = await repository.create(_draft);

      await repository.softDelete(created.id);

      expect(await repository.getById(created.id), isNull);
      expect(
        await repository.watchAll().first,
        hasLength(seedExercises.length),
      );
      final row = await (db.select(
        db.exercises,
      )..where((e) => e.id.equals(created.id))).getSingle();
      expect(row.deletedAt, isNotNull);
    });

    test('given a deleted exercise, when a new one reuses its name, '
        'then it is allowed', () async {
      final created = await repository.create(_draft);
      await repository.softDelete(created.id);

      expect(await repository.create(_draft), isNotNull);
    });

    test(
      'given a seed exercise, when soft-deleted, then it is rejected',
      () async {
        expect(
          repository.softDelete(seed.id),
          throwsA(isA<ExerciseNotEditableException>()),
        );
      },
    );
  });

  test(
    'given a seed exercise, when its unit is changed, then it is saved',
    () async {
      await repository.setPreferredUnit(seed.id, WeightUnit.lb);
      expect((await repository.getById(seed.id))!.preferredUnit, WeightUnit.lb);
    },
  );
}
