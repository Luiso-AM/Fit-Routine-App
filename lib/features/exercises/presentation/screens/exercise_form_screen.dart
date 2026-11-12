import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/strings/enum_labels.dart';
import '../../../../core/units/weight_unit.dart';
import '../../data/exercise_data_providers.dart';
import '../../domain/enums/difficulty.dart';
import '../../domain/enums/equipment.dart';
import '../../domain/enums/exercise_type.dart';
import '../../domain/enums/muscle_group.dart';
import '../../domain/exercise.dart';
import '../../domain/exercise_draft.dart';
import '../../domain/exercise_repository.dart';
import '../exercise_providers.dart';
import '../exercise_strings.dart';

/// Creates a custom exercise, or edits one when [exerciseId] is given.
class ExerciseFormScreen extends ConsumerWidget {
  const ExerciseFormScreen({this.exerciseId, super.key});

  final String? exerciseId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = exerciseId;
    if (id == null) return const _ExerciseForm(initial: null);

    return ref
        .watch(exerciseByIdProvider(id))
        .when(
          loading: () => const _Message(child: CircularProgressIndicator()),
          error: (_, _) =>
              const _Message(child: Text(ExerciseStrings.loadError)),
          data: (exercise) => switch (exercise) {
            null => const _Message(child: Text(ExerciseStrings.notFound)),
            Exercise(isEditable: false) => const _Message(
              child: Text(ExerciseStrings.seedNotEditable),
            ),
            _ => _ExerciseForm(initial: exercise),
          },
        );
  }
}

class _Message extends StatelessWidget {
  const _Message({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(),
    body: Center(child: child),
  );
}

class _ExerciseForm extends ConsumerStatefulWidget {
  const _ExerciseForm({required this.initial});

  /// `null` when creating.
  final Exercise? initial;

  @override
  ConsumerState<_ExerciseForm> createState() => _ExerciseFormState();
}

class _ExerciseFormState extends ConsumerState<_ExerciseForm> {
  late ExerciseDraft _draft = widget.initial == null
      ? const ExerciseDraft()
      : ExerciseDraft.fromExercise(widget.initial!);
  late final _name = TextEditingController(text: _draft.name);
  late final _instructions = TextEditingController(text: _draft.instructions);
  late final _mistakes = TextEditingController(text: _draft.commonMistakes);

  Set<ExerciseValidationError> _errors = {};
  bool _submitted = false;
  bool _saving = false;

  bool get _isEditing => widget.initial != null;

  @override
  void dispose() {
    _name.dispose();
    _instructions.dispose();
    _mistakes.dispose();
    super.dispose();
  }

  void _update(ExerciseDraft draft) {
    setState(() {
      _draft = draft;
      // Live validation only after the first save attempt.
      if (_submitted) _errors = _validate();
    });
  }

  Set<ExerciseValidationError> _validate() {
    final existing = ref.read(exercisesProvider).value ?? const [];
    return _draft.validate(existing: existing, editingId: widget.initial?.id);
  }

