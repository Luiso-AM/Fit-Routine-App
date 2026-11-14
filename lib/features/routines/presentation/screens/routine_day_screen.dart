import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/units/weight_format.dart';
import '../../../../core/units/weight_unit.dart';
import '../../../../core/widgets/confirm_dialog.dart';
import '../../../../core/widgets/exercise_image.dart';
import '../../../exercises/domain/exercise.dart';
import '../../data/routine_data_providers.dart';
import '../../domain/routine.dart';
import '../../domain/routine_drafts.dart';
import '../../domain/routine_repository.dart';
import '../routine_providers.dart';
import '../routine_strings.dart';
import '../widgets/routine_exercise_sheet.dart';
import '../widgets/routine_sheets.dart';
import '../widgets/routine_widgets.dart';

/// The exercises of a routine day, with their targets.
class RoutineDayScreen extends ConsumerWidget {
  const RoutineDayScreen({
    required this.routineId,
    required this.dayId,
    super.key,
  });

  final String routineId;
  final String dayId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routine = ref.watch(routineByIdProvider(routineId));
    final catalog = ref.watch(exerciseCatalogProvider);

    return switch ((routine, catalog)) {
      (AsyncData(value: final routine?), AsyncData(value: final catalog)) =>
        switch (routine.dayById(dayId)) {
          final day? => _DayView(routine: routine, day: day, catalog: catalog),
          null => _message(RoutineStrings.dayNotFound),
        },
      (AsyncData(value: null), _) => _message(RoutineStrings.notFound),
      (AsyncError(), _) ||
      (_, AsyncError()) => _message(RoutineStrings.loadError),
      _ => Scaffold(
        appBar: AppBar(),
        body: const Center(child: CircularProgressIndicator()),
      ),
    };
  }

  static Widget _message(String text) =>
      Scaffold(appBar: AppBar(), body: RoutineMessage(text));
}

class _DayView extends ConsumerWidget {
  const _DayView({
    required this.routine,
    required this.day,
    required this.catalog,
  });

  final Routine routine;
  final RoutineDay day;
  final Map<String, Exercise> catalog;

  RoutineRepository _repository(WidgetRef ref) =>
      ref.read(routineRepositoryProvider);

  Future<bool> _guard(
    BuildContext context,
    Future<void> Function() action,
  ) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      await action();
      return true;
    } on Exception {
      messenger.showSnackBar(
        const SnackBar(content: Text(RoutineStrings.saveError)),
      );
      return false;
    }
  }

  Future<void> _editDay(BuildContext context, WidgetRef ref) async {
    final result = await RoutineDaySheet.show(
      context,
      title: RoutineStrings.editDay,
      initial: RoutineDayDraft.fromDay(day),
      canDelete: true,
    );
    if (result == null || !context.mounted) return;
    switch (result) {
      case DaySaved(:final draft):
        await _guard(context, () => _repository(ref).updateDay(day.id, draft));
      case DayDeleteRequested():
        final confirmed = await showConfirmDialog(
          context,
          title: RoutineStrings.deleteDayTitle,
          message: RoutineStrings.deleteDayMessage,
          confirmLabel: RoutineStrings.delete,
          cancelLabel: RoutineStrings.cancel,
        );
        if (!confirmed || !context.mounted) return;
        // Leave first: the screen would otherwise show "not found".
        context.go(AppRoutes.routineDetail(routine.id));
        await _guard(context, () => _repository(ref).deleteDay(day.id));
    }
  }

  Future<void> _addExercises(BuildContext context, WidgetRef ref) async {
    final ids = await context.push<List<String>>(
      AppRoutes.routineDayAddExercises(routine.id, day.id),
    );
    if (ids == null || ids.isEmpty || !context.mounted) return;
    final exercises = [for (final id in ids) ?catalog[id]];
    await _guard(
      context,
      () => _repository(ref).addExercises(day.id, exercises),
    );
  }

  Future<void> _editExercise(
    BuildContext context,
    WidgetRef ref,
    RoutineExercise planned,
  ) async {
    final exercise = catalog[planned.exerciseId];
    final result = await RoutineExerciseSheet.show(
      context,
      title: exercise?.name ?? RoutineStrings.missingExercise,
      exercise: planned,
      unit: exercise?.preferredUnit ?? WeightUnit.kg,
    );
    if (result == null || !context.mounted) return;
    switch (result) {
      case ExerciseTargetsSaved(:final draft):
        await _guard(
          context,
          () => _repository(ref).updateExercise(planned.id, draft),
        );
      case ExerciseRemoveRequested():
        final messenger = ScaffoldMessenger.of(context);
        final removed = await _guard(
          context,
          () => _repository(ref).removeExercise(planned.id),
        );
        if (removed) {
          messenger.showSnackBar(
            const SnackBar(content: Text(RoutineStrings.exerciseRemoved)),
          );
        }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final muscles = dayMuscles(day, catalog);

    return Scaffold(
      appBar: AppBar(
        title: Text(day.name),
        actions: [
          IconButton(
            tooltip: RoutineStrings.editDay,
            icon: const Icon(Icons.edit_outlined),
            onPressed: () => _editDay(context, ref),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _addExercises(context, ref),
        icon: const Icon(Icons.add),
        label: const Text(RoutineStrings.addExercises),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${routine.name} · ${daySubtitle(day)}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  if (muscles.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    MuscleChips(muscles: muscles),
                  ],
                ],
              ),
            ),
          ),
          if (day.exercises.isEmpty)
            const SliverFillRemaining(
              hasScrollBody: false,
              child: RoutineMessage(RoutineStrings.noExercisesInDay),
            )
          else
            _ExerciseList(
              day: day,
              catalog: catalog,
              onTap: (planned) => _editExercise(context, ref, planned),
              onReorder: (ids) => _guard(
                context,
                () => _repository(ref).reorderExercises(day.id, ids),
              ),
            ),
          const SliverPadding(padding: EdgeInsets.only(bottom: 96)),
        ],
      ),
    );
  }
}

