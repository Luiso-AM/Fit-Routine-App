import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/exercise_data_providers.dart';
import '../domain/enums/equipment.dart';
import '../domain/enums/exercise_type.dart';
import '../domain/enums/muscle_group.dart';
import '../domain/exercise.dart';
import '../domain/exercise_query.dart';

part 'exercise_providers.g.dart';

@riverpod
Stream<List<Exercise>> exercises(Ref ref) =>
    ref.watch(exerciseRepositoryProvider).watchAll();

@riverpod
Stream<Exercise?> exerciseById(Ref ref, String id) =>
    ref.watch(exerciseRepositoryProvider).watchById(id);

/// Search text and filters of the library screen.
@riverpod
class ExerciseQueryController extends _$ExerciseQueryController {
  @override
  ExerciseQuery build() => const ExerciseQuery();

  void setText(String text) => state = state.copyWith(text: text);

  void toggleMuscle(MuscleGroup muscle) =>
      state = state.copyWith(muscles: _toggle(state.muscles, muscle));

  void toggleEquipment(Equipment equipment) =>
      state = state.copyWith(equipment: _toggle(state.equipment, equipment));

  void toggleType(ExerciseType type) =>
      state = state.copyWith(types: _toggle(state.types, type));

  void clearFilters() =>
      state = state.copyWith(muscles: {}, equipment: {}, types: {});

  void clearAll() => state = const ExerciseQuery();

  static Set<T> _toggle<T>(Set<T> values, T value) => values.contains(value)
      ? ({...values}..remove(value))
      : {...values, value};
}

/// Exercises matching the current query, grouped by primary muscle.
@riverpod
AsyncValue<Map<MuscleGroup, List<Exercise>>> filteredExerciseGroups(Ref ref) {
  final query = ref.watch(exerciseQueryControllerProvider);
  return ref
      .watch(exercisesProvider)
      .whenData((all) => groupByPrimaryMuscle(query.apply(all)));
}
