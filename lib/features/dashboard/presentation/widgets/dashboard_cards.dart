import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/strings/enum_labels.dart';
import '../../../../core/units/weight_format.dart';
import '../../../../core/units/weight_unit.dart';
import '../../../../core/utils/calendar_date.dart';
import '../../../../core/utils/duration_format.dart';
import '../../../routines/domain/day_muscles.dart';
import '../../../workout/domain/workout_session.dart';
import '../../domain/next_workout.dart';
import '../../domain/weekly_activity.dart';
import '../../domain/weight_trend.dart';
import '../dashboard_providers.dart';
import '../dashboard_strings.dart';

/// A card with a small colored label on top.
class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.label, required this.child, this.onTap});

  final String label;
  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                label,
                style: theme.textTheme.labelLarge?.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 8),
              child,
            ],
          ),
        ),
      ),
    );
  }
}

TextStyle? _muted(ThemeData theme) => theme.textTheme.bodyMedium?.copyWith(
  color: theme.colorScheme.onSurfaceVariant,
);

/// The session in progress, or else the routine day to train next.
class NextWorkoutCard extends ConsumerWidget {
  const NextWorkoutCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final active = ref.watch(dashboardActiveSessionProvider);
    final routines = ref.watch(dashboardRoutinesProvider);
    final starts = ref.watch(dashboardFinishedStartsProvider);
    if (!active.hasValue || !routines.hasValue || !starts.hasValue) {
      return _SectionCard(
        label: DashboardStrings.nextWorkout,
        child: _Status(
          error: active.hasError || routines.hasError || starts.hasError,
        ),
      );
    }

    if (active.requireValue case final session?) {
      return _ActiveSession(session: session);
    }
    final next = nextWorkout(
      routines: routines.requireValue,
      finished: starts.requireValue,
      now: DateTime.now(),
    );
    if (next == null) {
      return _SectionCard(
        label: DashboardStrings.nextWorkout,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(DashboardStrings.noRoutines, style: _muted(Theme.of(context))),
            const SizedBox(height: 12),
            FilledButton(
              style: FilledButton.styleFrom(minimumSize: const Size(0, 48)),
              onPressed: () => context.go(AppRoutes.routines),
              child: const Text(DashboardStrings.goToRoutines),
            ),
          ],
        ),
      );
    }
    return _NextWorkout(next: next);
  }
}

class _ActiveSession extends StatelessWidget {
  const _ActiveSession({required this.session});

  final WorkoutSession session;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final name = [
      session.routineDayName ?? DashboardStrings.freeSession,
      ?session.routineName,
    ].join(' · ');

    return _SectionCard(
      label: DashboardStrings.inProgress,
      onTap: () => context.go(AppRoutes.workout),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(name, style: theme.textTheme.titleLarge),
          Text(
            DashboardStrings.setsProgress(
              session.completedSets,
              session.totalSets,
            ),
            style: _muted(theme),
          ),
          const SizedBox(height: 12),
          FilledButton.icon(
            style: FilledButton.styleFrom(minimumSize: const Size(0, 48)),
            onPressed: () => context.go(AppRoutes.workout),
            icon: const Icon(Icons.play_arrow),
            label: const Text(DashboardStrings.continueWorkout),
          ),
        ],
      ),
    );
  }
}

class _NextWorkout extends ConsumerWidget {
  const _NextWorkout({required this.next});

  final NextWorkout next;

  String _when(BuildContext context) {
    final date = next.date;
    if (date == null) return DashboardStrings.nextInRoutine;
    final today = calendarDate(DateTime.now());
    final days = date.difference(today).inDays;
    return switch (days) {
      0 => DashboardStrings.today,
      1 => DashboardStrings.tomorrow,
      _ => MaterialLocalizations.of(context).formatMediumDate(date),
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final catalog = ref.watch(dashboardExerciseCatalogProvider).value ?? {};
    final routine = next.routine;
    final day = next.day;
    final details = [
      DashboardStrings.exercises(day.exercises.length),
      ...dayMuscles(day, catalog).map((m) => m.label),
    ].join(' · ');

    return _SectionCard(
      label: '${DashboardStrings.nextWorkout} · ${_when(context)}',
      // Opens the day's plan; the button starts it.
      onTap: () => context.go(AppRoutes.routineDay(routine.id, day.id)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(day.name, style: theme.textTheme.titleLarge),
          Text(routine.name, style: _muted(theme)),
          const SizedBox(height: 4),
          Text(details, style: theme.textTheme.bodySmall),
          const SizedBox(height: 12),
          FilledButton.icon(
            style: FilledButton.styleFrom(minimumSize: const Size(0, 48)),
            onPressed: () => context.go(AppRoutes.workoutStart(day.id)),
            icon: const Icon(Icons.play_arrow),
            label: const Text(DashboardStrings.start),
          ),
        ],
      ),
    );
  }
}

