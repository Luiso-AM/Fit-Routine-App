import 'enums/routine_template_type.dart';

/// A predefined routine the user can start from.
class RoutineTemplate {
  const RoutineTemplate({
    required this.type,
    required this.name,
    required this.days,
  });

  final RoutineTemplateType type;

  /// Name given to the routine created from this template.
  final String name;
  final List<RoutineTemplateDay> days;
}

class RoutineTemplateDay {
  const RoutineTemplateDay({required this.name, required this.exerciseIds});

  final String name;

  /// Seed exercises, in order. Targets come from
  /// `RoutineExerciseDraft.defaultsFor` the exercise's type.
  final List<String> exerciseIds;
}
