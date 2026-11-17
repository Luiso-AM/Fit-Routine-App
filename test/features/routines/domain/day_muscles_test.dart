import 'package:app_entrenamiento/features/exercises/domain/enums/difficulty.dart';
import 'package:app_entrenamiento/features/exercises/domain/enums/equipment.dart';
import 'package:app_entrenamiento/features/exercises/domain/enums/exercise_type.dart';
import 'package:app_entrenamiento/features/exercises/domain/enums/muscle_group.dart';
import 'package:app_entrenamiento/features/exercises/domain/exercise.dart';
import 'package:app_entrenamiento/features/routines/domain/day_muscles.dart';
import 'package:app_entrenamiento/features/routines/domain/routine.dart';
import 'package:flutter_test/flutter_test.dart';

Exercise _exercise(String id, MuscleGroup muscle) => Exercise(
  id: id,
  name: id,
  primaryMuscle: muscle,
  type: ExerciseType.compound,
  equipment: Equipment.barbell,
  difficulty: Difficulty.beginner,
);

RoutineExercise _planned(String exerciseId, int position) => RoutineExercise(
  id: 're-$position',
  routineDayId: 'd',
  exerciseId: exerciseId,
  position: position,
  targetSets: 3,
  targetRepsMin: 8,
  targetRepsMax: 10,
  restSeconds: 90,
);

void main() {
  test('given a day with repeated and missing exercises, when its muscles '
      'are derived, then each known muscle appears once in enum order', () {
    final catalog = {
      for (final e in [
        _exercise('row', MuscleGroup.back),
        _exercise('bench', MuscleGroup.chest),
        _exercise('incline', MuscleGroup.chest),
      ])
        e.id: e,
    };
    final day = RoutineDay(
      id: 'd',
      routineId: 'r',
      name: 'Upper',
      position: 0,
      exercises: [
        _planned('row', 0),
        _planned('bench', 1),
        _planned('incline', 2),
        _planned('deleted', 3),
      ],
    );

    final muscles = dayMuscles(day, catalog);

    expect(muscles, {MuscleGroup.back, MuscleGroup.chest});
    expect(muscles, hasLength(2));
    expect(muscles, [...muscles]..sort((a, b) => a.index.compareTo(b.index)));
  });
}
