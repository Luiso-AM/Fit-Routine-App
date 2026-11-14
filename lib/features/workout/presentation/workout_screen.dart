import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/strings/app_strings.dart';
import 'widgets/active_workout_view.dart';
import 'widgets/workout_idle_view.dart';
import 'widgets/workout_widgets.dart';
import 'workout_providers.dart';
import 'workout_strings.dart';

/// Workout tab: the session in progress, or the ways to start one.
class WorkoutScreen extends ConsumerWidget {
  const WorkoutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return switch (ref.watch(activeWorkoutProvider)) {
      AsyncData(value: final session?) => ActiveWorkoutView(session: session),
      AsyncData() => const WorkoutIdleView(),
      AsyncError() => Scaffold(
        appBar: AppBar(title: const Text(AppStrings.tabWorkout)),
        body: const WorkoutMessage(WorkoutStrings.loadError),
      ),
      _ => Scaffold(
        appBar: AppBar(title: const Text(AppStrings.tabWorkout)),
        body: const Center(child: CircularProgressIndicator()),
      ),
    };
  }
}
