import 'package:app_entrenamiento/core/database/app_database.dart';
import 'package:app_entrenamiento/features/exercises/data/exercise_seeder.dart';
import 'package:app_entrenamiento/features/exercises/data/seed/seed_exercises.dart';
import 'package:app_entrenamiento/features/exercises/domain/enums/exercise_type.dart';
import 'package:app_entrenamiento/features/exercises/domain/exercise.dart';
import 'package:app_entrenamiento/features/routines/data/drift_routine_repository.dart';
import 'package:app_entrenamiento/features/routines/domain/enums/routine_template_type.dart';
import 'package:app_entrenamiento/features/routines/domain/routine.dart';
import 'package:app_entrenamiento/features/routines/domain/routine_drafts.dart';
import 'package:app_entrenamiento/features/routines/domain/routine_repository.dart';
import 'package:app_entrenamiento/features/routines/domain/routine_template.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

final Exercise _compound = seedExercises.firstWhere(
  (e) => e.type == ExerciseType.compound,
);
final Exercise _isolation = seedExercises.firstWhere(
  (e) => e.type == ExerciseType.isolation,
);

void main() {
  late AppDatabase db;
  late DriftRoutineRepository repository;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    repository = DriftRoutineRepository(db);
    await ExerciseSeeder(db).run();
  });

  tearDown(() async {
    await db.close();
  });

  /// A routine with two days: "Push" with both exercises, and "Pull".
  Future<Routine> createRoutine() async {
    final routine = await repository.create(
      const RoutineDraft(name: '  Mi rutina  ', notes: ' Notas '),
    );
    final push = await repository.addDay(
      routine.id,
      const RoutineDayDraft(name: 'Push', weekday: DateTime.monday),
    );
    await repository.addDay(routine.id, const RoutineDayDraft(name: 'Pull'));
    await repository.addExercises(push.id, [_compound, _isolation]);
    return (await repository.watchById(routine.id).first)!;
  }

  group('create and read', () {
    test(
      'given a draft, when created, then it is stored trimmed and empty',
      () async {
        final routine = await repository.create(
          const RoutineDraft(name: '  Mi rutina  ', notes: ' Notas '),
        );

        final stored = await repository.watchById(routine.id).first;
        expect(stored!.name, 'Mi rutina');
        expect(stored.notes, 'Notas');
        expect(stored.templateType, isNull);
        expect(stored.days, isEmpty);
      },
    );

    test('given an invalid draft, when created, then it is rejected', () {
      expect(
        repository.create(const RoutineDraft()),
        throwsA(isA<RoutineValidationException>()),
      );
    });

    test('given days and exercises, when read, '
        'then they come in order with default targets by type', () async {
      final routine = await createRoutine();

      expect([for (final d in routine.days) d.name], ['Push', 'Pull']);
      expect(routine.days.first.weekday, DateTime.monday);
      final [compound, isolation] = routine.days.first.exercises;
      expect(compound.exerciseId, _compound.id);
      expect(
        (compound.targetSets, compound.targetRepsMin, compound.targetRepsMax),
        (3, 10, 12),
      );
      expect(compound.restSeconds, 120);
      expect(isolation.restSeconds, 90);
      expect(routine.exerciseCount, 2);
    });

    test('given a watcher, when an exercise is added to a day, '
        'then the routine is emitted again', () async {
      final routine = await createRoutine();
      final pull = routine.days.last;

      expect(
        repository.watchById(routine.id),
        emitsThrough(
          predicate<Routine?>(
            (r) => r!.dayById(pull.id)!.exercises.length == 1,
          ),
        ),
      );
      await repository.addExercises(pull.id, [_compound]);
    });
  });

  group('update and delete', () {
    test('given a routine, when updated, then name and notes change', () async {
      final routine = await createRoutine();

      await repository.update(
        routine.id,
        const RoutineDraft(name: 'Otra', notes: ''),
      );

      final stored = await repository.watchById(routine.id).first;
      expect(stored!.name, 'Otra');
      expect(stored.notes, '');
      expect(stored.days, hasLength(2));
    });

    test('given a routine, when soft-deleted, '
        'then it disappears but its row is kept', () async {
      final routine = await createRoutine();

      await repository.softDelete(routine.id);

      expect(await repository.watchById(routine.id).first, isNull);
      expect(await repository.watchAll().first, isEmpty);
      final row = await db.select(db.routines).getSingle();
      expect(row.deletedAt, isNotNull);
    });

    test('given a deleted routine, when its day is edited, '
        'then it is not found', () async {
      final routine = await createRoutine();
      await repository.softDelete(routine.id);

      expect(
        repository.updateDay(
          routine.days.first.id,
          const RoutineDayDraft(name: 'X'),
        ),
        throwsA(isA<RoutineNotFoundException>()),
      );
    });
  });

  group('duplicate', () {
    test('given a routine, when duplicated, then the copy has the same '
        'content under new ids', () async {
      final routine = await createRoutine();
      final firstExercise = routine.days.first.exercises.first;
      await repository.updateExercise(
        firstExercise.id,
        RoutineExerciseDraft.fromExercise(firstExercise)
            .copyWith(initialWeightKg: 60, notes: 'Pausa abajo'),
      );

      final copy = await repository.duplicate(
        routine.id,
        name: 'Mi rutina (copia)',
      );

      expect(copy.id, isNot(routine.id));
      expect(copy.name, 'Mi rutina (copia)');
      expect(copy.notes, 'Notas');
      expect([for (final d in copy.days) d.name], ['Push', 'Pull']);
      expect(copy.days.first.weekday, DateTime.monday);
      final copied = copy.days.first.exercises.first;
      expect(copied.id, isNot(firstExercise.id));
      expect(copied.exerciseId, firstExercise.exerciseId);
      expect(copied.initialWeightKg, 60);
      expect(copied.notes, 'Pausa abajo');

      final originalIds = {
        for (final d in routine.days) d.id,
        for (final d in routine.days) ...d.exercises.map((e) => e.id),
      };
      final copyIds = {
        for (final d in copy.days) d.id,
        for (final d in copy.days) ...d.exercises.map((e) => e.id),
      };
      expect(originalIds.intersection(copyIds), isEmpty);
    });

    test('given a duplicated routine, when the copy is edited, '
        'then the original is unchanged', () async {
      final routine = await createRoutine();
      final copy = await repository.duplicate(routine.id, name: 'Copia');

      await repository.deleteDay(copy.days.first.id);

      final original = await repository.watchById(routine.id).first;
      expect(original!.days, hasLength(2));
    });
  });

  group('days', () {
    test('given three days, when the middle one is deleted, '
        'then positions stay contiguous', () async {
      final routine = await createRoutine();
      await repository.addDay(routine.id, const RoutineDayDraft(name: 'Legs'));
      final pushId = routine.days.first.id;

      await repository.deleteDay(routine.days.last.id);

      final days = (await repository.watchById(routine.id).first)!.days;
      expect([for (final d in days) d.name], ['Push', 'Legs']);
      expect([for (final d in days) d.position], [0, 1]);
      expect(days.first.id, pushId);
    });

    test('given a day with exercises, when deleted, '
        'then its exercises are deleted too', () async {
      final routine = await createRoutine();

      await repository.deleteDay(routine.days.first.id);

      expect(await db.select(db.routineExercises).get(), isEmpty);
    });

    test(
      'given two days, when reordered, then the new order is kept',
      () async {
        final routine = await createRoutine();
        final [push, pull] = routine.days;

        await repository.reorderDays(routine.id, [pull.id, push.id]);

        final days = (await repository.watchById(routine.id).first)!.days;
        expect([for (final d in days) d.name], ['Pull', 'Push']);
      },
    );

    test('given an incomplete order, when reordering days, '
        'then it is rejected', () async {
      final routine = await createRoutine();

      expect(
        repository.reorderDays(routine.id, [routine.days.first.id]),
        throwsArgumentError,
      );
    });

    test(
      'given a day, when renamed and unscheduled, then it is saved',
      () async {
        final routine = await createRoutine();
        final push = routine.days.first;

        await repository.updateDay(
          push.id,
          const RoutineDayDraft(name: 'Empuje'),
        );

        final day = (await repository.watchById(routine.id).first)!.dayById(
          push.id,
        );
        expect(day!.name, 'Empuje');
        expect(day.weekday, isNull);
      },
    );
  });

  group('exercises', () {
    test('given a day exercise, when its targets are updated, '
        'then they are saved', () async {
      final routine = await createRoutine();
      final exercise = routine.days.first.exercises.first;

      await repository.updateExercise(
        exercise.id,
        const RoutineExerciseDraft(
          targetSets: 4,
          targetRepsMin: 6,
          targetRepsMax: 8,
          initialWeightKg: 61.23456,
          restSeconds: 180,
          notes: '  Tempo 3-1-1  ',
        ),
      );

      final stored = (await repository.watchById(routine.id).first)!
          .days
          .first
          .exercises
          .first;
      expect(stored.targetSets, 4);
      expect((stored.targetRepsMin, stored.targetRepsMax), (6, 8));
      expect(stored.initialWeightKg, 61.23456);
      expect(stored.restSeconds, 180);
      expect(stored.notes, 'Tempo 3-1-1');
    });

    test(
      'given invalid targets, when updated, then they are rejected',
      () async {
        final routine = await createRoutine();

        expect(
          repository.updateExercise(
            routine.days.first.exercises.first.id,
            const RoutineExerciseDraft(),
          ),
          throwsA(isA<RoutineExerciseValidationException>()),
        );
      },
    );

    test('given two exercises, when the first is removed, '
        'then the other moves to position 0', () async {
      final routine = await createRoutine();
      final [first, second] = routine.days.first.exercises;

      await repository.removeExercise(first.id);

      final exercises =
          (await repository.watchById(routine.id).first)!.days.first.exercises;
      expect(exercises.single.id, second.id);
      expect(exercises.single.position, 0);
    });

    test(
      'given two exercises, when reordered, then the order is kept',
      () async {
        final routine = await createRoutine();
        final day = routine.days.first;
        final [first, second] = day.exercises;

        await repository.reorderExercises(day.id, [second.id, first.id]);

        final exercises = (await repository.watchById(routine.id).first)!
            .days
            .first
            .exercises;
        expect([for (final e in exercises) e.id], [second.id, first.id]);
      },
    );

    test('given an exercise added twice, when added, '
        'then both entries are kept', () async {
      final routine = await createRoutine();
      final pull = routine.days.last;

      await repository.addExercises(pull.id, [_compound, _compound]);

      final exercises = (await repository.watchById(routine.id).first)!
          .dayById(pull.id)!
          .exercises;
      expect([for (final e in exercises) e.position], [0, 1]);
    });
  });

  test('given a template, when a routine is created from it, '
      'then it has the template days, exercises and type', () async {
    final template = RoutineTemplate(
      type: RoutineTemplateType.pushPullLegs,
      name: 'Push / Pull / Legs',
      days: [
        RoutineTemplateDay(name: 'Push', exerciseIds: [_compound.id]),
        RoutineTemplateDay(name: 'Pull', exerciseIds: [_isolation.id]),
      ],
    );

    final routine = await repository.createFromTemplate(template);

    expect(routine.name, 'Push / Pull / Legs');
    expect(routine.templateType, RoutineTemplateType.pushPullLegs);
    expect([for (final d in routine.days) d.name], ['Push', 'Pull']);
    expect(routine.days.first.exercises.single.restSeconds, 120);
    expect(routine.days.last.exercises.single.restSeconds, 90);
  });
}
