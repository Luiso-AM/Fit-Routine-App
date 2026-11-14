import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/widgets/exercise_picker.dart';
import '../workout_providers.dart';

/// Picks exercises to add to the session. Pops with the selected ids.
class WorkoutExercisePickerScreen extends ConsumerWidget {
  const WorkoutExercisePickerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catalog = ref.watch(workoutExerciseCatalogProvider);
    return ExercisePicker(
      exercises: catalog.whenData((byId) => byId.values.toList()),
    );
  }
}
