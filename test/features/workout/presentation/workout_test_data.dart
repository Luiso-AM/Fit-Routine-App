import 'package:app_entrenamiento/core/units/weight_unit.dart';
import 'package:app_entrenamiento/features/exercises/domain/enums/difficulty.dart';
import 'package:app_entrenamiento/features/exercises/domain/enums/equipment.dart';
import 'package:app_entrenamiento/features/exercises/domain/enums/exercise_type.dart';
import 'package:app_entrenamiento/features/exercises/domain/enums/muscle_group.dart';
import 'package:app_entrenamiento/features/exercises/domain/exercise.dart';
import 'package:app_entrenamiento/features/routines/domain/routine.dart';
import 'package:app_entrenamiento/features/workout/domain/workout_session.dart';

const bench = Exercise(
  id: 'bench',
  name: 'Press de Banca (Barra)',
  primaryMuscle: MuscleGroup.chest,
  type: ExerciseType.compound,
  equipment: Equipment.barbell,
  difficulty: Difficulty.intermediate,
);
const fly = Exercise(
  id: 'fly',
  name: 'Aperturas (Polea)',
  primaryMuscle: MuscleGroup.chest,
  type: ExerciseType.isolation,
  equipment: Equipment.cable,
  difficulty: Difficulty.beginner,
  preferredUnit: WeightUnit.lb,
);
const workoutExercises = [bench, fly];

/// "PPL" with a "Push" day: bench 3 × 6–8 from 60 kg.
final Routine pushRoutine = Routine(
  id: 'r1',
  name: 'PPL',
  days: [
    RoutineDay(
      id: 'd1',
      routineId: 'r1',
      name: 'Push',
      position: 0,
      exercises: [
        RoutineExercise(
          id: 're1',
          routineDayId: 'd1',
          exerciseId: bench.id,
          position: 0,
          targetSets: 3,
          targetRepsMin: 6,
          targetRepsMax: 8,
          initialWeightKg: 60,
          restSeconds: 120,
        ),
      ],
    ),
  ],
);

/// A session in progress with bench: 2 pending sets of 8 × 60 kg.
WorkoutSession activeSession({DateTime? startedAt}) => WorkoutSession(
  id: 'w1',
  routineDayId: 'd1',
  routineName: 'PPL',
  routineDayName: 'Push',
  startedAt: startedAt ?? DateTime.utc(2026, 11, 14, 9, 30),
  exercises: [
    SessionExercise(
      id: 'se1',
      sessionId: 'w1',
      exerciseId: bench.id,
      position: 0,
      targetSets: 2,
      targetRepsMin: 6,
      targetRepsMax: 8,
      restSeconds: 120,
      sets: const [
        SetEntry(
          id: 's1',
          sessionExerciseId: 'se1',
          setNumber: 1,
          weightKg: 60,
          reps: 8,
        ),
        SetEntry(
          id: 's2',
          sessionExerciseId: 'se1',
          setNumber: 2,
          weightKg: 60,
          reps: 8,
        ),
      ],
    ),
  ],
);
