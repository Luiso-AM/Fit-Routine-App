import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/utils/duration_format.dart';
import '../../data/workout_data_providers.dart';
import '../../domain/rest_timer.dart';
import '../../domain/workout_session.dart';
import '../workout_actions.dart';
import '../workout_providers.dart';
import '../workout_strings.dart';

/// Countdown of the running rest, with buttons to adjust or skip it.
///
/// Shows nothing when no rest is running. The countdown is computed from
/// the stored end time, so it is right after the app was in the
/// background or restarted.
class RestTimerBar extends ConsumerWidget {
  const RestTimerBar({required this.session, super.key});

  final WorkoutSession session;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = ref.watch(clockProvider).value ?? DateTime.now().toUtc();
    final endsAt = session.restEndsAt;
    final running = RestTimer.isRunning(endsAt, now);

    return AnimatedSize(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      alignment: Alignment.bottomCenter,
      child: running
          ? _RestCard(
              sessionId: session.id,
              remaining: RestTimer.remaining(endsAt!, now),
            )
          : const SizedBox(width: double.infinity),
    );
  }
}

class _RestCard extends ConsumerWidget {
  const _RestCard({required this.sessionId, required this.remaining});

  final String sessionId;
  final Duration remaining;

  Future<void> _adjust(BuildContext context, WidgetRef ref, Duration delta) =>
      guardWorkout(
        context,
        () => ref.read(workoutRepositoryProvider).adjustRest(sessionId, delta),
      );

  Future<void> _skip(BuildContext context, WidgetRef ref) => guardWorkout(
    context,
    () => ref.read(workoutRepositoryProvider).skipRest(sessionId),
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final buttonStyle = TextButton.styleFrom(minimumSize: const Size(0, 48));

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Card(
        margin: EdgeInsets.zero,
        color: colors.surfaceContainerHigh,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Icon(Icons.timer_outlined, color: colors.primary),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      WorkoutStrings.rest,
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ),
                  Text(
                    formatClock(remaining),
                    key: const Key('rest-countdown'),
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontFeatures: const [FontFeature.tabularFigures()],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Tooltip(
                      message: WorkoutStrings.restLessTooltip,
                      child: TextButton(
                        style: buttonStyle,
                        onPressed: () =>
                            _adjust(context, ref, -RestTimer.adjustStep),
                        child: const Text(WorkoutStrings.restLess),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Tooltip(
                      message: WorkoutStrings.restMoreTooltip,
                      child: TextButton(
                        style: buttonStyle,
                        onPressed: () =>
                            _adjust(context, ref, RestTimer.adjustStep),
                        child: const Text(WorkoutStrings.restMore),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      style: buttonStyle,
                      onPressed: () => _skip(context, ref),
                      child: const Text(WorkoutStrings.skipRest),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
