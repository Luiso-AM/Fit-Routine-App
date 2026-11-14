import 'package:app_entrenamiento/core/database/app_database.dart';
import 'package:app_entrenamiento/features/exercises/data/exercise_seeder.dart';
import 'package:app_entrenamiento/features/exercises/data/seed/seed_exercises.dart';
import 'package:app_entrenamiento/features/routines/data/drift_routine_repository.dart';
import 'package:app_entrenamiento/features/routines/data/routine_templates.dart';
import 'package:app_entrenamiento/features/routines/domain/enums/routine_template_type.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final seedIds = {for (final e in seedExercises) e.id};

  test('given the templates, when listed, '
      'then there is exactly one per template type', () {
    expect([
      for (final t in routineTemplates) t.type,
    ], unorderedEquals(RoutineTemplateType.values));
  });

  test('given the Upper / Lower template, when inspected, '
      'then it has four days', () {
    final upperLower = routineTemplates.firstWhere(
      (t) => t.type == RoutineTemplateType.upperLower,
    );
    expect(upperLower.days, hasLength(4));
  });

  for (final template in routineTemplates) {
    test('given the ${template.name} template, when inspected, then every '
        'day has exercises and every exercise is a seed one', () {
      expect(template.days, isNotEmpty);
      for (final day in template.days) {
        expect(day.exerciseIds, isNotEmpty, reason: day.name);
        expect(day.exerciseIds.toSet(), hasLength(day.exerciseIds.length));
        for (final id in day.exerciseIds) {
          expect(seedIds, contains(id), reason: '${day.name}: $id');
        }
      }
    });
  }

  test('given a seeded database, when every template is created, '
      'then no exercise is skipped', () async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    await ExerciseSeeder(db).run();
    final repository = DriftRoutineRepository(db);

    for (final template in routineTemplates) {
      final routine = await repository.createFromTemplate(template);
      expect(
        [for (final d in routine.days) d.exercises.length],
        [for (final d in template.days) d.exerciseIds.length],
      );
    }
  });
}
