import '../../features/exercises/domain/enums/difficulty.dart';
import '../../features/exercises/domain/enums/equipment.dart';
import '../../features/exercises/domain/enums/exercise_type.dart';
import '../../features/exercises/domain/enums/muscle_group.dart';

// Spanish labels for domain enums. They live in `core` because several
// features (exercises, routines, workout) display them.

extension MuscleGroupLabel on MuscleGroup {
  String get label => switch (this) {
    MuscleGroup.chest => 'Pecho',
    MuscleGroup.back => 'Espalda',
    MuscleGroup.shoulders => 'Hombros',
    MuscleGroup.biceps => 'Bíceps',
    MuscleGroup.triceps => 'Tríceps',
    MuscleGroup.forearms => 'Antebrazos',
    MuscleGroup.quadriceps => 'Cuádriceps',
    MuscleGroup.hamstrings => 'Isquiotibiales',
    MuscleGroup.glutes => 'Glúteos',
    MuscleGroup.calves => 'Pantorrillas',
    MuscleGroup.abs => 'Abdomen',
  };
}

extension EquipmentLabel on Equipment {
  String get label => switch (this) {
    Equipment.barbell => 'Barra',
    Equipment.ezBar => 'Barra EZ',
    Equipment.dumbbell => 'Mancuerna',
    Equipment.kettlebell => 'Kettlebell',
    Equipment.machine => 'Máquina',
    Equipment.smithMachine => 'Máquina Smith',
    Equipment.cable => 'Polea',
    Equipment.resistanceBand => 'Banda elástica',
    Equipment.bodyweight => 'Peso corporal',
  };
}

extension ExerciseTypeLabel on ExerciseType {
  String get label => switch (this) {
    ExerciseType.compound => 'Compuesto',
    ExerciseType.isolation => 'Aislamiento',
  };
}

extension DifficultyLabel on Difficulty {
  String get label => switch (this) {
    Difficulty.beginner => 'Principiante',
    Difficulty.intermediate => 'Intermedio',
    Difficulty.advanced => 'Avanzado',
  };
}
