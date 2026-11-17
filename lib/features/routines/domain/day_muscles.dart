import '../../exercises/domain/enums/muscle_group.dart';
import '../../exercises/domain/exercise.dart';
import 'routine.dart';

/// Primary muscles a day works, derived from its exercises, in
/// [MuscleGroup] order. Exercises missing from [catalog] are ignored.
List<MuscleGroup> dayMuscles(RoutineDay day, Map<String, Exercise> catalog) {
  final muscles = {
    for (final e in day.exercises) ?catalog[e.exerciseId]?.primaryMuscle,
  };
  return muscles.toList()..sort((a, b) => a.index.compareTo(b.index));
}
