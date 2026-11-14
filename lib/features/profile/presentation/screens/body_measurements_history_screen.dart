import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/routing/app_routes.dart';
import '../../domain/body_measurement.dart';
import '../profile_providers.dart';
import '../profile_strings.dart';
import '../widgets/body_entry_widgets.dart';

class BodyMeasurementsHistoryScreen extends ConsumerWidget {
  const BodyMeasurementsHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text(ProfileStrings.measurements)),
      body: switch (ref.watch(bodyMeasurementsProvider)) {
        AsyncData(value: []) => const EmptyMessage(
          ProfileStrings.noMeasurements,
        ),
        AsyncData(value: final measurements) => ListView.separated(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
          itemCount: measurements.length,
          separatorBuilder: (_, _) => const SizedBox(height: 12),
          itemBuilder: (context, i) =>
              _MeasurementCard(measurement: measurements[i]),
        ),
        AsyncError() => const EmptyMessage(ProfileStrings.loadError),
        _ => const Center(child: CircularProgressIndicator()),
      },
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(AppRoutes.profileMeasurementNew),
        icon: const Icon(Icons.add),
        label: const Text(ProfileStrings.logMeasurements),
      ),
    );
  }
}

class _MeasurementCard extends StatelessWidget {
  const _MeasurementCard({required this.measurement});

  final BodyMeasurement measurement;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () =>
            context.go(AppRoutes.profileMeasurementEdit(measurement.id)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                formatEntryDate(context, measurement.date),
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 16,
                runSpacing: 4,
                children: [
                  for (final (label, value) in measurementValues(measurement))
                    Text.rich(
                      TextSpan(
                        text: '$label ',
                        style: TextStyle(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        children: [
                          TextSpan(
                            text: value,
                            style: TextStyle(
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                        ],
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
