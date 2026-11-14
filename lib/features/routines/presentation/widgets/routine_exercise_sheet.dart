import 'package:material_ui/material_ui.dart';

import '../../../../core/units/weight_conversion.dart';
import '../../../../core/units/weight_unit.dart';
import '../../../../core/utils/decimal_input.dart';
import '../../domain/routine.dart';
import '../../domain/routine_drafts.dart';
import '../routine_strings.dart';

/// What the user chose in the exercise sheet.
sealed class ExerciseSheetResult {
  const ExerciseSheetResult();
}

class ExerciseTargetsSaved extends ExerciseSheetResult {
  const ExerciseTargetsSaved(this.draft);

  final RoutineExerciseDraft draft;
}

class ExerciseRemoveRequested extends ExerciseSheetResult {
  const ExerciseRemoveRequested();
}

/// Targets of an exercise in a routine day. The initial weight is entered
/// in [unit] (the exercise's preferred unit) and kept in kg in the draft.
class RoutineExerciseSheet extends StatefulWidget {
  const RoutineExerciseSheet({
    required this.title,
    required this.exercise,
    required this.unit,
    super.key,
  });

  final String title;
  final RoutineExercise exercise;
  final WeightUnit unit;

  static Future<ExerciseSheetResult?> show(
    BuildContext context, {
    required String title,
    required RoutineExercise exercise,
    required WeightUnit unit,
  }) => showModalBottomSheet<ExerciseSheetResult>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (_) =>
        RoutineExerciseSheet(title: title, exercise: exercise, unit: unit),
  );

  @override
  State<RoutineExerciseSheet> createState() => _RoutineExerciseSheetState();
}

class _RoutineExerciseSheetState extends State<RoutineExerciseSheet> {
  late RoutineExerciseDraft _draft = RoutineExerciseDraft.fromExercise(
    widget.exercise,
  );
  late final _sets = _intController(_draft.targetSets);
  late final _repsMin = _intController(_draft.targetRepsMin);
  late final _repsMax = _intController(_draft.targetRepsMax);
  late final _rest = _intController(_draft.restSeconds);
  late final _weight = TextEditingController(
    text: switch (_draft.initialWeightKg) {
      final kg? => formatDecimalInput(fromKg(kg, widget.unit)),
      null => '',
    },
  );
  late final _notes = TextEditingController(text: _draft.notes);
  bool _submitted = false;

  static TextEditingController _intController(int? value) =>
      TextEditingController(text: value?.toString() ?? '');

  @override
  void dispose() {
    for (final c in [_sets, _repsMin, _repsMax, _rest, _weight, _notes]) {
      c.dispose();
    }
    super.dispose();
  }

  Set<RoutineExerciseValidationError> get _errors =>
      _submitted ? _draft.validate() : const {};

  void _update(RoutineExerciseDraft draft) => setState(() => _draft = draft);

  void _submit() {
    setState(() => _submitted = true);
    if (_draft.validate().isNotEmpty) return;
    Navigator.of(context).pop(ExerciseTargetsSaved(_draft));
  }

  String? _error(Map<RoutineExerciseValidationError, String> messages) {
    for (final MapEntry(key: error, value: message) in messages.entries) {
      if (_errors.contains(error)) return message;
    }
    return null;
  }

  Widget _intField({
    required TextEditingController controller,
    required String label,
    required ValueChanged<int?> onChanged,
    String? suffix,
    String? errorText,
  }) => TextField(
    controller: controller,
    keyboardType: TextInputType.number,
    onChanged: (text) => onChanged(parseIntInput(text)),
    decoration: InputDecoration(
      labelText: label,
      suffixText: suffix,
      errorText: errorText,
      errorMaxLines: 2,
    ),
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const gap = SizedBox(height: 16);
    const repsErrors = {
      RoutineExerciseValidationError.repsOutOfRange:
          RoutineStrings.repsOutOfRange,
      RoutineExerciseValidationError.repsRangeInverted:
          RoutineStrings.repsRangeInverted,
    };

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(widget.title, style: theme.textTheme.titleLarge),
              gap,
              _intField(
                controller: _sets,
                label: RoutineStrings.sets,
                errorText: _error(const {
                  RoutineExerciseValidationError.setsRequired:
                      RoutineStrings.required,
                  RoutineExerciseValidationError.setsOutOfRange:
                      RoutineStrings.setsOutOfRange,
                }),
                onChanged: (v) => _update(_draft.copyWith(targetSets: v)),
              ),
              gap,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _intField(
                      controller: _repsMin,
                      label: RoutineStrings.repsMin,
                      errorText: _error({
                        RoutineExerciseValidationError.repsMinRequired:
                            RoutineStrings.required,
                        ...repsErrors,
                      }),
                      onChanged: (v) =>
                          _update(_draft.copyWith(targetRepsMin: v)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _intField(
                      controller: _repsMax,
                      label: RoutineStrings.repsMax,
                      errorText: _error(const {
                        RoutineExerciseValidationError.repsMaxRequired:
                            RoutineStrings.required,
                      }),
                      onChanged: (v) =>
                          _update(_draft.copyWith(targetRepsMax: v)),
                    ),
                  ),
                ],
              ),
              gap,
              TextField(
                controller: _weight,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                onChanged: (text) {
                  final value = parseDecimalInput(text);
                  _update(
                    _draft.copyWith(
                      // Empty means "no initial weight"; invalid text is
                      // kept as an out-of-range value so it is reported.
                      initialWeightKg: text.trim().isEmpty
                          ? null
                          : value == null
                          ? -1
                          : toKg(value, widget.unit),
                    ),
                  );
                },
                decoration: InputDecoration(
                  labelText: RoutineStrings.initialWeightOptional,
                  suffixText: widget.unit.symbol,
                  errorText: _error(const {
                    RoutineExerciseValidationError.weightOutOfRange:
                        RoutineStrings.weightOutOfRange,
                  }),
                ),
              ),
              gap,
              _intField(
                controller: _rest,
                label: RoutineStrings.rest,
                suffix: RoutineStrings.seconds,
                errorText: _error(const {
                  RoutineExerciseValidationError.restRequired:
                      RoutineStrings.required,
                  RoutineExerciseValidationError.restOutOfRange:
                      RoutineStrings.restOutOfRange,
                }),
                onChanged: (v) => _update(_draft.copyWith(restSeconds: v)),
              ),
              gap,
              TextField(
                controller: _notes,
                minLines: 1,
                maxLines: 4,
                textCapitalization: TextCapitalization.sentences,
                onChanged: (text) => _update(_draft.copyWith(notes: text)),
                decoration: InputDecoration(
                  labelText: RoutineStrings.notesOptional,
                  errorText: _error(const {
                    RoutineExerciseValidationError.notesTooLong:
                        RoutineStrings.notesTooLong,
                  }),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(0, 52),
                        foregroundColor: theme.colorScheme.error,
                      ),
                      onPressed: () =>
                          Navigator.of(context)
                              .pop(const ExerciseRemoveRequested()),
                      child: const Text(RoutineStrings.remove),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(0, 52),
                      ),
                      onPressed: _submit,
                      child: const Text(RoutineStrings.save),
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
