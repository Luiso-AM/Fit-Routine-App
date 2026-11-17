import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/widgets/confirm_dialog.dart';
import '../../../exercises/domain/exercise.dart';
import '../../data/routine_data_providers.dart';
import '../../domain/day_muscles.dart';
import '../../domain/routine.dart';
import '../../domain/routine_drafts.dart';
import '../../domain/routine_repository.dart';
import '../routine_providers.dart';
import '../routine_strings.dart';
import '../widgets/routine_sheets.dart';
import '../widgets/routine_widgets.dart';

class RoutineDetailScreen extends ConsumerWidget {
  const RoutineDetailScreen({required this.routineId, super.key});

  final String routineId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return switch (ref.watch(routineByIdProvider(routineId))) {
      AsyncData(value: final routine?) => _RoutineDetail(routine: routine),
      AsyncData() => _message(RoutineStrings.notFound),
      AsyncError() => _message(RoutineStrings.loadError),
      _ => Scaffold(
        appBar: AppBar(),
        body: const Center(child: CircularProgressIndicator()),
      ),
    };
  }

  static Widget _message(String text) =>
      Scaffold(appBar: AppBar(), body: RoutineMessage(text));
}

enum _MenuAction { duplicate, delete }

class _RoutineDetail extends ConsumerWidget {
  const _RoutineDetail({required this.routine});

  final Routine routine;

  RoutineRepository _repository(WidgetRef ref) =>
      ref.read(routineRepositoryProvider);

