import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/strings/enum_labels.dart';
import '../../../../core/widgets/exercise_image.dart';
import '../../data/exercise_data_providers.dart';
import '../../domain/exercise.dart';
import '../exercise_providers.dart';
import '../exercise_strings.dart';

class ExerciseDetailScreen extends ConsumerWidget {
  const ExerciseDetailScreen({required this.exerciseId, super.key});

  final String exerciseId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exercise = ref.watch(exerciseByIdProvider(exerciseId));

    return exercise.when(
      loading: () => Scaffold(
        appBar: AppBar(),
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (_, _) => Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text(ExerciseStrings.loadError)),
      ),
      data: (exercise) => exercise == null
          ? Scaffold(
              appBar: AppBar(),
              body: const Center(child: Text(ExerciseStrings.notFound)),
            )
          : _ExerciseDetail(exercise: exercise),
    );
  }
}

class _ExerciseDetail extends ConsumerWidget {
  const _ExerciseDetail({required this.exercise});

  final Exercise exercise;

  Future<void> _delete(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(ExerciseStrings.deleteTitle),
        content: const Text(ExerciseStrings.deleteMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text(ExerciseStrings.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text(ExerciseStrings.delete),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;

    final messenger = ScaffoldMessenger.of(context);
    try {
      await ref.read(exerciseRepositoryProvider).softDelete(exercise.id);
      if (context.mounted) context.go(AppRoutes.exercises);
      messenger.showSnackBar(
        const SnackBar(content: Text(ExerciseStrings.deleted)),
      );
    } on Exception {
      messenger.showSnackBar(
        const SnackBar(content: Text(ExerciseStrings.deleteError)),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final secondary = exercise.secondaryMuscles;

    return Scaffold(
      appBar: AppBar(
        title: Text(exercise.name),
        actions: [
          if (exercise.isEditable) ...[
            IconButton(
              tooltip: ExerciseStrings.edit,
              icon: const Icon(Icons.edit_outlined),
              onPressed: () => context.go(AppRoutes.exerciseEdit(exercise.id)),
            ),
            IconButton(
              tooltip: ExerciseStrings.delete,
              icon: const Icon(Icons.delete_outline),
              onPressed: () => _delete(context, ref),
            ),
          ],
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: ExerciseImage(
              imagePath: exercise.imagePath,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          const SizedBox(height: 16),
          Text(exercise.name, style: theme.textTheme.headlineSmall),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _Tag(exercise.type.label),
              _Tag(exercise.equipment.label),
              _Tag(exercise.difficulty.label),
              if (exercise.isCustom)
                const _Tag(ExerciseStrings.custom, accent: true),
            ],
          ),
          const SizedBox(height: 16),
          _InfoCard(
            children: [
              _InfoRow(
                label: ExerciseStrings.primaryMuscle,
                value: exercise.primaryMuscle.label,
              ),
              _InfoRow(
                label: ExerciseStrings.secondaryMuscles,
                value: secondary.isEmpty
                    ? ExerciseStrings.none
                    : secondary.map((m) => m.label).join(', '),
              ),
              _InfoRow(
                label: ExerciseStrings.preferredUnit,
                value: exercise.preferredUnit.symbol,
              ),
            ],
          ),
          const SizedBox(height: 12),
          _TextCard(
            title: ExerciseStrings.instructions,
            text: exercise.instructions,
          ),
          const SizedBox(height: 12),
          _TextCard(
            title: ExerciseStrings.commonMistakes,
            text: exercise.commonMistakes,
          ),
        ],
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag(this.text, {this.accent = false});

  final String text;
  final bool accent;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Chip(
      label: Text(text),
      visualDensity: VisualDensity.compact,
      labelStyle: TextStyle(color: accent ? colors.primary : null),
      side: BorderSide(color: accent ? colors.primary : colors.outline),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(children: children),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: theme.textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}

class _TextCard extends StatelessWidget {
  const _TextCard({required this.title, required this.text});

  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(
              text.isEmpty ? ExerciseStrings.noText : text,
              style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
