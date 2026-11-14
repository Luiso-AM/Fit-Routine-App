import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/units/weight_format.dart';
import '../../../../core/units/weight_unit.dart';
import '../../domain/body_weight_entry.dart';
import '../profile_providers.dart';
import '../profile_strings.dart';
import '../widgets/body_entry_widgets.dart';
import '../widgets/body_weight_sheet.dart';

class BodyWeightHistoryScreen extends ConsumerWidget {
  const BodyWeightHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text(ProfileStrings.weightHistory)),
      body: switch (ref.watch(bodyWeightsProvider)) {
        AsyncData(value: []) => const EmptyMessage(ProfileStrings.noWeights),
        AsyncData(value: final weights) => ListView.separated(
          padding: const EdgeInsets.only(bottom: 96),
          itemCount: weights.length,
          separatorBuilder: (_, _) => const Divider(height: 1),
          itemBuilder: (context, i) => _WeightTile(
            entry: weights[i],
            previous: i + 1 < weights.length ? weights[i + 1] : null,
          ),
        ),
        AsyncError() => const EmptyMessage(ProfileStrings.loadError),
        _ => const Center(child: CircularProgressIndicator()),
      },
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => BodyWeightSheet.show(context),
        icon: const Icon(Icons.add),
        label: const Text(ProfileStrings.logWeight),
      ),
    );
  }
}

class _WeightTile extends StatelessWidget {
  const _WeightTile({required this.entry, required this.previous});

  final BodyWeightEntry entry;

  /// The entry right before this one in time, to show the change.
  final BodyWeightEntry? previous;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final change = previous == null
        ? null
        : entry.weightKg - previous!.weightKg;
    final changeText = switch (change) {
      null => null,
      final kg => '${kg > 0 ? '+' : ''}${formatWeight(kg, WeightUnit.kg)}',
    };

    return ListTile(
      minTileHeight: 64,
      title: Text(formatWeight(entry.weightKg, WeightUnit.kg)),
      subtitle: Text(formatEntryDate(context, entry.date)),
      trailing: changeText == null
          ? null
          : Text(
              changeText,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
      onTap: () => BodyWeightSheet.show(context, entry: entry),
    );
  }
}
