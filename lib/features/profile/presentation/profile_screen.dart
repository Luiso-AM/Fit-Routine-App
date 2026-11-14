import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/routing/app_routes.dart';
import '../../../core/strings/app_strings.dart';
import '../../../core/strings/enum_labels.dart';
import '../../../core/utils/decimal_input.dart';
import '../../../core/widgets/info_card.dart';
import '../domain/user_profile.dart';
import 'profile_providers.dart';
import 'profile_strings.dart';

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
