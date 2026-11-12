import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/strings/enum_labels.dart';
import '../../domain/enums/equipment.dart';
import '../../domain/enums/exercise_type.dart';
import '../../domain/enums/muscle_group.dart';
import '../exercise_providers.dart';
import '../exercise_strings.dart';

/// Bottom sheet with the library filters. Changes apply immediately.
class ExerciseFilterSheet extends ConsumerWidget {
  const ExerciseFilterSheet({super.key});

  static Future<void> show(BuildContext context) => showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (_) => const ExerciseFilterSheet(),
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.watch(exerciseQueryControllerProvider);
    final controller = ref.read(exerciseQueryControllerProvider.notifier);

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.7,
      maxChildSize: 0.9,
      builder: (context, scrollController) => Column(
        children: [
          Expanded(
            child: ListView(
              controller: scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _Section<MuscleGroup>(
                  title: ExerciseStrings.muscle,
                  values: MuscleGroup.values,
                  selected: query.muscles,
                  label: (m) => m.label,
                  onToggle: controller.toggleMuscle,
                ),
                _Section<Equipment>(
                  title: ExerciseStrings.equipment,
                  values: Equipment.values,
                  selected: query.equipment,
                  label: (e) => e.label,
                  onToggle: controller.toggleEquipment,
                ),
                _Section<ExerciseType>(
                  title: ExerciseStrings.type,
                  values: ExerciseType.values,
                  selected: query.types,
                  label: (t) => t.label,
                  onToggle: controller.toggleType,
                ),
              ],
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: query.activeFilterCount == 0
                          ? null
                          : controller.clearFilters,
                      child: const Text(ExerciseStrings.clearFilters),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text(ExerciseStrings.done),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Section<T> extends StatelessWidget {
  const _Section({
    required this.title,
    required this.values,
    required this.selected,
    required this.label,
    required this.onToggle,
    super.key,
  });

  final String title;
  final List<T> values;
  final Set<T> selected;
  final String Function(T) label;
  final void Function(T) onToggle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final value in values)
                FilterChip(
                  label: Text(label(value)),
                  selected: selected.contains(value),
                  onSelected: (_) => onToggle(value),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
