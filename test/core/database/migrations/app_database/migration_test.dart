// dart format width=80
// ignore_for_file: unused_local_variable, unused_import
import 'package:drift/drift.dart';
import 'package:drift_dev/api/migrations_native.dart';
import 'package:app_entrenamiento/core/database/app_database.dart';
import 'package:flutter_test/flutter_test.dart';

import 'generated/schema.dart';

import 'generated/schema_v1.dart' as v1;
import 'generated/schema_v2.dart' as v2;
import 'generated/schema_v3.dart' as v3;

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  late SchemaVerifier verifier;

  setUpAll(() {
    verifier = SchemaVerifier(GeneratedHelper());
  });

  group('simple database migrations', () {
    // These simple tests verify all possible schema updates with a simple (no
    // data) migration. This is a quick way to ensure that written database
    // migrations properly alter the schema.
    const versions = GeneratedHelper.versions;
    for (final (i, fromVersion) in versions.indexed) {
      group('from $fromVersion', () {
        for (final toVersion in versions.skip(i + 1)) {
          test('to $toVersion', () async {
            final schema = await verifier.schemaAt(fromVersion);
            final db = AppDatabase(schema.newConnection());
            await verifier.migrateAndValidate(db, toVersion);
            await db.close();
          });
        }
      });
    }
  });

  test('given a v1 database with a session exercise, '
      'when migrated to v2, '
      'then its rows are kept and the new targets are null', () async {
    const ts = '2026-01-10T10:00:00.000Z';
    const exercise = v1.ExercisesData(
      id: 'e1',
      createdAt: ts,
      updatedAt: ts,
      name: 'Press banca',
      primaryMuscle: 'chest',
      secondaryMuscles: '[]',
      type: 'compound',
      equipment: 'barbell',
      difficulty: 'intermediate',
      instructions: '',
      commonMistakes: '',
      preferredUnit: 'kg',
      isCustom: 0,
      isSeed: 1,
    );
    const session = v1.WorkoutSessionsData(
      id: 's1',
      createdAt: ts,
      updatedAt: ts,
      startedAt: ts,
      pausedTotalSeconds: 0,
      status: 'completed',
      notes: '',
      isDemo: 0,
    );
    const oldSessionExercise = v1.SessionExercisesData(
      id: 'se1',
      createdAt: ts,
      updatedAt: ts,
      sessionId: 's1',
      exerciseId: 'e1',
      position: 0,
      notes: 'nota',
    );
    const expectedSessionExercise = v2.SessionExercisesData(
      id: 'se1',
      createdAt: ts,
      updatedAt: ts,
      sessionId: 's1',
      exerciseId: 'e1',
      position: 0,
      notes: 'nota',
    );

    await verifier.testWithDataIntegrity(
      oldVersion: 1,
      newVersion: 2,
      createOld: v1.DatabaseAtV1.new,
      createNew: v2.DatabaseAtV2.new,
      openTestedDatabase: AppDatabase.new,
      createItems: (batch, oldDb) {
        batch
          ..insert(oldDb.exercises, exercise)
          ..insert(oldDb.workoutSessions, session)
          ..insert(oldDb.sessionExercises, oldSessionExercise);
      },
      validateItems: (newDb) async {
        expect(await newDb.select(newDb.workoutSessions).get(), hasLength(1));
        expect(await newDb.select(newDb.sessionExercises).get(), [
          expectedSessionExercise,
        ]);
      },
    );
  });

  test('given a v2 database with a paused session, '
      'when migrated to v3, '
      'then the session is kept without a rest timer', () async {
    const ts = '2026-01-10T10:00:00.000Z';
    const oldSession = v2.WorkoutSessionsData(
      id: 's1',
      createdAt: ts,
      updatedAt: ts,
      startedAt: ts,
      pausedTotalSeconds: 30,
      pausedAt: ts,
      status: 'inProgress',
      notes: 'nota',
      isDemo: 0,
    );
    const expectedSession = v3.WorkoutSessionsData(
      id: 's1',
      createdAt: ts,
      updatedAt: ts,
      startedAt: ts,
      pausedTotalSeconds: 30,
      pausedAt: ts,
      status: 'inProgress',
      notes: 'nota',
      isDemo: 0,
    );

    await verifier.testWithDataIntegrity(
      oldVersion: 2,
      newVersion: 3,
      createOld: v2.DatabaseAtV2.new,
      createNew: v3.DatabaseAtV3.new,
      openTestedDatabase: AppDatabase.new,
      createItems: (batch, oldDb) {
        batch.insert(oldDb.workoutSessions, oldSession);
      },
      validateItems: (newDb) async {
        expect(await newDb.select(newDb.workoutSessions).get(), [
          expectedSession,
        ]);
      },
    );
  });
}
