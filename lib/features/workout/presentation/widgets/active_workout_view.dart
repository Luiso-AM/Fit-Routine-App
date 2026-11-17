import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/utils/duration_format.dart';
import '../../../../core/widgets/confirm_dialog.dart';
import '../../../../core/widgets/keep_screen_on.dart';
import '../../data/workout_data_providers.dart';
import '../../domain/workout_repository.dart';
import '../../domain/workout_session.dart';
import '../workout_actions.dart';
import '../workout_providers.dart';
import '../workout_strings.dart';
import 'rest_timer_bar.dart';
import 'session_exercise_card.dart';
import 'workout_widgets.dart';

enum _MenuAction { discard }

/// The session in progress: clock, progress, exercises and their sets.
///
/// Main actions sit at the bottom, within reach of one thumb.
class ActiveWorkoutView extends ConsumerWidget {
  const ActiveWorkoutView({required this.session, super.key});

  final WorkoutSession session;

  WorkoutRepository _repository(WidgetRef ref) =>
      ref.read(workoutRepositoryProvider);

  Future<void> _addExercises(BuildContext context, WidgetRef ref) async {
    final ids = await context.push<List<String>>(AppRoutes.workoutAddExercises);
    if (ids == null || ids.isEmpty || !context.mounted) return;
    final catalog = ref.read(workoutExerciseCatalogProvider).value ?? {};
    final exercises = [for (final id in ids) ?catalog[id]];
    await guardWorkout(
      context,
      () => _repository(ref).addExercises(session.id, exercises),
    );
  }

  Future<void> _togglePause(BuildContext context, WidgetRef ref) =>
      guardWorkout(
        context,
        () => session.isPaused
            ? _repository(ref).resume(session.id)
            : _repository(ref).pause(session.id),
      );

  Future<void> _finish(BuildContext context, WidgetRef ref) async {
    final pending = session.totalSets - session.completedSets;
    final confirmed = await showConfirmDialog(
      context,
      title: WorkoutStrings.finishTitle,
      message: pending == 0
          ? WorkoutStrings.finishMessage
          : WorkoutStrings.finishPendingMessage(pending),
      confirmLabel: WorkoutStrings.finish,
      cancelLabel: WorkoutStrings.cancel,
    );
    if (!confirmed || !context.mounted) return;
    // This view goes away once the session ends; keep the router.
    final router = GoRouter.of(context);
    final done = await guardWorkout(
      context,
      () => _repository(ref).finish(session.id),
    );
    if (done) unawaited(router.push(AppRoutes.workoutSummary(session.id)));
  }

  Future<void> _discard(BuildContext context, WidgetRef ref) async {
    final confirmed = await showConfirmDialog(
      context,
      title: WorkoutStrings.discardTitle,
      message: WorkoutStrings.discardMessage,
      confirmLabel: WorkoutStrings.discard,
      cancelLabel: WorkoutStrings.cancel,
    );
    if (!confirmed || !context.mounted) return;
    final messenger = ScaffoldMessenger.of(context);
    final done = await guardWorkout(
      context,
      () => _repository(ref).discard(session.id),
    );
    if (done) {
      messenger.showSnackBar(
        const SnackBar(content: Text(WorkoutStrings.discarded)),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final catalog = ref.watch(workoutExerciseCatalogProvider).value ?? {};
    final routineName = session.routineName;

    return KeepScreenOn(
      child: Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(session.routineDayName ?? WorkoutStrings.freeSession),
              if (routineName != null)
                Text(
                  routineName,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
            ],
          ),
          actions: [
            PopupMenuButton<_MenuAction>(
              tooltip: WorkoutStrings.more,
              onSelected: (action) => switch (action) {
                _MenuAction.discard => _discard(context, ref),
              },
              itemBuilder: (context) => const [
                PopupMenuItem(
                  value: _MenuAction.discard,
                  child: Text(WorkoutStrings.discard),
                ),
              ],
            ),
          ],
        ),
        body: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              sliver: SliverToBoxAdapter(
                child: _SessionHeader(session: session),
              ),
            ),
            if (session.exercises.isEmpty)
              const SliverFillRemaining(
                hasScrollBody: false,
                child: WorkoutMessage(WorkoutStrings.noExercises),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverList.builder(
                  itemCount: session.exercises.length,
                  itemBuilder: (context, i) {
                    final entry = session.exercises[i];
                    return Padding(
                      key: ValueKey(entry.id),
                      padding: const EdgeInsets.only(bottom: 12),
                      child: SessionExerciseCard(
                        entry: entry,
                        exercise: catalog[entry.exerciseId],
                      ),
                    );
                  },
                ),
              ),
            const SliverPadding(padding: EdgeInsets.only(bottom: 16)),
          ],
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RestTimerBar(session: session),
                Row(
                  children: [
                    IconButton.filled(
                      style: neutralIconButtonStyle(theme),
                      constraints: const BoxConstraints.tightFor(
                        width: 52,
                        height: 52,
                      ),
                      tooltip: session.isPaused
                          ? WorkoutStrings.resume
                          : WorkoutStrings.pause,
                      onPressed: () => _togglePause(context, ref),
                      icon: Icon(
                        session.isPaused ? Icons.play_arrow : Icons.pause,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(0, 52),
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                        ),
                        onPressed: () => _addExercises(context, ref),
                        child: const Text(WorkoutStrings.addExercise),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          minimumSize: const Size(0, 52),
                        ),
                        onPressed: () => _finish(context, ref),
                        child: const Text(WorkoutStrings.finish),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Running clock and completed sets.
class _SessionHeader extends ConsumerWidget {
  const _SessionHeader({required this.session});

  final WorkoutSession session;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final now = ref.watch(clockProvider).value ?? DateTime.now().toUtc();
    final muted = theme.textTheme.bodySmall?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(WorkoutStrings.duration, style: muted),
                      Text(
                        formatClock(session.activeDuration(now)),
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontFeatures: const [FontFeature.tabularFigures()],
                        ),
                      ),
                    ],
                  ),
                ),
                if (session.isPaused)
                  Chip(
                    avatar: const Icon(Icons.pause, size: 18),
                    label: const Text(WorkoutStrings.paused),
                    side: BorderSide(color: theme.colorScheme.secondary),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: session.progress,
                      minHeight: 8,
                      backgroundColor: theme.colorScheme.surfaceContainerHigh,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  WorkoutStrings.setsProgress(
                    session.completedSets,
                    session.totalSets,
                  ),
                  style: muted,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
