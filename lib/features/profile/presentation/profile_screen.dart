import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/routing/app_routes.dart';
import '../../../core/strings/app_strings.dart';
import '../../../core/strings/enum_labels.dart';
import '../../../core/units/weight_format.dart';
import '../../../core/units/weight_unit.dart';
import '../../../core/utils/decimal_input.dart';
import '../../../core/widgets/info_card.dart';
import '../domain/user_profile.dart';
import 'profile_providers.dart';
import 'profile_strings.dart';
import 'widgets/body_entry_widgets.dart';
import 'widgets/body_weight_sheet.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(currentProfileProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.tabProfile),
        actions: [
          if (profile.value != null)
            IconButton(
              tooltip: ProfileStrings.editProfile,
              icon: const Icon(Icons.edit_outlined),
              onPressed: () => context.go(AppRoutes.profileEdit),
            ),
        ],
      ),
      body: switch (profile) {
        AsyncData(value: final profile?) => _ProfileContent(profile: profile),
        AsyncError() => const Center(child: Text(ProfileStrings.loadError)),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}

class _ProfileContent extends StatelessWidget {
  const _ProfileContent({required this.profile});

  final UserProfile profile;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final age = profile.ageOn(DateTime.now());
    final equipment = profile.equipment;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
      children: [
        Text(profile.alias, style: theme.textTheme.headlineSmall),
        const SizedBox(height: 4),
        Text(
          '${profile.experienceLevel.label} · ${profile.goal.label}',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 16),
        const _BodyWeightCard(),
        const SizedBox(height: 12),
        const _MeasurementsCard(),
        const SizedBox(height: 12),
        InfoCard(
          title: ProfileStrings.personalData,
          children: [
            InfoRow(
              label: ProfileStrings.age,
              value: age == null
                  ? ProfileStrings.notSpecified
                  : ProfileStrings.years(age),
            ),
            InfoRow(
              label: ProfileStrings.sex,
              value: profile.sex?.label ?? ProfileStrings.notSpecified,
            ),
            InfoRow(
              label: ProfileStrings.height,
              value:
                  '${formatDecimalInput(profile.heightCm)} ${ProfileStrings.cm}',
            ),
          ],
        ),
        const SizedBox(height: 12),
        InfoCard(
          title: ProfileStrings.training,
          children: [
            InfoRow(
              label: ProfileStrings.experienceLevel,
              value: profile.experienceLevel.label,
            ),
            InfoRow(label: ProfileStrings.goal, value: profile.goal.label),
            InfoRow(
              label: ProfileStrings.daysPerWeek,
              value: ProfileStrings.days(profile.daysPerWeek),
            ),
            InfoRow(
              label: ProfileStrings.sessionDuration,
              value: ProfileStrings.durationMinutes(profile.sessionDurationMin),
            ),
            InfoRow(
              label: ProfileStrings.equipment,
              value: equipment.isEmpty
                  ? ProfileStrings.notSpecified
                  : equipment.map((e) => e.label).join(', '),
            ),
          ],
        ),
      ],
    );
  }
}

/// Latest body weight, with actions to log a new one and see the history.
class _BodyWeightCard extends ConsumerWidget {
  const _BodyWeightCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final latest = ref.watch(bodyWeightsProvider).value?.firstOrNull;

    return InfoCard(
      title: ProfileStrings.bodyWeight,
      trailing: TextButton(
        onPressed: () => context.go(AppRoutes.profileWeight),
        child: const Text(ProfileStrings.history),
      ),
      children: [
        if (latest == null)
          const _Muted(ProfileStrings.noRecords)
        else ...[
          Text(
            formatWeight(latest.weightKg, WeightUnit.kg),
            style: theme.textTheme.headlineMedium,
          ),
          _Muted(
            ProfileStrings.recordedOn(formatEntryDate(context, latest.date)),
          ),
        ],
        const SizedBox(height: 12),
        FilledButton.tonalIcon(
          style: FilledButton.styleFrom(minimumSize: const Size(0, 48)),
          onPressed: () => BodyWeightSheet.show(context),
          icon: const Icon(Icons.add),
          label: const Text(ProfileStrings.logWeight),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

/// Latest body measurements, with actions to log new ones and see the
/// history.
class _MeasurementsCard extends ConsumerWidget {
  const _MeasurementsCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final latest = ref.watch(bodyMeasurementsProvider).value?.firstOrNull;

    return InfoCard(
      title: ProfileStrings.measurements,
      trailing: TextButton(
        onPressed: () => context.go(AppRoutes.profileMeasurements),
        child: const Text(ProfileStrings.history),
      ),
      children: [
        if (latest == null)
          const _Muted(ProfileStrings.noRecords)
        else ...[
          _Muted(
            ProfileStrings.recordedOn(formatEntryDate(context, latest.date)),
          ),
          for (final (label, value) in measurementValues(latest))
            InfoRow(label: label, value: value),
        ],
        const SizedBox(height: 12),
        FilledButton.tonalIcon(
          style: FilledButton.styleFrom(minimumSize: const Size(0, 48)),
          onPressed: () => context.push(AppRoutes.profileMeasurementNew),
          icon: const Icon(Icons.add),
          label: const Text(ProfileStrings.logMeasurements),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

class _Muted extends StatelessWidget {
  const _Muted(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      text,
      style: theme.textTheme.bodyMedium?.copyWith(
        color: theme.colorScheme.onSurfaceVariant,
      ),
    );
  }
}