class _ExerciseList extends StatefulWidget {
  const _ExerciseList({
    required this.day,
    required this.catalog,
    required this.onTap,
    required this.onReorder,
  });

  final RoutineDay day;
  final Map<String, Exercise> catalog;
  final ValueChanged<RoutineExercise> onTap;
  final ValueChanged<List<String>> onReorder;

  @override
  State<_ExerciseList> createState() => _ExerciseListState();
}

class _ExerciseListState extends State<_ExerciseList> {
  final _order = OptimisticOrder<RoutineExercise>((e) => e.id);

  @override
  Widget build(BuildContext context) {
    final exercises = _order.apply(widget.day.exercises);

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverReorderableList(
        itemCount: exercises.length,
        onReorderItem: (oldIndex, newIndex) {
          final ids = _order.move(exercises, oldIndex, newIndex);
          setState(() {});
          widget.onReorder(ids);
        },
        itemBuilder: (context, i) {
          final planned = exercises[i];
          return ReorderableDelayedDragStartListener(
            key: ValueKey(planned.id),
            index: i,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: _ExerciseCard(
                planned: planned,
                exercise: widget.catalog[planned.exerciseId],
                index: i,
                onTap: () => widget.onTap(planned),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ExerciseCard extends StatelessWidget {
  const _ExerciseCard({
    required this.planned,
    required this.exercise,
    required this.index,
    required this.onTap,
  });

  final RoutineExercise planned;

  /// `null` when the exercise was deleted from the library.
  final Exercise? exercise;
  final int index;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final unit = exercise?.preferredUnit ?? WeightUnit.kg;
    final weight = planned.initialWeightKg;
    final summary = [
      RoutineStrings.setsAndReps(
        planned.targetSets,
        planned.targetRepsMin,
        planned.targetRepsMax,
      ),
      if (weight != null) formatWeight(weight, unit),
      RoutineStrings.restValue(planned.restSeconds),
    ].join(' · ');
    final muted = theme.textTheme.bodySmall?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 0, 8),
          child: Row(
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
                      exercise?.name ?? RoutineStrings.missingExercise,
                      style: theme.textTheme.titleSmall,
                    ),
                    const SizedBox(height: 2),
                    Text(summary, style: muted),
                    if (planned.notes.isNotEmpty)
                      Text(
                        planned.notes,
                        style: muted?.copyWith(fontStyle: FontStyle.italic),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ),
              ReorderableDragStartListener(
                index: index,
                child: Tooltip(
                  message: RoutineStrings.reorderExercises,
                  child: SizedBox(
                    width: 48,
                    height: 48,
                    child: Icon(
                      Icons.drag_indicator,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
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
