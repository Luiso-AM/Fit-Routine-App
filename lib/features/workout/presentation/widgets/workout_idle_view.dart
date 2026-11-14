import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/strings/app_strings.dart';
import '../../../routines/domain/routine.dart';
import '../workout_actions.dart';
import '../workout_providers.dart';
import '../workout_strings.dart';
import 'workout_widgets.dart';

/// Workout tab without a session in progress: start a free session or one
/// from a routine day.
class WorkoutIdleView extends ConsumerWidget {
  const WorkoutIdleView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final routines = ref.watch(workoutRoutinesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.tabWorkout)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    WorkoutStrings.freeSession,
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    WorkoutStrings.freeSessionHint,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 12),
                  FilledButton.tonalIcon(
                    style: FilledButton.styleFrom(
                      minimumSize: const Size(0, 48),
                    ),
                    onPressed: () => startWorkout(context, ref),
                    icon: const Icon(Icons.play_arrow),
                    label: const Text(WorkoutStrings.startFreeSession),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 20, 4, 8),
            child: Text(
              WorkoutStrings.fromRoutine,
              style: theme.textTheme.titleSmall?.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
          ),
          ...switch (routines.whenData(
            (all) => [
              for (final r in all)
                if (r.days.isNotEmpty) r,
            ],
          )) {
            AsyncData(value: final routines) when routines.isEmpty => [
              const WorkoutMessage(WorkoutStrings.noRoutines),
            ],
            AsyncData(value: final routines) => [
              for (final routine in routines) _RoutineCard(routine: routine),
            ],
            AsyncError() => [const WorkoutMessage(WorkoutStrings.loadError)],
            _ => [const Center(child: CircularProgressIndicator())],
          },
        ],
      ),
    );
  }
}

class _RoutineCard extends ConsumerWidget {
  const _RoutineCard({required this.routine});

  final Routine routine;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final today = DateTime.now().weekday;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: Text(routine.name, style: theme.textTheme.titleMedium),
          ),
          for (final day in routine.days)
            ListTile(
              minTileHeight: 56,
              title: Text(day.name),
              subtitle: Text(
                WorkoutStrings.exercisesCount(day.exercises.length),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (day.weekday == today) ...[
                    _TodayBadge(theme: theme),
                    const SizedBox(width: 8),
                  ],
                  Icon(Icons.play_arrow, color: theme.colorScheme.primary),
                ],
              ),
              onTap: () => startWorkout(context, ref, routineDayId: day.id),
            ),
        ],
      ),
    );
  }
}

class _TodayBadge extends StatelessWidget {
  const _TodayBadge({required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        WorkoutStrings.today,
        style: theme.textTheme.labelSmall?.copyWith(
          color: theme.colorScheme.primary,
        ),
      ),
    );
  }
}
