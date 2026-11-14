import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/units/weight_conversion.dart';
import '../../../../core/units/weight_step.dart';
import '../../../../core/units/weight_unit.dart';
import '../../../../core/utils/decimal_input.dart';
import '../../data/workout_data_providers.dart';
import '../../domain/set_values.dart';
import '../../domain/workout_repository.dart';
import '../../domain/workout_session.dart';
import '../workout_strings.dart';
import 'workout_widgets.dart';

/// Edits one set with large +/− buttons or the keyboard. Every change is
/// saved at once; there is no save button.
class SetEditorSheet extends ConsumerStatefulWidget {
  const SetEditorSheet({
    required this.set,
    required this.exerciseName,
    required this.unit,
    super.key,
  });

  final SetEntry set;
  final String exerciseName;
  final WeightUnit unit;

  static Future<void> show(
    BuildContext context, {
    required SetEntry set,
    required String exerciseName,
    required WeightUnit unit,
  }) => showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) =>
        SetEditorSheet(set: set, exerciseName: exerciseName, unit: unit),
  );

  @override
  ConsumerState<SetEditorSheet> createState() => _SetEditorSheetState();
}

class _SetEditorSheetState extends ConsumerState<SetEditorSheet> {
  late SetValues _values = SetValues(
    weightKg: widget.set.weightKg,
    reps: widget.set.reps,
    rir: widget.set.rir,
  );
  late final _weight = TextEditingController(text: _weightText(_values));
  late final _reps = TextEditingController(text: '${_values.reps}');

  WorkoutRepository get _repository => ref.read(workoutRepositoryProvider);

  String _weightText(SetValues values) =>
      formatDecimalInput(fromKg(values.weightKg, widget.unit));

  @override
  void dispose() {
    _weight.dispose();
    _reps.dispose();
    super.dispose();
  }

  /// Saves [values] if they are valid. Text fields are only rewritten when
  /// the change did not come from typing in them.
  void _apply(
    SetValues values, {
    bool fromWeightField = false,
    bool fromRepsField = false,
  }) {
    if (values.validate().isNotEmpty) return;
    setState(() => _values = values);
    if (!fromWeightField) _weight.text = _weightText(values);
    if (!fromRepsField) _reps.text = '${values.reps}';
    final messenger = ScaffoldMessenger.of(context);
    _repository.updateSet(widget.set.id, values).catchError((Object _) {
      messenger.showSnackBar(
        const SnackBar(content: Text(WorkoutStrings.saveError)),
      );
    });
  }

  void _stepWeight(int steps) => _apply(
    _values.copyWith(
      weightKg: stepWeightKg(_values.weightKg, widget.unit, steps),
    ),
  );

  void _stepReps(int steps) {
    final reps = (_values.reps + steps).clamp(0, kMaxSetReps);
    _apply(_values.copyWith(reps: reps));
  }

  /// RIR goes from "not recorded" to 0, 1, ... and back.
  void _stepRir(int steps) {
    final current = _values.rir;
    final int? next;
    if (current == null) {
      next = steps > 0 ? 0 : null;
    } else {
      final value = current + steps;
      next = value < 0 ? null : value.clamp(0, kMaxRir);
    }
    _apply(_values.copyWith(rir: next));
  }

  void _typedWeight(String text) {
    final value = parseDecimalInput(text);
    if (value == null) return;
    _apply(
      _values.copyWith(weightKg: toKg(value, widget.unit)),
      fromWeightField: true,
    );
  }

  void _typedReps(String text) {
    final value = parseIntInput(text);
    if (value == null) return;
    _apply(_values.copyWith(reps: value), fromRepsField: true);
  }

  Future<void> _remove() async {
    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);
    try {
      await _repository.removeSet(widget.set.id);
      navigator.pop();
    } on Exception {
      messenger.showSnackBar(
        const SnackBar(content: Text(WorkoutStrings.saveError)),
      );
    }
  }

  Future<void> _complete() async {
    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);
    try {
      await _repository.setCompleted(widget.set.id, completed: true);
      navigator.pop();
    } on Exception {
      messenger.showSnackBar(
        const SnackBar(content: Text(WorkoutStrings.saveError)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final rir = _values.rir;

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                WorkoutStrings.setTitle(widget.set.setNumber),
                style: theme.textTheme.titleLarge,
              ),
              Text(
                widget.exerciseName,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 16),
              _Stepper(
                label: '${WorkoutStrings.weight} (${widget.unit.symbol})',
                onDecrease: () => _stepWeight(-1),
                onIncrease: () => _stepWeight(1),
                child: TextField(
                  key: const Key('set-weight-field'),
                  controller: _weight,
                  onChanged: _typedWeight,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineSmall,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(border: InputBorder.none),
                ),
              ),
              const SizedBox(height: 8),
              _Stepper(
                label: WorkoutStrings.reps,
                onDecrease: () => _stepReps(-1),
                onIncrease: () => _stepReps(1),
                child: TextField(
                  key: const Key('set-reps-field'),
                  controller: _reps,
                  onChanged: _typedReps,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineSmall,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(border: InputBorder.none),
                ),
              ),
              const SizedBox(height: 8),
              _Stepper(
                label: WorkoutStrings.rir,
                hint: WorkoutStrings.rirHint,
                onDecrease: () => _stepRir(-1),
                onIncrease: () => _stepRir(1),
                child: Text(
                  rir == null ? WorkoutStrings.noValue : '$rir',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineSmall,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  TextButton.icon(
                    style: TextButton.styleFrom(
                      minimumSize: const Size(0, 52),
                      foregroundColor: theme.colorScheme.error,
                    ),
                    onPressed: _remove,
                    icon: const Icon(Icons.delete_outline),
                    label: const Text(WorkoutStrings.removeSet),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(0, 52),
                      ),
                      onPressed: widget.set.isCompleted
                          ? () => Navigator.of(context).pop()
                          : _complete,
                      child: Text(
                        widget.set.isCompleted
                            ? WorkoutStrings.done
                            : WorkoutStrings.completeSet,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A value between large − and + buttons.
class _Stepper extends StatelessWidget {
  const _Stepper({
    required this.label,
    required this.onDecrease,
    required this.onIncrease,
    required this.child,
    this.hint,
  });

  final String label;
  final String? hint;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const buttonSize = BoxConstraints.tightFor(width: 56, height: 56);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hint == null ? label : '$label · $hint',
          style: theme.textTheme.labelMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            IconButton.filled(
              style: neutralIconButtonStyle(theme),
              constraints: buttonSize,
              tooltip: '${WorkoutStrings.decrease} $label',
              onPressed: onDecrease,
              icon: const Icon(Icons.remove),
            ),
            Expanded(child: child),
            IconButton.filled(
              style: neutralIconButtonStyle(theme),
              constraints: buttonSize,
              tooltip: '${WorkoutStrings.increase} $label',
              onPressed: onIncrease,
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ],
    );
  }
}
