import 'package:app_entrenamiento/core/units/weight_unit.dart';
import 'package:app_entrenamiento/features/exercises/domain/enums/difficulty.dart';
import 'package:app_entrenamiento/features/exercises/domain/enums/equipment.dart';
import 'package:app_entrenamiento/features/exercises/domain/enums/exercise_type.dart';
import 'package:app_entrenamiento/features/exercises/domain/enums/muscle_group.dart';
import 'package:app_entrenamiento/features/exercises/domain/exercise.dart';
import 'package:app_entrenamiento/features/routines/domain/routine.dart';
import 'package:app_entrenamiento/features/workout/domain/enums/session_status.dart';
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

/// A finished session of the "Push" day (or a free one, without
/// [routineDayId]), lasting [minutes], with one exercise whose
/// (weight in kg, reps) [sets] are completed, followed by its
/// [pendingSets].
WorkoutSession finishedSession({
  required String id,
  required DateTime startedAt,
  required int minutes,
  required List<(double, int)> sets,
  List<(double, int)> pendingSets = const [],
  String? routineDayId = 'd1',
  String exerciseId = 'bench',
  String notes = '',
}) => WorkoutSession(
  id: id,
  routineDayId: routineDayId,
  routineName: routineDayId == null ? null : 'PPL',
  routineDayName: routineDayId == null ? null : 'Push',
  startedAt: startedAt,
  endedAt: startedAt.add(Duration(minutes: minutes)),
  status: SessionStatus.completed,
  notes: notes,
  exercises: [
    SessionExercise(
      id: '$id-e',
      sessionId: id,
      exerciseId: exerciseId,
      position: 0,
      sets: [
        for (final (i, (weightKg, reps)) in [...sets, ...pendingSets].indexed)
          SetEntry(
            id: '$id-s$i',
            sessionExerciseId: '$id-e',
            setNumber: i + 1,
            weightKg: weightKg,
            reps: reps,
            isCompleted: i < sets.length,
          ),
      ],
    ),
  ],
);