  /// Runs a repository action and reports failures in a snackbar.
  Future<T?> _guard<T>(
    BuildContext context,
    Future<T> Function() action,
  ) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      return await action();
    } on Exception {
      messenger.showSnackBar(
        const SnackBar(content: Text(RoutineStrings.saveError)),
      );
      return null;
    }
  }

  Future<void> _edit(BuildContext context, WidgetRef ref) async {
    final draft = await RoutineInfoSheet.show(
      context,
      title: RoutineStrings.editRoutine,
      initial: RoutineDraft.fromRoutine(routine),
    );
    if (draft == null || !context.mounted) return;
    await _guard(context, () => _repository(ref).update(routine.id, draft));
  }

  Future<void> _onMenu(
    BuildContext context,
    WidgetRef ref,
    _MenuAction action,
  ) async {
    final messenger = ScaffoldMessenger.of(context);
    switch (action) {
      case _MenuAction.duplicate:
        final copy = await _guard(
          context,
          () => _repository(
            ref,
          ).duplicate(routine.id, name: RoutineStrings.copyName(routine.name)),
        );
        if (copy == null || !context.mounted) return;
        context.go(AppRoutes.routineDetail(copy.id));
        messenger.showSnackBar(
          const SnackBar(content: Text(RoutineStrings.duplicated)),
        );
      case _MenuAction.delete:
        final confirmed = await showConfirmDialog(
          context,
          title: RoutineStrings.deleteRoutineTitle,
          message: RoutineStrings.deleteRoutineMessage,
          confirmLabel: RoutineStrings.delete,
          cancelLabel: RoutineStrings.cancel,
        );
        if (!confirmed || !context.mounted) return;
        // Leave first: the screen would otherwise show "not found".
        context.go(AppRoutes.routines);
        await _guard(context, () => _repository(ref).softDelete(routine.id));
        messenger.showSnackBar(
          const SnackBar(content: Text(RoutineStrings.routineDeleted)),
        );
    }
  }

  Future<void> _addDay(BuildContext context, WidgetRef ref) async {
    final result = await RoutineDaySheet.show(
      context,
      title: RoutineStrings.addDay,
    );
    if (result is! DaySaved || !context.mounted) return;
    await _guard(
      context,
      () => _repository(ref).addDay(routine.id, result.draft),
    );
  }

  Future<void> _editDay(
    BuildContext context,
    WidgetRef ref,
    RoutineDay day,
  ) async {
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
        await _guard(context, () => _repository(ref).deleteDay(day.id));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final catalog = ref.watch(exerciseCatalogProvider).value ?? const {};

    return Scaffold(
      appBar: AppBar(
        title: Text(routine.name),
        actions: [
          IconButton(
            tooltip: RoutineStrings.editRoutine,
            icon: const Icon(Icons.edit_outlined),
            onPressed: () => _edit(context, ref),
          ),
          PopupMenuButton<_MenuAction>(
            tooltip: RoutineStrings.more,
            onSelected: (action) => _onMenu(context, ref, action),
            itemBuilder: (_) => const [
              PopupMenuItem(
                value: _MenuAction.duplicate,
                child: Text(RoutineStrings.duplicate),
              ),
              PopupMenuItem(
                value: _MenuAction.delete,
                child: Text(RoutineStrings.delete),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _addDay(context, ref),
        icon: const Icon(Icons.add),
        label: const Text(RoutineStrings.addDay),
      ),
      body: CustomScrollView(
        slivers: [
          if (routine.notes.isNotEmpty)
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              sliver: SliverToBoxAdapter(
                child: Text(
                  routine.notes,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            sliver: SliverToBoxAdapter(
              child: Text(
                RoutineStrings.days,
                style: theme.textTheme.titleSmall?.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
          ),
          if (routine.days.isEmpty)
            const SliverFillRemaining(
              hasScrollBody: false,
              child: RoutineMessage(RoutineStrings.noDays),
            )
          else
            _DayList(
              routine: routine,
              catalog: catalog,
              onEdit: (day) => _editDay(context, ref, day),
              onReorder: (ids) => _guard(
                context,
                () => _repository(ref).reorderDays(routine.id, ids),
              ),
            ),
          const SliverPadding(padding: EdgeInsets.only(bottom: 96)),
        ],
      ),
    );
  }
}

class _DayList extends StatefulWidget {
  const _DayList({
    required this.routine,
    required this.catalog,
    required this.onEdit,
    required this.onReorder,
  });

  final Routine routine;
  final Map<String, Exercise> catalog;
  final ValueChanged<RoutineDay> onEdit;
  final ValueChanged<List<String>> onReorder;

  @override
  State<_DayList> createState() => _DayListState();
}

class _DayListState extends State<_DayList> {
  final _order = OptimisticOrder<RoutineDay>((day) => day.id);

  @override
  Widget build(BuildContext context) {
    final days = _order.apply(widget.routine.days);

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverReorderableList(
        itemCount: days.length,
        onReorderItem: (oldIndex, newIndex) {
          final ids = _order.move(days, oldIndex, newIndex);
          setState(() {});
          widget.onReorder(ids);
        },
        itemBuilder: (context, i) {
          final day = days[i];
          return ReorderableDelayedDragStartListener(
            key: ValueKey(day.id),
            index: i,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _DayCard(
                day: day,
                index: i,
                catalog: widget.catalog,
                onEdit: () => widget.onEdit(day),
                onOpen: () =>
                    context.go(AppRoutes.routineDay(widget.routine.id, day.id)),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _DayCard extends StatelessWidget {
  const _DayCard({
    required this.day,
    required this.index,
    required this.catalog,
    required this.onEdit,
    required this.onOpen,
  });

  final RoutineDay day;
  final int index;
  final Map<String, Exercise> catalog;
  final VoidCallback onEdit;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final muscles = dayMuscles(day, catalog);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onOpen,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(4, 8, 4, 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ReorderableDragStartListener(
                index: index,
                child: Tooltip(
                  message: RoutineStrings.reorder,
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
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(day.name, style: theme.textTheme.titleMedium),
                      const SizedBox(height: 2),
                      Text(
                        daySubtitle(day),
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
              IconButton(
                tooltip: RoutineStrings.dayActions,
                icon: const Icon(Icons.edit_outlined),
                onPressed: onEdit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
