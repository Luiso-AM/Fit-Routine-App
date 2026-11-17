import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/units/weight_format.dart';
import '../../../../core/units/weight_unit.dart';
import '../../../../core/utils/duration_format.dart';
import '../../../exercises/domain/exercise.dart';
import '../../domain/exercise_performance.dart';
import '../../domain/session_summary.dart';
import '../widgets/workout_widgets.dart';
import '../workout_providers.dart';
import '../workout_strings.dart';

/// What a finished session achieved, and how it compares with the previous
/// session of the same routine day.
class SessionSummaryScreen extends ConsumerWidget {
  const SessionSummaryScreen({required this.sessionId, super.key});

  final String sessionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catalog = ref.watch(workoutExerciseCatalogProvider).value ?? {};

    return Scaffold(
      appBar: AppBar(title: const Text(WorkoutStrings.summaryTitle)),
      body: switch (ref.watch(sessionSummaryProvider(sessionId))) {
        AsyncData(value: final summary?) => _SummaryView(
          summary: summary,
          catalog: catalog,
        ),
        AsyncData() => const WorkoutMessage(WorkoutStrings.summaryNotFound),
        AsyncError() => const WorkoutMessage(WorkoutStrings.summaryLoadError),
        _ => const Center(child: CircularProgressIndicator()),
      },
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          child: FilledButton(
            style: FilledButton.styleFrom(minimumSize: const Size(0, 52)),
            onPressed: () => context.go(AppRoutes.workout),
            child: const Text(WorkoutStrings.done),
          ),
        ),
      ),
    );
  }
}

class _SummaryView extends StatelessWidget {
  const _SummaryView({required this.summary, required this.catalog});

  final SessionSummary summary;
  final Map<String, Exercise> catalog;

  WeightUnit _unitOf(String exerciseId) =>
      catalog[exerciseId]?.preferredUnit ?? WeightUnit.kg;

  /// kg, unless every exercise done is shown in lb.
  WeightUnit get _volumeUnit {
    final units = {for (final e in summary.exercises) _unitOf(e.exerciseId)};
    return units.length == 1 ? units.single : WeightUnit.kg;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final muted = theme.textTheme.bodyMedium?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );
    final session = summary.session;
    final totals = summary.totals;
    final comparison = summary.comparison;
    final volumeUnit = _volumeUnit;
    final routineName = session.routineName;

    final note = switch (comparison) {
      final c? => WorkoutStrings.comparedWith(
        MaterialLocalizations.of(context)
            .formatShortMonthDay(c.previousStartedAt.toLocal()),
      ),
      null when !session.isFree => WorkoutStrings.firstTimeDay,
      null => null,
    };

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      children: [
        Text(
          session.routineDayName ?? WorkoutStrings.freeSession,
          style: theme.textTheme.headlineSmall,
        ),
        if (routineName != null) Text(routineName, style: muted),
        if (note != null) ...[
          const SizedBox(height: 8),
          Text(note, style: muted),
        ],
        const SizedBox(height: 16),
        _StatTile(
          label: WorkoutStrings.volume,
          value: formatWeight(totals.volumeKg, volumeUnit),
          delta: comparison == null
              ? null
              : _Delta.weight(comparison.volumeDeltaKg, volumeUnit),
          highlight: true,
        ),
        const SizedBox(height: 8),
        _StatRow(
          first: _StatTile(
            label: WorkoutStrings.duration,
            value: formatClock(totals.duration),
            delta: comparison == null
                ? null
                : _Delta.duration(comparison.durationDelta),
          ),
          second: _StatTile(
            label: WorkoutStrings.exercises,
            value: '${totals.exercises}',
            delta: comparison == null
                ? null
                : _Delta.count(comparison.exercisesDelta),
          ),
        ),
        const SizedBox(height: 8),
        _StatRow(
          first: _StatTile(
            label: WorkoutStrings.sets,
            value: '${totals.sets}',
            delta: comparison == null
                ? null
                : _Delta.count(comparison.setsDelta),
          ),
          second: _StatTile(
            label: WorkoutStrings.totalReps,
            value: '${totals.reps}',
            delta: comparison == null
                ? null
                : _Delta.count(comparison.repsDelta),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  WorkoutStrings.performed,
                  style: theme.textTheme.titleMedium,
                ),
                if (summary.exercises.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(WorkoutStrings.noCompletedSets, style: muted),
                  ),
                for (final performance in summary.exercises)
                  _ExerciseRow(
                    performance: performance,
                    name:
                        catalog[performance.exerciseId]?.name ??
                        WorkoutStrings.missingExercise,
                    unit: _unitOf(performance.exerciseId),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// A change against the previous session, ready to show.
class _Delta {
  const _Delta(this.text, this.sign);

  factory _Delta.count(int delta) => _Delta.signed(delta, '${delta.abs()}');

  factory _Delta.duration(Duration delta) =>
      _Delta.signed(delta.inSeconds, formatClock(delta.abs()));

  factory _Delta.weight(double deltaKg, WeightUnit unit) {
    final text = formatWeight(deltaKg.abs(), unit);
    // A change too small to show is no change.
    final shown = text == formatWeight(0, unit) ? 0 : deltaKg;
    return _Delta.signed(shown, text);
  }

  factory _Delta.signed(num delta, String magnitude) => switch (delta.sign) {
    > 0 => _Delta('+$magnitude', 1),
    < 0 => _Delta('−$magnitude', -1),
    _ => const _Delta(WorkoutStrings.noChange, 0),
  };

  final String text;

  /// 1 for an increase, -1 for a decrease, 0 for no change.
  final int sign;
}

class _StatRow extends StatelessWidget {
  const _StatRow({required this.first, required this.second});

  final Widget first;
  final Widget second;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: first),
          const SizedBox(width: 8),
          Expanded(child: second),
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.label,
    required this.value,
    this.delta,
    this.highlight = false,
  });

  final String label;
  final String value;
  final _Delta? delta;

  /// Shows the value in the accent color.
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final muted = theme.colorScheme.onSurfaceVariant;
    final delta = this.delta;
    final deltaColor = delta != null && delta.sign > 0
        ? theme.colorScheme.primary
        : muted;

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(color: muted),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: theme.textTheme.headlineSmall?.copyWith(
                color: highlight ? theme.colorScheme.primary : null,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
            if (delta != null) ...[
              const SizedBox(height: 4),
              Row(
                children: [
                  if (delta.sign != 0) ...[
                    Icon(
                      delta.sign > 0
                          ? Icons.arrow_upward
                          : Icons.arrow_downward,
                      size: 14,
                      color: deltaColor,
                    ),
                    const SizedBox(width: 2),
                  ],
                  Flexible(
                    child: Text(
                      delta.text,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: deltaColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// An exercise done: its completed sets, grouped, and its volume.
class _ExerciseRow extends StatelessWidget {
  const _ExerciseRow({
    required this.performance,
    required this.name,
    required this.unit,
  });

  final ExercisePerformance performance;
  final String name;
  final WeightUnit unit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final muted = theme.textTheme.bodySmall?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );
    final sets = [
      for (final group in performance.groups)
        '${WorkoutStrings.setGroup(group.count, group.reps)} × '
            '${formatWeight(group.weightKg, unit)}',
    ].join(', ');

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: theme.textTheme.titleSmall),
                Text(sets, style: muted),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Text(
            formatWeight(completedVolumeKg(performance.sets), unit),
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