  Future<void> _save() async {
    // Make sure the duplicate check sees the current library.
    await ref.read(exercisesProvider.future);
    if (!mounted) return;

    final errors = _validate();
    setState(() {
      _submitted = true;
      _errors = errors;
    });
    if (errors.isNotEmpty) return;

    setState(() => _saving = true);
    final repository = ref.read(exerciseRepositoryProvider);
    try {
      if (_isEditing) {
        await repository.update(widget.initial!.id, _draft);
        if (mounted) context.pop();
      } else {
        final created = await repository.create(_draft);
        if (mounted) context.go(AppRoutes.exerciseDetail(created.id));
      }
    } on ExerciseValidationException catch (e) {
      if (mounted) setState(() => _errors = e.errors);
    } on Exception {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(ExerciseStrings.saveError)),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  String? _error(List<ExerciseValidationError> candidates) {
    for (final error in candidates) {
      if (_errors.contains(error)) return _message(error);
    }
    return null;
  }

  static String _message(ExerciseValidationError error) => switch (error) {
    ExerciseValidationError.nameRequired => ExerciseStrings.nameRequired,
    ExerciseValidationError.nameTooLong => ExerciseStrings.nameTooLong,
    ExerciseValidationError.nameDuplicate => ExerciseStrings.nameDuplicate,
    ExerciseValidationError.primaryMuscleRequired =>
      ExerciseStrings.primaryMuscleRequired,
    ExerciseValidationError.secondaryIncludesPrimary =>
      ExerciseStrings.secondaryIncludesPrimary,
    ExerciseValidationError.typeRequired => ExerciseStrings.typeRequired,
    ExerciseValidationError.equipmentRequired =>
      ExerciseStrings.equipmentRequired,
    ExerciseValidationError.difficultyRequired =>
      ExerciseStrings.difficultyRequired,
  };

  @override
  Widget build(BuildContext context) {
    const gap = SizedBox(height: 16);
    // Keeps the library loaded and active for the duplicate name check.
    ref.watch(exercisesProvider);
    final primary = _draft.primaryMuscle;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isEditing
              ? ExerciseStrings.editExercise
              : ExerciseStrings.newExercise,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          TextField(
            controller: _name,
            maxLength: kExerciseNameMaxLength,
            textCapitalization: TextCapitalization.sentences,
            onChanged: (value) => _update(_draft.copyWith(name: value)),
            decoration: InputDecoration(
              labelText: ExerciseStrings.name,
              hintText: ExerciseStrings.nameHint,
              errorText: _error([
                ExerciseValidationError.nameRequired,
                ExerciseValidationError.nameTooLong,
                ExerciseValidationError.nameDuplicate,
              ]),
            ),
          ),
          gap,
          _EnumDropdown<MuscleGroup>(
            label: ExerciseStrings.primaryMuscle,
            values: MuscleGroup.values,
            value: primary,
            itemLabel: (m) => m.label,
            errorText: _error([ExerciseValidationError.primaryMuscleRequired]),
            onChanged: (muscle) => _update(
              _draft.copyWith(
                primaryMuscle: muscle,
                // A muscle cannot be primary and secondary at once.
                secondaryMuscles: [
                  for (final m in _draft.secondaryMuscles)
                    if (m != muscle) m,
                ],
              ),
            ),
          ),
          gap,
          _ChipField(
            label: ExerciseStrings.secondaryMusclesOptional,
            errorText: _error([
              ExerciseValidationError.secondaryIncludesPrimary,
            ]),
            children: [
              for (final muscle in MuscleGroup.values)
                if (muscle != primary)
                  FilterChip(
                    label: Text(muscle.label),
                    selected: _draft.secondaryMuscles.contains(muscle),
                    onSelected: (selected) => _update(
                      _draft.copyWith(
                        secondaryMuscles: selected
                            ? [..._draft.secondaryMuscles, muscle]
                            : [
                                for (final m in _draft.secondaryMuscles)
                                  if (m != muscle) m,
                              ],
                      ),
                    ),
                  ),
            ],
          ),
          gap,
          _EnumDropdown<ExerciseType>(
            label: ExerciseStrings.type,
            values: ExerciseType.values,
            value: _draft.type,
            itemLabel: (t) => t.label,
            errorText: _error([ExerciseValidationError.typeRequired]),
            onChanged: (type) => _update(_draft.copyWith(type: type)),
          ),
          gap,
          _EnumDropdown<Equipment>(
            label: ExerciseStrings.equipment,
            values: Equipment.values,
            value: _draft.equipment,
            itemLabel: (e) => e.label,
            errorText: _error([ExerciseValidationError.equipmentRequired]),
            onChanged: (equipment) =>
                _update(_draft.copyWith(equipment: equipment)),
          ),
          gap,
          _EnumDropdown<Difficulty>(
            label: ExerciseStrings.difficulty,
            values: Difficulty.values,
            value: _draft.difficulty,
            itemLabel: (d) => d.label,
            errorText: _error([ExerciseValidationError.difficultyRequired]),
            onChanged: (difficulty) =>
                _update(_draft.copyWith(difficulty: difficulty)),
          ),
          gap,
          _ChipField(
            label: ExerciseStrings.preferredUnit,
            children: [
              SegmentedButton<WeightUnit>(
                segments: [
                  for (final unit in WeightUnit.values)
                    ButtonSegment(value: unit, label: Text(unit.symbol)),
                ],
                selected: {_draft.preferredUnit},
                onSelectionChanged: (selection) =>
                    _update(_draft.copyWith(preferredUnit: selection.single)),
              ),
            ],
          ),
          gap,
          TextField(
            controller: _instructions,
            minLines: 3,
            maxLines: null,
            textCapitalization: TextCapitalization.sentences,
            onChanged: (value) => _update(_draft.copyWith(instructions: value)),
            decoration: const InputDecoration(
              labelText: ExerciseStrings.instructionsOptional,
              alignLabelWithHint: true,
            ),
          ),
          gap,
          TextField(
            controller: _mistakes,
            minLines: 2,
            maxLines: null,
            textCapitalization: TextCapitalization.sentences,
            onChanged: (value) =>
                _update(_draft.copyWith(commonMistakes: value)),
            decoration: const InputDecoration(
              labelText: ExerciseStrings.commonMistakesOptional,
              alignLabelWithHint: true,
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: FilledButton(
            style: FilledButton.styleFrom(minimumSize: const Size(0, 52)),
            onPressed: _saving ? null : _save,
            child: Text(
              _isEditing ? ExerciseStrings.save : ExerciseStrings.create,
            ),
          ),
        ),
      ),
    );
  }
}

class _EnumDropdown<T> extends StatelessWidget {
  const _EnumDropdown({
    required this.label,
    required this.values,
    required this.value,
    required this.itemLabel,
    required this.onChanged,
    this.errorText,
    super.key,
  });

  final String label;
  final List<T> values;
  final T? value;
  final String Function(T) itemLabel;
  final void Function(T) onChanged;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      initialValue: value,
      decoration: InputDecoration(labelText: label, errorText: errorText),
      items: [
        for (final v in values)
          DropdownMenuItem(value: v, child: Text(itemLabel(v))),
      ],
      onChanged: (v) {
        if (v != null) onChanged(v);
      },
    );
  }
}

/// A labeled group of chips or buttons with an optional error below.
class _ChipField extends StatelessWidget {
  const _ChipField({
    required this.label,
    required this.children,
    this.errorText,
  });

  final String label;
  final List<Widget> children;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(spacing: 8, runSpacing: 8, children: children),
        if (errorText != null) ...[
          const SizedBox(height: 6),
          Text(
            errorText!,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.error,
            ),
          ),
        ],
      ],
    );
  }
}
