import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/widgets/exercise_picker.dart';
import '../../../exercises/domain/enums/muscle_group.dart';
import '../../../exercises/domain/exercise.dart';
import '../routine_providers.dart';
import '../widgets/routine_widgets.dart';

/// Picks exercises to add to a routine day. Pops with the selected ids, in
/// the order they were picked.
///
/// The muscle filter starts with the muscles the day already works.
class ExercisePickerScreen extends ConsumerWidget {
  const ExercisePickerScreen({
    required this.routineId,
    required this.dayId,
    super.key,
  });

  final String routineId;
  final String dayId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routine = ref.watch(routineByIdProvider(routineId));
    final catalog = ref.watch(exerciseCatalogProvider);

    // Wait for both, so the day's muscles are known when the list shows.
    final exercises = switch ((routine, catalog)) {
      (AsyncError(:final error, :final stackTrace), _) ||
      (
        _,
        AsyncError(:final error, :final stackTrace),
      ) => AsyncError<List<Exercise>>(error, stackTrace),
      (AsyncData(), AsyncData(value: final catalog)) => AsyncData(
        catalog.values.toList(),
      ),
      _ => const AsyncLoading<List<Exercise>>(),
    };
    final day = routine.value?.dayById(dayId);
    final muscles = day == null || !catalog.hasValue
        ? <MuscleGroup>{}
        : dayMuscles(day, catalog.requireValue).toSet();

    return ExercisePicker(exercises: exercises, initialMuscles: muscles);
  }
}
