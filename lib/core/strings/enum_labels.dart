import '../../features/exercises/domain/enums/difficulty.dart';
import '../../features/exercises/domain/enums/equipment.dart';
import '../../features/exercises/domain/enums/exercise_type.dart';
import '../../features/exercises/domain/enums/muscle_group.dart';
import '../../features/profile/domain/enums/experience_level.dart';
import '../../features/profile/domain/enums/sex.dart';
import '../../features/profile/domain/enums/training_goal.dart';
import '../../features/routines/domain/enums/routine_template_type.dart';

// Spanish labels for domain enums. They live in `core` because several
// features (exercises, profile, routines, workout) display them.

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

extension SexLabel on Sex {
  String get label => switch (this) {
    Sex.male => 'Hombre',
    Sex.female => 'Mujer',
  };
}

extension ExperienceLevelLabel on ExperienceLevel {
  String get label => switch (this) {
    ExperienceLevel.beginner => 'Principiante',
    ExperienceLevel.intermediate => 'Intermedio',
    ExperienceLevel.advanced => 'Avanzado',
  };
}

extension TrainingGoalLabel on TrainingGoal {
  String get label => switch (this) {
    TrainingGoal.hypertrophy => 'Ganar masa muscular',
    TrainingGoal.strength => 'Ganar fuerza',
    TrainingGoal.fatLoss => 'Perder grasa',
    TrainingGoal.recomposition => 'Recomposición corporal',
    TrainingGoal.maintenance => 'Mantenerme en forma',
  };
}

extension RoutineTemplateTypeLabel on RoutineTemplateType {
  String get label => switch (this) {
    RoutineTemplateType.fullBody => 'Full Body',
    RoutineTemplateType.upperLower => 'Upper / Lower',
    RoutineTemplateType.pushPullLegs => 'Push / Pull / Legs',
  };

  String get description => switch (this) {
    RoutineTemplateType.fullBody =>
      'Todo el cuerpo en cada sesión. 3 días por semana.',
    RoutineTemplateType.upperLower =>
      'Tren superior e inferior (torso / pierna) alternados. 4 días.',
    RoutineTemplateType.pushPullLegs =>
      'Empuje, tirón y pierna. 3 días, o 6 repitiendo el ciclo.',
  };
}
