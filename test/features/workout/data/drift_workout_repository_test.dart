import 'package:app_entrenamiento/core/database/app_database.dart';
import 'package:app_entrenamiento/features/exercises/data/exercise_seeder.dart';
import 'package:app_entrenamiento/features/exercises/data/seed/seed_exercises.dart';
import 'package:app_entrenamiento/features/exercises/domain/enums/exercise_type.dart';
import 'package:app_entrenamiento/features/exercises/domain/exercise.dart';
import 'package:app_entrenamiento/features/routines/data/drift_routine_repository.dart';
import 'package:app_entrenamiento/features/routines/domain/routine.dart';
import 'package:app_entrenamiento/features/routines/domain/routine_drafts.dart';
import 'package:app_entrenamiento/features/workout/data/drift_workout_repository.dart';
import 'package:app_entrenamiento/features/workout/domain/enums/session_status.dart';
import 'package:app_entrenamiento/features/workout/domain/rest_timer.dart';
import 'package:app_entrenamiento/features/workout/domain/set_values.dart';
import 'package:app_entrenamiento/features/workout/domain/workout_repository.dart';
import 'package:app_entrenamiento/features/workout/domain/workout_session.dart';
import 'package:drift/drift.dart' show Value;
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
  late DriftRoutineRepository routines;
  late DriftWorkoutRepository repository;
  late DateTime now;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    routines = DriftRoutineRepository(db);
    now = DateTime.utc(2026, 11, 14, 10);
    repository = DriftWorkoutRepository(db, clock: () => now);
    await ExerciseSeeder(db).run();
  });

  tearDown(() async {
    await db.close();
  });

  void advance(Duration duration) => now = now.add(duration);

  /// A "Push" day with the compound exercise (4 × 6–8, 50 kg, 150 s) and
  /// the isolation one with its default targets.
  Future<RoutineDay> createDay() async {
    final routine = await routines.create(const RoutineDraft(name: 'PPL'));
    final day = await routines.addDay(
      routine.id,
      const RoutineDayDraft(name: 'Push'),
    );
    await routines.addExercises(day.id, [_compound, _isolation]);
    final stored = (await routines.watchById(routine.id).first)!.days.single;
    await routines.updateExercise(
      stored.exercises.first.id,
      const RoutineExerciseDraft(
        targetSets: 4,
        targetRepsMin: 6,
        targetRepsMax: 8,
        initialWeightKg: 50,
        restSeconds: 150,
        notes: 'Pausa abajo',
      ),
    );
    return (await routines.watchById(routine.id).first)!.days.single;
  }

  Future<WorkoutSession> active() async =>
      (await repository.watchActive().first)!;

  /// Completes every set of the active session and finishes it.
  Future<void> completeAndFinish() async {
    final session = await active();
    for (final set in session.exercises.expand((e) => e.sets)) {
      await repository.setCompleted(set.id, completed: true);
    }
    await repository.finish(session.id);
  }

  group('start', () {
    test('given a routine day, when a session starts from it, '
        'then it copies the exercises, targets and prefilled sets', () async {
      final day = await createDay();

      await repository.startFromRoutineDay(day.id);

      final session = await active();
      expect(session.routineDayId, day.id);
      expect(session.routineName, 'PPL');
      expect(session.routineDayName, 'Push');
      expect(session.startedAt, now);
      expect(session.status, SessionStatus.inProgress);
      final [first, second] = session.exercises;
      expect(first.exerciseId, _compound.id);
      expect(first.targetSets, 4);
      expect((first.targetRepsMin, first.targetRepsMax), (6, 8));
      expect(first.restSeconds, 150);
      expect(first.notes, 'Pausa abajo');
      expect([for (final s in first.sets) s.setNumber], [1, 2, 3, 4]);
      expect(first.sets.every((s) => s.weightKg == 50 && s.reps == 6), isTrue);
      expect(first.sets.every((s) => !s.isCompleted), isTrue);
      expect(second.exerciseId, _isolation.id);
      expect(second.sets, hasLength(3));
    });

    test('given a session in progress, when another starts, '
        'then it is rejected', () async {
      final started = await repository.startFree();

      expect(
        repository.startFree(),
        throwsA(
          isA<ActiveSessionExistsException>().having(
            (e) => e.sessionId,
            'sessionId',
            started.id,
          ),
        ),
      );
    });

    test('given a missing day, when a session starts from it, '
        'then it is rejected', () {
      expect(
        repository.startFromRoutineDay('missing'),
        throwsA(isA<WorkoutNotFoundException>()),
      );
    });

    test('given a free session, when started, then it is empty', () async {
      await repository.startFree();

      final session = await active();
      expect(session.isFree, isTrue);
      expect(session.routineDayName, isNull);
      expect(session.exercises, isEmpty);
    });

    test('given a started session, when the routine is edited, '
        'then the session keeps its copy', () async {
      final day = await createDay();
      final session = await repository.startFromRoutineDay(day.id);
      await routines.removeExercise(day.exercises.first.id);

      final stored = await active();
      expect(stored.id, session.id);
      expect(stored.exercises, hasLength(2));
    });
  });

  group('history prefill', () {
    test('given a finished session, when the day starts again, '
        'then sets start from the weights done last time', () async {
      final day = await createDay();
      await repository.startFromRoutineDay(day.id);
      final first = (await active()).exercises.first;
      await repository.updateSet(
        first.sets.first.id,
        const SetValues(weightKg: 60, reps: 8),
      );
      await completeAndFinish();
      advance(const Duration(days: 2));

      await repository.startFromRoutineDay(day.id);

      final sets = (await active()).exercises.first.sets;
      // Completing set 1 at 60 kg prefilled set 2 with 60 kg, and so on.
      expect([for (final s in sets) s.weightKg], [60, 60, 60, 60]);
      expect([for (final s in sets) s.reps], [6, 6, 6, 6]);
    });

    test('given a discarded session, '
        'then it is not used as the last performance', () async {
      final day = await createDay();
      final session = await repository.startFromRoutineDay(day.id);
      await repository.discard(session.id);

      expect(await repository.lastPerformances([_compound.id]), isEmpty);
    });

    test('given two finished sessions, then the last performance '
        'is the latest with its completed sets only', () async {
      final day = await createDay();
      await repository.startFromRoutineDay(day.id);
      await completeAndFinish();
      advance(const Duration(days: 1));
      final second = await repository.startFromRoutineDay(day.id);
      final sets = second.exercises.first.sets;
      await repository.updateSet(
        sets.first.id,
        const SetValues(weightKg: 70, reps: 5),
      );
      await repository.setCompleted(sets.first.id, completed: true);
      await repository.finish(second.id);

      final last = (await repository.lastPerformances([
        _compound.id,
        _isolation.id,
      ]));

      expect(last[_compound.id]!.sessionId, second.id);
      expect(last[_compound.id]!.performedAt, now);
      expect(last[_compound.id]!.sets, hasLength(1));
      expect(last[_compound.id]!.sets.single.weightKg, 70);
      // The isolation exercise had nothing completed in the second session.
      expect(last[_isolation.id]!.sessionId, isNot(second.id));
    });
  });

  group('exercises', () {
    test('given a free session, when exercises are added, '
        'then they get default sets and rest without targets', () async {
      final session = await repository.startFree();

      await repository.addExercises(session.id, [_compound, _isolation]);

      final [compound, isolation] = (await active()).exercises;
      expect((compound.position, isolation.position), (0, 1));
      expect(compound.targetSets, isNull);
      expect(compound.targetRepsMin, isNull);
      expect(compound.restSeconds, 120);
      expect(isolation.restSeconds, 90);
      expect(compound.sets, hasLength(3));
      expect(compound.sets.every((s) => s.reps == 10), isTrue);
    });

    test('given an exercise done before, when added, '
        'then it repeats the sets done last time', () async {
      final first = await repository.startFree();
      await repository.addExercises(first.id, [_compound]);
      final set = (await active()).exercises.single.sets.first;
      await repository.updateSet(
        set.id,
        const SetValues(weightKg: 80, reps: 4),
      );
      await repository.setCompleted(set.id, completed: true);
      await repository.finish(first.id);

      final second = await repository.startFree();
      await repository.addExercises(second.id, [_compound]);

      final sets = (await active()).exercises.single.sets;
      expect(sets, hasLength(1));
      expect((sets.single.weightKg, sets.single.reps), (80.0, 4));
    });

    test('given an exercise, when removed, then its sets go too', () async {
      final session = await repository.startFree();
      await repository.addExercises(session.id, [_compound, _isolation]);
      final exercise = (await active()).exercises.first;

      await repository.removeExercise(exercise.id);

      final exercises = (await active()).exercises;
      expect([for (final e in exercises) e.exerciseId], [_isolation.id]);
      final sets = await db.select(db.setEntries).get();
      expect(sets.where((s) => s.sessionExerciseId == exercise.id), isEmpty);
    });

    test('given an exercise added after a removal, '
        'then it goes after the remaining ones', () async {
      final session = await repository.startFree();
      await repository.addExercises(session.id, [_compound, _isolation]);
      await repository.removeExercise((await active()).exercises.first.id);

      await repository.addExercises(session.id, [_compound]);

      final exercises = (await active()).exercises;
      expect(
        [for (final e in exercises) e.exerciseId],
        [_isolation.id, _compound.id],
      );
    });
  });

  group('sets', () {
    Future<SessionExercise> startWithExercise() async {
      final day = await createDay();
      await repository.startFromRoutineDay(day.id);
      return (await active()).exercises.first;
    }

    test('given a set, when its values change, '
        'then they are saved at once', () async {
      final exercise = await startWithExercise();

      await repository.updateSet(
        exercise.sets.first.id,
        const SetValues(weightKg: 62.5, reps: 7, rir: 2),
      );

      final set = (await active()).exercises.first.sets.first;
      expect((set.weightKg, set.reps, set.rir), (62.5, 7, 2));
    });

    test('given invalid values, when saved, then they are rejected', () async {
      final exercise = await startWithExercise();

      expect(
        repository.updateSet(
          exercise.sets.first.id,
          const SetValues(weightKg: -5),
        ),
        throwsArgumentError,
      );
    });

    test('given a set, when completed, then it is stamped '
        'and the next pending set copies its weight and reps', () async {
      final exercise = await startWithExercise();
      final [first, second, third, _] = exercise.sets;
      await repository.updateSet(
        first.id,
        const SetValues(weightKg: 65, reps: 8, rir: 1),
      );

      await repository.setCompleted(first.id, completed: true);

      final sets = (await active()).exercises.first.sets;
      expect(sets[0].isCompleted, isTrue);
      expect(sets[0].completedAt, now);
      expect((sets[1].weightKg, sets[1].reps, sets[1].rir), (65.0, 8, null));
      expect(sets[1].id, second.id);
      expect((sets[2].weightKg, sets[2].reps), (third.weightKg, third.reps));
    });

    test('given a completed set, when undone, '
        'then it is pending again', () async {
      final exercise = await startWithExercise();
      final set = exercise.sets.first;
      await repository.setCompleted(set.id, completed: true);

      await repository.setCompleted(set.id, completed: false);

      final stored = (await active()).exercises.first.sets.first;
      expect(stored.isCompleted, isFalse);
      expect(stored.completedAt, isNull);
    });

    test('given a completed next set, when the previous is completed, '
        'then the next keeps its values', () async {
      final exercise = await startWithExercise();
      final [first, second, ..._] = exercise.sets;
      await repository.updateSet(second.id, const SetValues(weightKg: 40));
      await repository.setCompleted(second.id, completed: true);
      await repository.updateSet(first.id, const SetValues(weightKg: 90));

      await repository.setCompleted(first.id, completed: true);

      final sets = (await active()).exercises.first.sets;
      expect(sets[1].weightKg, 40);
    });

    test('given sets, when one is added, '
        'then it copies the last set and goes at the end', () async {
      final exercise = await startWithExercise();
      await repository.updateSet(
        exercise.sets.last.id,
        const SetValues(weightKg: 45, reps: 9, rir: 3),
      );

      await repository.addSet(exercise.id);

      final sets = (await active()).exercises.first.sets;
      expect(sets, hasLength(5));
      expect(sets.last.setNumber, 5);
      expect((sets.last.weightKg, sets.last.reps), (45.0, 9));
      expect(sets.last.rir, isNull);
      expect(sets.last.isCompleted, isFalse);
    });

    test('given four sets, when the second is removed, '
        'then the rest are renumbered', () async {
      final exercise = await startWithExercise();
      final removed = exercise.sets[1];

      await repository.removeSet(removed.id);

      final sets = (await active()).exercises.first.sets;
      expect([for (final s in sets) s.setNumber], [1, 2, 3]);
      expect(sets.map((s) => s.id), isNot(contains(removed.id)));
    });

    test('given a missing set, when changed, then it is rejected', () {
      expect(
        repository.setCompleted('missing', completed: true),
        throwsA(isA<WorkoutNotFoundException>()),
      );
    });
  });

  group('lifecycle', () {
    test('given a session, when paused and resumed, '
        'then the pause is added to the paused total', () async {
      final session = await repository.startFree();
      advance(const Duration(minutes: 10));

      await repository.pause(session.id);
      expect((await active()).pausedAt, now);
      advance(const Duration(minutes: 3));
      await repository.resume(session.id);

      final stored = await active();
      expect(stored.isPaused, isFalse);
      expect(stored.pausedTotalSeconds, 180);
      advance(const Duration(minutes: 2));
      expect(stored.activeDuration(now), const Duration(minutes: 12));
    });

    test('given a paused session, when paused again, '
        'then the pause start is kept', () async {
      final session = await repository.startFree();
      await repository.pause(session.id);
      final pausedAt = now;
      advance(const Duration(minutes: 1));

      await repository.pause(session.id);

      expect((await active()).pausedAt, pausedAt);
    });

    test('given a paused session, when finished, '
        'then it is completed and the pause is closed', () async {
      final session = await repository.startFree();
      advance(const Duration(minutes: 30));
      await repository.pause(session.id);
      advance(const Duration(minutes: 5));

      await repository.finish(session.id);

      expect(await repository.watchActive().first, isNull);
      final row = await (db.select(
        db.workoutSessions,
      )..where((s) => s.id.equals(session.id))).getSingle();
      expect(row.status, SessionStatus.completed);
      expect(row.endedAt, now);
      expect(row.pausedAt, isNull);
      expect(row.pausedTotalSeconds, 300);
    });

    test('given a session, when discarded, '
        'then it is kept as discarded and no longer active', () async {
      final session = await repository.startFree();

      await repository.discard(session.id);

      expect(await repository.watchActive().first, isNull);
      final row = await db.select(db.workoutSessions).getSingle();
      expect(row.status, SessionStatus.discarded);
    });

    test('given a finished session, when finished again, '
        'then it is rejected', () async {
      final session = await repository.startFree();
      await repository.finish(session.id);

      expect(
        repository.finish(session.id),
        throwsA(isA<SessionNotInProgressException>()),
      );
    });

    test('given a demo session in progress, then it is not active', () async {
      await db
          .into(db.workoutSessions)
          .insert(
            WorkoutSessionsCompanion.insert(
              startedAt: now,
              isDemo: const Value(true),
            ),
          );

      expect(await repository.watchActive().first, isNull);
    });

    test('given an active session, when a set changes, '
        'then the stream emits the new state', () async {
      final session = await repository.startFree();
      await repository.addExercises(session.id, [_compound]);
      final set = (await active()).exercises.single.sets.first;

      final emitted = expectLater(
        repository.watchActive().map((s) => s?.completedSets),
        emitsThrough(1),
      );
      await repository.setCompleted(set.id, completed: true);
      await emitted;
    });
  });

  group('rest timer', () {
    /// Starts the "Push" day and returns the first set of the compound
    /// exercise, whose rest is 150 s.
    Future<SetEntry> startAndFirstSet() async {
      final day = await createDay();
      await repository.startFromRoutineDay(day.id);
      return (await active()).exercises.first.sets.first;
    }

    test('given a session, when a set is completed, '
        'then the rest ends after the exercise rest', () async {
      final set = await startAndFirstSet();

      await repository.setCompleted(set.id, completed: true);

      expect(
        (await active()).restEndsAt,
        now.add(const Duration(seconds: 150)),
      );
    });

    test('given a paused session, when a set is completed, '
        'then no rest starts', () async {
      final set = await startAndFirstSet();
      await repository.pause((await active()).id);

      await repository.setCompleted(set.id, completed: true);

      expect((await active()).restEndsAt, isNull);
    });

    test('given a running rest, when the set is marked pending, '
        'then the rest keeps running', () async {
      final set = await startAndFirstSet();
      await repository.setCompleted(set.id, completed: true);
      final endsAt = (await active()).restEndsAt;

      await repository.setCompleted(set.id, completed: false);

      expect((await active()).restEndsAt, endsAt);
    });

    test('given a running rest, when adjusted by +15 s and −15 s, '
        'then its end moves accordingly', () async {
      final set = await startAndFirstSet();
      await repository.setCompleted(set.id, completed: true);
      final sessionId = (await active()).id;

      await repository.adjustRest(sessionId, RestTimer.adjustStep);
      expect(
        (await active()).restEndsAt,
        now.add(const Duration(seconds: 165)),
      );

      await repository.adjustRest(sessionId, -RestTimer.adjustStep);
      expect(
        (await active()).restEndsAt,
        now.add(const Duration(seconds: 150)),
      );
    });

    test('given 10 s of rest left, when reduced by 15 s, '
        'then the rest ends', () async {
      final set = await startAndFirstSet();
      await repository.setCompleted(set.id, completed: true);
      advance(const Duration(seconds: 140));

      await repository.adjustRest((await active()).id, -RestTimer.adjustStep);

      expect((await active()).restEndsAt, isNull);
    });

    test('given a rest that already ended, when adjusted, '
        'then nothing changes', () async {
      final set = await startAndFirstSet();
      await repository.setCompleted(set.id, completed: true);
      final endsAt = (await active()).restEndsAt;
      advance(const Duration(seconds: 200));

      await repository.adjustRest((await active()).id, RestTimer.adjustStep);

      expect((await active()).restEndsAt, endsAt);
    });

    test('given a running rest, when skipped, then it ends', () async {
      final set = await startAndFirstSet();
      await repository.setCompleted(set.id, completed: true);

      await repository.skipRest((await active()).id);

      expect((await active()).restEndsAt, isNull);
    });

    test('given a running rest, when the session is paused, '
        'then the rest ends', () async {
      final set = await startAndFirstSet();
      await repository.setCompleted(set.id, completed: true);

      await repository.pause((await active()).id);

      expect((await active()).restEndsAt, isNull);
    });

    test('given a running rest, when the session is finished, '
        'then the stored session has no rest', () async {
      final set = await startAndFirstSet();
      await repository.setCompleted(set.id, completed: true);
      final sessionId = (await active()).id;

      await repository.finish(sessionId);

      final row = await (db.select(
        db.workoutSessions,
      )..where((s) => s.id.equals(sessionId))).getSingle();
      expect(row.restEndsAt, isNull);
    });

    test('given a finished session, when its rest is adjusted, '
        'then it is rejected', () async {
      final session = await repository.startFree();
      await repository.finish(session.id);

      expect(
        () => repository.adjustRest(session.id, RestTimer.adjustStep),
        throwsA(isA<SessionNotInProgressException>()),
      );
      expect(
        () => repository.skipRest(session.id),
        throwsA(isA<SessionNotInProgressException>()),
      );
    });
  });

  group('summary', () {
    test('given a finished session, when loaded by id, '
        'then it comes with its names, exercises and sets', () async {
      final day = await createDay();
      final started = await repository.startFromRoutineDay(day.id);
      advance(const Duration(minutes: 45));
      await completeAndFinish();

      final session = (await repository.getSession(started.id))!;

      expect(session.status, SessionStatus.completed);
      expect(session.endedAt, now);
      expect((session.routineName, session.routineDayName), ('PPL', 'Push'));
      expect(session.exercises, hasLength(2));
      expect(session.completedSets, session.totalSets);
    });

    test('given an unknown id, when loaded, then it is null', () async {
      expect(await repository.getSession('missing'), isNull);
    });

    test(
      'given earlier sessions of the day, when the previous one is '
      'looked up, then the latest finished one before it is returned',
      () async {
        final day = await createDay();
        final first = await repository.startFromRoutineDay(day.id);
        await completeAndFinish();
        advance(const Duration(days: 2));
        final second = await repository.startFromRoutineDay(day.id);
        await completeAndFinish();
        advance(const Duration(days: 2));
        final discarded = await repository.startFromRoutineDay(day.id);
        await repository.discard(discarded.id);
        advance(const Duration(days: 2));
        final current = await repository.startFromRoutineDay(day.id);
        await completeAndFinish();
        final stored = (await repository.getSession(current.id))!;

        final previous = await repository.previousSessionOf(stored);

        expect(previous?.id, second.id);
        expect(previous?.completedSets, previous?.totalSets);
        expect((await repository.previousSessionOf(previous!))?.id, first.id);
      },
    );

    test('given the first session of a day, when the previous one is '
        'looked up, then it is null', () async {
      final day = await createDay();
      final session = await repository.startFromRoutineDay(day.id);
      await completeAndFinish();

      expect(await repository.previousSessionOf(session), isNull);
    });

    test('given a demo session of the day, when the previous one is '
        'looked up, then it is ignored', () async {
      final day = await createDay();
      await db
          .into(db.workoutSessions)
          .insert(
            WorkoutSessionsCompanion.insert(
              routineDayId: Value(day.id),
              startedAt: now.subtract(const Duration(days: 1)),
              status: const Value(SessionStatus.completed),
              isDemo: const Value(true),
            ),
          );
      final session = await repository.startFromRoutineDay(day.id);
      await completeAndFinish();

      expect(await repository.previousSessionOf(session), isNull);
    });

    test('given a free session, when the previous one is looked up, '
        'then it is null', () async {
      await repository.startFree();
      await completeAndFinish();
      advance(const Duration(days: 1));
      final session = await repository.startFree();

      expect(await repository.previousSessionOf(session), isNull);
    });
  });
}
