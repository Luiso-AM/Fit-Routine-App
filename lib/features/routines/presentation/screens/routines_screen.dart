import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/strings/app_strings.dart';
import '../../../../core/strings/enum_labels.dart';
import '../../data/routine_data_providers.dart';
import '../../data/routine_templates.dart';
import '../../domain/routine.dart';
import '../../domain/routine_template.dart';
import '../routine_providers.dart';
import '../routine_strings.dart';
import '../widgets/routine_sheets.dart';
import '../widgets/routine_widgets.dart';

class RoutinesScreen extends ConsumerWidget {
  const RoutinesScreen({super.key});

  Future<void> _create(BuildContext context, WidgetRef ref) async {
    final choice = await showModalBottomSheet<_NewRoutineChoice>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => const _NewRoutineSheet(),
    );
    if (choice == null || !context.mounted) return;

    final repository = ref.read(routineRepositoryProvider);
    final messenger = ScaffoldMessenger.of(context);
    try {
      final Routine routine;
      switch (choice) {
        case _Blank():
          final draft = await RoutineInfoSheet.show(
            context,
            title: RoutineStrings.newRoutine,
          );
          if (draft == null) return;
          routine = await repository.create(draft);
        case _FromTemplate(:final template):
          routine = await repository.createFromTemplate(template);
      }
      if (context.mounted) context.go(AppRoutes.routineDetail(routine.id));
    } on Exception {
      messenger.showSnackBar(
        const SnackBar(content: Text(RoutineStrings.saveError)),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.tabRoutines),
        actions: [
          TextButton.icon(
            onPressed: () => context.go(AppRoutes.exercises),
            icon: const Icon(Icons.fitness_center),
            label: const Text(AppStrings.exerciseLibrary),
          ),
          const SizedBox(width: 8),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _create(context, ref),
        icon: const Icon(Icons.add),
        label: const Text(RoutineStrings.newRoutine),
      ),
      body: switch (ref.watch(routinesProvider)) {
        AsyncData(value: []) => const RoutineMessage(RoutineStrings.noRoutines),
        AsyncData(value: final routines) => ListView.separated(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
          itemCount: routines.length,
          separatorBuilder: (_, _) => const SizedBox(height: 12),
          itemBuilder: (context, i) => _RoutineCard(routine: routines[i]),
        ),
        AsyncError() => const RoutineMessage(RoutineStrings.loadError),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}

class _RoutineCard extends StatelessWidget {
  const _RoutineCard({required this.routine});

  final Routine routine;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final template = routine.templateType;
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.go(AppRoutes.routineDetail(routine.id)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(routine.name, style: theme.textTheme.titleMedium),
              const SizedBox(height: 4),
              Text(
                [
                  RoutineStrings.daysCount(routine.days.length),
                  RoutineStrings.exercisesCount(routine.exerciseCount),
                  ?template?.label,
                ].join(' · '),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

sealed class _NewRoutineChoice {
  const _NewRoutineChoice();
}

class _Blank extends _NewRoutineChoice {
  const _Blank();
}

class _FromTemplate extends _NewRoutineChoice {
  const _FromTemplate(this.template);

  final RoutineTemplate template;
}

class _NewRoutineSheet extends StatelessWidget {
  const _NewRoutineSheet();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    void choose(_NewRoutineChoice choice) => Navigator.of(context).pop(choice);

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Text(
                RoutineStrings.newRoutine,
                style: theme.textTheme.titleLarge,
              ),
            ),
            ListTile(
              minTileHeight: 64,
              leading: const Icon(Icons.edit_note),
              title: const Text(RoutineStrings.blankRoutine),
              subtitle: const Text(RoutineStrings.blankRoutineHint),
              onTap: () => choose(const _Blank()),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
              child: Text(
                RoutineStrings.templates,
                style: theme.textTheme.titleSmall?.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
            for (final template in routineTemplates)
              ListTile(
                minTileHeight: 64,
                leading: const Icon(Icons.view_week_outlined),
                title: Text(template.type.label),
                subtitle: Text(template.type.description),
                onTap: () => choose(_FromTemplate(template)),
              ),
          ],
        ),
      ),
    );
  }
}
