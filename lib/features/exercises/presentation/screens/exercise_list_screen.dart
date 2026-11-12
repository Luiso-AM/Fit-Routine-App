import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/strings/app_strings.dart';
import '../../../../core/strings/enum_labels.dart';
import '../../domain/enums/muscle_group.dart';
import '../../domain/exercise.dart';
import '../exercise_providers.dart';
import '../exercise_strings.dart';
import '../widgets/exercise_filter_sheet.dart';
import '../widgets/exercise_tile.dart';

class ExerciseListScreen extends ConsumerStatefulWidget {
  const ExerciseListScreen({super.key});

  @override
  ConsumerState<ExerciseListScreen> createState() => _ExerciseListScreenState();
}

class _ExerciseListScreenState extends ConsumerState<ExerciseListScreen> {
  late final TextEditingController _search = TextEditingController(
    text: ref.read(exerciseQueryControllerProvider).text,
  );

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  void _clearAll() {
    _search.clear();
    ref.read(exerciseQueryControllerProvider.notifier).clearAll();
  }

  @override
  Widget build(BuildContext context) {
    final query = ref.watch(exerciseQueryControllerProvider);
    final groups = ref.watch(filteredExerciseGroupsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.exerciseLibrary)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go(AppRoutes.exerciseNew),
        icon: const Icon(Icons.add),
        label: const Text(ExerciseStrings.newExercise),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _search,
                    onChanged: ref
                        .read(exerciseQueryControllerProvider.notifier)
                        .setText,
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      hintText: ExerciseStrings.searchHint,
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: query.text.isEmpty
                          ? null
                          : IconButton(
                              tooltip: ExerciseStrings.clearSearch,
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                _search.clear();
                                ref
                                    .read(
                                      exerciseQueryControllerProvider.notifier,
                                    )
                                    .setText('');
                              },
                            ),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Badge.count(
                  count: query.activeFilterCount,
                  isLabelVisible: query.activeFilterCount > 0,
                  child: IconButton.filledTonal(
                    tooltip: ExerciseStrings.filters,
                    iconSize: 24,
                    constraints: const BoxConstraints.tightFor(
                      width: 52,
                      height: 52,
                    ),
                    onPressed: () => ExerciseFilterSheet.show(context),
                    icon: const Icon(Icons.tune),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: groups.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, _) =>
                  const Center(child: Text(ExerciseStrings.loadError)),
              data: (groups) => groups.isEmpty
                  ? _EmptyResults(onClear: query.isEmpty ? null : _clearAll)
                  : _GroupedList(groups: groups),
            ),
          ),
        ],
      ),
    );
  }
}

class _GroupedList extends StatelessWidget {
  const _GroupedList({required this.groups});

  final Map<MuscleGroup, List<Exercise>> groups;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CustomScrollView(
      slivers: [
        for (final MapEntry(key: muscle, value: exercises)
            in groups.entries) ...[
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
              child: Text(
                '${muscle.label} (${exercises.length})',
                style: theme.textTheme.titleSmall?.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
          ),
          SliverList.builder(
            itemCount: exercises.length,
            itemBuilder: (context, index) {
              final exercise = exercises[index];
              return ExerciseTile(
                exercise: exercise,
                onTap: () => context.go(AppRoutes.exerciseDetail(exercise.id)),
              );
            },
          ),
        ],
        const SliverPadding(padding: EdgeInsets.only(bottom: 96)),
      ],
    );
  }
}

class _EmptyResults extends StatelessWidget {
  const _EmptyResults({required this.onClear});

  final VoidCallback? onClear;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search_off,
              size: 48,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 12),
            Text(
              ExerciseStrings.noResults,
              style: theme.textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            if (onClear != null) ...[
              const SizedBox(height: 16),
              OutlinedButton(
                onPressed: onClear,
                child: const Text(ExerciseStrings.clearFilters),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