/// Workouts, time and streak of the current week.
class WeekCard extends ConsumerWidget {
  const WeekCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final week = ref.watch(dashboardWeekSessionsProvider);
    final starts = ref.watch(dashboardFinishedStartsProvider);
    final goal = ref.watch(dashboardProfileProvider).value?.daysPerWeek;
    if (!week.hasValue || !starts.hasValue) {
      return _SectionCard(
        label: DashboardStrings.thisWeek,
        child: _Status(error: week.hasError || starts.hasError),
      );
    }

    final sessions = week.requireValue;
    final streak = goal == null
        ? null
        : weeklyStreak(
            [for (final s in starts.requireValue) s.startedAt],
            goal: goal,
            now: DateTime.now(),
          );

    return _SectionCard(
      label: DashboardStrings.thisWeek,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Stat(
                label: DashboardStrings.workouts,
                value: goal == null
                    ? '${sessions.length}'
                    : DashboardStrings.ofGoal(sessions.length, goal),
              ),
              _Stat(
                label: DashboardStrings.time,
                value: formatHoursMinutes(trainedTime(sessions)),
              ),
              if (streak != null)
                _Stat(
                  label: DashboardStrings.streak,
                  value: DashboardStrings.weeks(streak),
                ),
            ],
          ),
          if (goal != null) ...[
            const SizedBox(height: 8),
            Text(
              DashboardStrings.streakHint(goal),
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(value, style: theme.textTheme.titleLarge),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

/// The latest body weight and its change since a week or more before.
class WeightCard extends ConsumerWidget {
  const WeightCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final weights = ref.watch(dashboardWeightsProvider);
    if (!weights.hasValue) {
      return _SectionCard(
        label: DashboardStrings.bodyWeight,
        child: _Status(error: weights.hasError),
      );
    }

    final trend = weightTrend(weights.requireValue);
    if (trend == null) {
      return _SectionCard(
        label: DashboardStrings.bodyWeight,
        onTap: () => context.go(AppRoutes.profileWeight),
        child: Text(DashboardStrings.noWeight, style: _muted(theme)),
      );
    }

    final change = trend.changeKg;
    final days = trend.daysBetween;
    final changeText = change == null || days == null
        ? DashboardStrings.noEarlierWeight
        : DashboardStrings.changeSince(_signed(change), days);
    final logged = DashboardStrings.loggedOn(
      MaterialLocalizations.of(context).formatShortMonthDay(trend.latest.date),
    );

    return _SectionCard(
      label: DashboardStrings.bodyWeight,
      onTap: () => context.go(AppRoutes.profileWeight),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            formatWeight(trend.latest.weightKg, WeightUnit.kg),
            style: theme.textTheme.headlineSmall,
          ),
          Text(changeText, style: theme.textTheme.bodyMedium),
          Text(logged, style: theme.textTheme.bodySmall),
        ],
      ),
    );
  }

  /// "+0.5 kg", "−0.8 kg" or "0 kg".
  static String _signed(double kg) {
    final text = formatWeight(kg.abs(), WeightUnit.kg);
    if (text == formatWeight(0, WeightUnit.kg)) return text;
    return kg > 0 ? '+$text' : '−$text';
  }
}

/// Shortcuts to other tabs.
class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 0, 4, 8),
          child: Text(
            DashboardStrings.quickActions,
            style: theme.textTheme.titleSmall,
          ),
        ),
        const Row(
          children: [
            _QuickAction(
              icon: Icons.monitor_weight_outlined,
              label: DashboardStrings.logWeight,
              location: AppRoutes.profileWeight,
            ),
            SizedBox(width: 8),
            _QuickAction(
              icon: Icons.calendar_month_outlined,
              label: DashboardStrings.history,
              location: AppRoutes.progress,
            ),
            SizedBox(width: 8),
            _QuickAction(
              icon: Icons.event_note_outlined,
              label: DashboardStrings.routines,
              location: AppRoutes.routines,
            ),
          ],
        ),
      ],
    );
  }
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({
    required this.icon,
    required this.label,
    required this.location,
  });

  final IconData icon;
  final String label;
  final String location;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: Card(
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => context.go(location),
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 72),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, color: theme.colorScheme.primary),
                  const SizedBox(height: 6),
                  Text(
                    label,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.labelMedium,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Loading indicator, or an error message.
class _Status extends StatelessWidget {
  const _Status({required this.error});

  final bool error;

  @override
  Widget build(BuildContext context) {
    if (error) {
      return Text(DashboardStrings.loadError, style: _muted(Theme.of(context)));
    }
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
