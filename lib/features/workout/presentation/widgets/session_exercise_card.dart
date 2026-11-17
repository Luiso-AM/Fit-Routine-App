import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/strings/enum_labels.dart';
import '../../../../core/units/weight_format.dart';
import '../../../../core/units/weight_unit.dart';
import '../../../../core/widgets/confirm_dialog.dart';
import '../../../../core/widgets/exercise_image.dart';
import '../../../exercises/data/exercise_data_providers.dart';
import '../../../exercises/domain/exercise.dart';
import '../../data/workout_data_providers.dart';
import '../../domain/exercise_performance.dart';
import '../../domain/workout_session.dart';
import '../workout_actions.dart';
import '../workout_providers.dart';
import '../workout_strings.dart';
import 'set_editor_sheet.dart';

/// An exercise of the session: what was done last time, and a row per set
/// to complete it with one tap or open it to change its values.
class SessionExerciseCard extends ConsumerWidget {
  const SessionExerciseCard({
    required this.entry,
    required this.exercise,
    this.showLastTime = true,
    super.key,
  });

  final SessionExercise entry;

  /// Whether to show what was done the last time, which only helps while
  /// training.
  final bool showLastTime;

  /// `null` when the exercise was deleted from the library.
  final Exercise? exercise;

  WeightUnit get _unit => exercise?.preferredUnit ?? WeightUnit.kg;

  Future<void> _toggleUnit(BuildContext context, WidgetRef ref) async {
    final exercise = this.exercise;
    if (exercise == null) return;
    final next = _unit == WeightUnit.kg ? WeightUnit.lb : WeightUnit.kg;
    await guardWorkout(
      context,
      () => ref
          .read(exerciseRepositoryProvider)
          .setPreferredUnit(exercise.id, next),
    );
  }

  Future<void> _remove(BuildContext context, WidgetRef ref) async {
    final confirmed = await showConfirmDialog(
      context,
      title: WorkoutStrings.removeExerciseTitle,
      message: WorkoutStrings.removeExerciseMessage,
      confirmLabel: WorkoutStrings.removeExercise,
      cancelLabel: WorkoutStrings.cancel,
    );
    if (!confirmed || !context.mounted) return;
    await guardWorkout(
      context,
      () => ref.read(workoutRepositoryProvider).removeExercise(entry.id),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final exercise = this.exercise;
    final muted = theme.textTheme.bodySmall?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );
    final (min, max, sets) = (
      entry.targetRepsMin,
      entry.targetRepsMax,
      entry.targetSets,
    );
    final details = [
      ?exercise?.primaryMuscle.label,
      if (sets != null && min != null && max != null)
        WorkoutStrings.target(sets, min, max),
    ].join(' · ');

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 4, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                ExerciseImage(
                  imagePath: exercise?.imagePath,
                  width: 48,
                  height: 48,
                  borderRadius: BorderRadius.circular(10),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        exercise?.name ?? WorkoutStrings.missingExercise,
                        style: theme.textTheme.titleSmall,
                      ),
                      if (details.isNotEmpty) Text(details, style: muted),
                    ],
                  ),
                ),
                if (exercise != null)
                  Tooltip(
                    message: WorkoutStrings.changeUnit,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        minimumSize: const Size(48, 48),
                      ),
                      onPressed: () => _toggleUnit(context, ref),
                      child: Text(_unit.symbol),
                    ),
                  ),
                PopupMenuButton<_ExerciseAction>(
                  tooltip: WorkoutStrings.exerciseActions,
                  onSelected: (action) => switch (action) {
                    _ExerciseAction.remove => _remove(context, ref),
                  },
                  itemBuilder: (context) => const [
                    PopupMenuItem(
                      value: _ExerciseAction.remove,
                      child: Text(WorkoutStrings.removeExercise),
                    ),
                  ],
                ),
              ],
            ),
            if (showLastTime)
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 8, 4),
                child: _LastTime(exerciseId: entry.exerciseId, unit: _unit),
              )
            else
              const SizedBox(height: 8),
            if (entry.notes.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(right: 8, bottom: 4),
                child: Text(
                  entry.notes,
                  style: muted?.copyWith(fontStyle: FontStyle.italic),
                ),
              ),
            if (entry.sets.isNotEmpty) ...[
              _SetHeader(unit: _unit),
              for (final set in entry.sets)
                _SetRow(
                  key: ValueKey(set.id),
                  set: set,
                  unit: _unit,
                  onTap: () => SetEditorSheet.show(
                    context,
                    set: set,
                    exerciseName:
                        exercise?.name ?? WorkoutStrings.missingExercise,
                    unit: _unit,
                  ),
                  onToggle: () => guardWorkout(
                    context,
                    () => ref
                        .read(workoutRepositoryProvider)
                        .setCompleted(set.id, completed: !set.isCompleted),
                  ),
                ),
            ],
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                style: TextButton.styleFrom(minimumSize: const Size(0, 48)),
                onPressed: () => guardWorkout(
                  context,
                  () => ref.read(workoutRepositoryProvider).addSet(entry.id),
                ),
                icon: const Icon(Icons.add),
                label: const Text(WorkoutStrings.addSet),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum _ExerciseAction { remove }

