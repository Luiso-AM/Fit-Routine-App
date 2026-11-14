import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/strings/enum_labels.dart';
import '../../../../core/widgets/exercise_image.dart';
import '../../../exercises/domain/enums/muscle_group.dart';
import '../../../exercises/domain/exercise.dart';
import '../../../exercises/domain/exercise_query.dart';
import '../routine_providers.dart';
import '../routine_strings.dart';
import '../widgets/routine_widgets.dart';

/// Picks exercises to add to a routine day. Pops with the selected ids, in
/// the order they were picked.
///
/// The muscle filter starts with the muscles the day already works.
class ExercisePickerScreen extends ConsumerStatefulWidget {
  const ExercisePickerScreen({
    required this.routineId,
    required this.dayId,
    super.key,
  });

  final String routineId;
  final String dayId;

  @override
  ConsumerState<ExercisePickerScreen> createState() =>
      _ExercisePickerScreenState();
}

class _ExercisePickerScreenState extends ConsumerState<ExercisePickerScreen> {
  final _search = TextEditingController();
  ExerciseQuery? _query;
  final List<String> _selected = [];

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  /// The day's muscles, once both the routine and the catalog are loaded.
  ExerciseQuery? _initialQuery() {
    final routine = ref.watch(routineByIdProvider(widget.routineId)).value;
    final catalog = ref.watch(exerciseCatalogProvider).value;
    final day = routine?.dayById(widget.dayId);
    if (catalog == null || routine == null) return null;
    final muscles = day == null ? <MuscleGroup>[] : dayMuscles(day, catalog);
    return ExerciseQuery(muscles: muscles.toSet());
  }

  void _toggleMuscle(ExerciseQuery query, MuscleGroup muscle) {
    final muscles = {...query.muscles};
    if (!muscles.remove(muscle)) muscles.add(muscle);
    setState(() => _query = query.copyWith(muscles: muscles));
  }

  void _toggleExercise(String id) => setState(() {
    if (!_selected.remove(id)) _selected.add(id);
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final catalog = ref.watch(exerciseCatalogProvider);
    final query = _query ??= _initialQuery();

    return Scaffold(
      appBar: AppBar(title: const Text(RoutineStrings.addExercises)),
      body: switch ((catalog, query)) {
        (AsyncError(), _) => const RoutineMessage(RoutineStrings.loadError),
        (AsyncData(value: final catalog), final query?) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
              child: TextField(
                controller: _search,
                textInputAction: TextInputAction.search,
                onChanged: (text) =>
                    setState(() => _query = query.copyWith(text: text)),
                decoration: InputDecoration(
                  hintText: RoutineStrings.searchHint,
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: query.text.isEmpty
                      ? null
                      : IconButton(
                          tooltip: RoutineStrings.clearSearch,
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            _search.clear();
                            setState(() => _query = query.copyWith(text: ''));
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
            SizedBox(
              height: 48,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  for (final muscle in MuscleGroup.values)
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        label: Text(muscle.label),
                        selected: query.muscles.contains(muscle),
                        onSelected: (_) => _toggleMuscle(query, muscle),
                      ),
                    ),
                ],
              ),
            ),
            Expanded(child: _results(theme, query.apply(catalog.values))),
          ],
        ),
        _ => const Center(child: CircularProgressIndicator()),
      },
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: FilledButton(
            style: FilledButton.styleFrom(minimumSize: const Size(0, 52)),
            onPressed: _selected.isEmpty
                ? null
                : () => context.pop(List<String>.of(_selected)),
            child: Text(RoutineStrings.addSelected(_selected.length)),
          ),
        ),
      ),
    );
  }

  Widget _results(ThemeData theme, List<Exercise> matches) {
    final groups = groupByPrimaryMuscle(matches);
    if (groups.isEmpty) return const RoutineMessage(RoutineStrings.noResults);

    return CustomScrollView(
      slivers: [
        for (final MapEntry(key: muscle, value: exercises)
            in groups.entries) ...[
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
              child: Text(
                muscle.label,
                style: theme.textTheme.titleSmall?.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
          ),
          SliverList.builder(
            itemCount: exercises.length,
            itemBuilder: (context, i) {
              final exercise = exercises[i];
              return CheckboxListTile(
                value: _selected.contains(exercise.id),
                onChanged: (_) => _toggleExercise(exercise.id),
                secondary: ExerciseImage(
                  imagePath: exercise.imagePath,
                  width: 48,
                  height: 48,
                  borderRadius: BorderRadius.circular(10),
                ),
                title: Text(exercise.name),
                subtitle: Text(
                  '${exercise.equipment.label} · ${exercise.type.label}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              );
            },
          ),
        ],
        const SliverPadding(padding: EdgeInsets.only(bottom: 24)),
      ],
    );
  }
}
