import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../features/exercises/domain/enums/muscle_group.dart';
import '../../features/exercises/domain/exercise.dart';
import '../../features/exercises/domain/exercise_query.dart';
import '../strings/app_strings.dart';
import '../strings/enum_labels.dart';
import 'exercise_image.dart';

/// Full-screen picker to choose several exercises. Pops with the selected
/// ids, in the order they were picked.
///
/// The muscle filter starts with [initialMuscles], read once [exercises]
/// has loaded.
class ExercisePicker extends StatefulWidget {
  const ExercisePicker({
    required this.exercises,
    this.initialMuscles = const {},
    super.key,
  });

  final AsyncValue<List<Exercise>> exercises;
  final Set<MuscleGroup> initialMuscles;

  @override
  State<ExercisePicker> createState() => _ExercisePickerState();
}

class _ExercisePickerState extends State<ExercisePicker> {
  final _search = TextEditingController();
  ExerciseQuery? _query;
  final List<String> _selected = [];

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
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

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.pickerTitle)),
      body: switch (widget.exercises) {
        AsyncError() => const _Message(AppStrings.pickerLoadError),
        AsyncData(value: final exercises) => _content(
          theme,
          exercises,
          _query ??= ExerciseQuery(muscles: widget.initialMuscles),
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
            child: Text(AppStrings.pickerAddSelected(_selected.length)),
          ),
        ),
      ),
    );
  }

  Widget _content(
    ThemeData theme,
    List<Exercise> exercises,
    ExerciseQuery query,
  ) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
          child: TextField(
            controller: _search,
            textInputAction: TextInputAction.search,
            onChanged: (text) =>
                setState(() => _query = query.copyWith(text: text)),
            decoration: InputDecoration(
              hintText: AppStrings.pickerSearchHint,
              prefixIcon: const Icon(Icons.search),
              suffixIcon: query.text.isEmpty
                  ? null
                  : IconButton(
                      tooltip: AppStrings.pickerClearSearch,
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
        Expanded(child: _results(theme, query.apply(exercises))),
      ],
    );
  }

  Widget _results(ThemeData theme, List<Exercise> matches) {
    final groups = groupByPrimaryMuscle(matches);
    if (groups.isEmpty) return const _Message(AppStrings.pickerNoResults);

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

class _Message extends StatelessWidget {
  const _Message(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}