/// "Última vez: 3 × 10 × 60 kg", or a note when there is no history.
class _LastTime extends ConsumerWidget {
  const _LastTime({required this.exerciseId, required this.unit});

  final String exerciseId;
  final WeightUnit unit;

  static String _describe(ExercisePerformance last, WeightUnit unit) => [
    for (final group in last.groups)
      '${WorkoutStrings.setGroup(group.count, group.reps)} × '
          '${formatWeight(group.weightKg, unit)}',
  ].join(', ');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final style = theme.textTheme.bodySmall?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );
    final last = ref.watch(lastPerformanceProvider(exerciseId));

    return switch (last) {
      AsyncData(value: final last?) => Text.rich(
        TextSpan(
          children: [
            const TextSpan(
              text: '${WorkoutStrings.lastTime}: ',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            TextSpan(text: _describe(last, unit)),
          ],
        ),
        style: style,
      ),
      AsyncData() => Text(WorkoutStrings.noHistory, style: style),
      _ => const SizedBox.shrink(),
    };
  }
}

const double _numberWidth = 40;
const double _rirWidth = 44;
const double _checkWidth = 56;

class _SetHeader extends StatelessWidget {
  const _SetHeader({required this.unit});

  final WeightUnit unit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.labelSmall?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 2),
      child: Row(
        children: [
          SizedBox(
            width: _numberWidth,
            child: Text(
              WorkoutStrings.set,
              style: style,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              '${WorkoutStrings.weight} (${unit.symbol})',
              style: style,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              WorkoutStrings.reps,
              style: style,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            width: _rirWidth,
            child: Text(
              WorkoutStrings.rir,
              style: style,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: _checkWidth),
        ],
      ),
    );
  }
}

class _SetRow extends StatelessWidget {
  const _SetRow({
    required this.set,
    required this.unit,
    required this.onTap,
    required this.onToggle,
    super.key,
  });

  final SetEntry set;
  final WeightUnit unit;
  final VoidCallback onTap;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final done = set.isCompleted;
    final style = theme.textTheme.titleMedium?.copyWith(
      fontFeatures: const [FontFeature.tabularFigures()],
    );
    final rir = set.rir;

    return Material(
      color: done
          ? theme.colorScheme.primary.withValues(alpha: 0.10)
          : Colors.transparent,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: SizedBox(
          height: 52,
          child: Row(
            children: [
              SizedBox(
                width: _numberWidth,
                child: Text(
                  '${set.setNumber}',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  formatWeight(set.weightKg, unit, withUnit: false),
                  textAlign: TextAlign.center,
                  style: style,
                ),
              ),
              Expanded(
                child: Text(
                  '${set.reps}',
                  textAlign: TextAlign.center,
                  style: style,
                ),
              ),
              SizedBox(
                width: _rirWidth,
                child: Text(
                  rir == null ? WorkoutStrings.noValue : '$rir',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium,
                ),
              ),
              SizedBox(
                width: _checkWidth,
                child: IconButton(
                  tooltip: done
                      ? WorkoutStrings.undoSet
                      : WorkoutStrings.completeSet,
                  onPressed: onToggle,
                  iconSize: 30,
                  color: done
                      ? theme.colorScheme.primary
                      : theme.colorScheme.onSurfaceVariant,
                  icon: Icon(
                    done ? Icons.check_circle : Icons.radio_button_unchecked,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
