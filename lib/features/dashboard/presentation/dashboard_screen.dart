import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/strings/app_strings.dart';
import 'dashboard_providers.dart';
import 'dashboard_strings.dart';
import 'widgets/dashboard_cards.dart';

/// Home tab: what to train next, this week's activity, body weight and
/// shortcuts.
class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final alias = ref.watch(dashboardProfileProvider).value?.alias;

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.tabHome)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        children: [
          if (alias != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 0, 4, 2),
              child: Text(
                DashboardStrings.greeting(alias),
                style: theme.textTheme.headlineSmall,
              ),
            ),
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 0, 4, 12),
            child: Text(
              MaterialLocalizations.of(context).formatFullDate(DateTime.now()),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          const NextWorkoutCard(),
          const SizedBox(height: 12),
          const WeekCard(),
          const SizedBox(height: 12),
          const WeightCard(),
          const SizedBox(height: 20),
          const QuickActions(),
        ],
      ),
    );
  }
}
