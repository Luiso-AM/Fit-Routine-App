import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/utils/text_normalize.dart';
import 'enums/equipment.dart';
import 'enums/exercise_type.dart';
import 'enums/muscle_group.dart';
import 'exercise.dart';

part 'exercise_query.freezed.dart';

/// Search text and filters for the exercise library.
///
/// Filters of different kinds are combined with AND; values of the same
/// kind with OR. An empty set means "no filter".
@freezed
abstract class ExerciseQuery with _$ExerciseQuery {
  const factory ExerciseQuery({
    @Default('') String text,
    @Default(<MuscleGroup>{}) Set<MuscleGroup> muscles,
    @Default(<Equipment>{}) Set<Equipment> equipment,
    @Default(<ExerciseType>{}) Set<ExerciseType> types,
  }) = _ExerciseQuery;

  const ExerciseQuery._();

  int get activeFilterCount => muscles.length + equipment.length + types.length;

  bool get isEmpty => text.trim().isEmpty && activeFilterCount == 0;

  /// The muscle filter matches the primary muscle only, consistent with how
  /// the library is grouped.
  bool matches(Exercise exercise) {
    final needle = normalizeText(text);
    if (needle.isNotEmpty && !normalizeText(exercise.name).contains(needle)) {
      return false;
    }
    if (muscles.isNotEmpty && !muscles.contains(exercise.primaryMuscle)) {
      return false;
    }
    if (equipment.isNotEmpty && !equipment.contains(exercise.equipment)) {
      return false;
    }
    if (types.isNotEmpty && !types.contains(exercise.type)) return false;
    return true;
  }

  List<Exercise> apply(Iterable<Exercise> exercises) =>
      exercises.where(matches).toList();
}

/// Groups [exercises] by primary muscle, in [MuscleGroup] order, sorted by
/// name within each group. Muscles without exercises are omitted.
Map<MuscleGroup, List<Exercise>> groupByPrimaryMuscle(
  Iterable<Exercise> exercises,
) {
  final groups = <MuscleGroup, List<Exercise>>{
    for (final muscle in MuscleGroup.values) muscle: [],
  };
  for (final exercise in exercises) {
    groups[exercise.primaryMuscle]!.add(exercise);
  }
  groups.removeWhere((_, list) => list.isEmpty);
  for (final list in groups.values) {
    list.sort((a, b) => normalizeText(a.name).compareTo(normalizeText(b.name)));
  }
  return groups;
}
