import 'package:material_ui/material_ui.dart';

import '../../../../core/strings/enum_labels.dart';
import '../../../exercises/domain/enums/muscle_group.dart';
import '../../../exercises/domain/exercise.dart';
import '../../domain/routine.dart';
import '../routine_strings.dart';

/// Primary muscles a day works, derived from its exercises, in
/// [MuscleGroup] order. Exercises missing from [catalog] are ignored.
List<MuscleGroup> dayMuscles(RoutineDay day, Map<String, Exercise> catalog) {
  final muscles = {
    for (final e in day.exercises) ?catalog[e.exerciseId]?.primaryMuscle,
  };
  return muscles.toList()..sort((a, b) => a.index.compareTo(b.index));
}

/// Small read-only chips with the muscles a day works.
class MuscleChips extends StatelessWidget {
  const MuscleChips({required this.muscles, super.key});

  final List<MuscleGroup> muscles;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: [
        for (final muscle in muscles)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              muscle.label,
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
          ),
      ],
    );
  }
}

/// "Lunes · 6 ejercicios", or only the count when the day has no weekday.
String daySubtitle(RoutineDay day) {
  final count = RoutineStrings.exercisesCount(day.exercises.length);
  final weekday = day.weekday;
  return weekday == null
      ? count
      : '${RoutineStrings.weekdays[weekday - 1]} · $count';
}

/// Centered message for empty or failed states.
class RoutineMessage extends StatelessWidget {
  const RoutineMessage(this.text, {this.action, super.key});

  final String text;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            if (action != null) ...[const SizedBox(height: 16), action!],
          ],
        ),
      ),
    );
  }
}

/// Keeps a reordered list visible while the change is being saved, so items
/// do not jump back until the database emits the new order.
class OptimisticOrder<T> {
  OptimisticOrder(this.idOf);

  final String Function(T) idOf;
  List<String>? _pending;

  /// [items] in the pending order if one is set and still matches them.
  List<T> apply(List<T> items) {
    final pending = _pending;
    if (pending == null) return items;
    final byId = {for (final item in items) idOf(item): item};
    final sameItems =
        pending.length == items.length && pending.every(byId.containsKey);
    if (!sameItems ||
        [for (final i in items) idOf(i)].join() == pending.join()) {
      // The data changed or caught up: drop the pending order.
      _pending = null;
      return items;
    }
    return [for (final id in pending) byId[id]!];
  }

  /// Moves an item as `onReorderItem` reports it (with [newIndex] already
  /// adjusted for the removed item) and returns the new order of ids.
  List<String> move(List<T> shown, int oldIndex, int newIndex) {
    final ids = [for (final item in shown) idOf(item)];
    ids.insert(newIndex, ids.removeAt(oldIndex));
    return _pending = ids;
  }
}
