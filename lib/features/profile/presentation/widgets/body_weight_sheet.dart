import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/utils/calendar_date.dart';
import '../../../../core/utils/decimal_input.dart';
import '../../../../core/widgets/date_field.dart';
import '../../data/profile_data_providers.dart';
import '../../domain/body_metrics_repository.dart';
import '../../domain/body_weight_draft.dart';
import '../../domain/body_weight_entry.dart';
import '../profile_providers.dart';
import '../profile_strings.dart';
import 'body_entry_widgets.dart';
import 'profile_form_fields.dart';

/// Bottom sheet to log a body weight, or to edit or delete [entry].
class BodyWeightSheet extends ConsumerStatefulWidget {
  const BodyWeightSheet({this.entry, super.key});

  /// `null` when logging a new weight.
  final BodyWeightEntry? entry;

  static Future<void> show(BuildContext context, {BodyWeightEntry? entry}) =>
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        showDragHandle: true,
        builder: (_) => BodyWeightSheet(entry: entry),
      );

  @override
  ConsumerState<BodyWeightSheet> createState() => _BodyWeightSheetState();
}

class _BodyWeightSheetState extends ConsumerState<BodyWeightSheet> {
  late BodyWeightDraft _draft = widget.entry == null
      ? BodyWeightDraft(date: calendarDate(DateTime.now()))
      : BodyWeightDraft.fromEntry(widget.entry!);
  late final _weight = TextEditingController(
    text: switch (widget.entry) {
      final entry? => formatDecimalInput(entry.weightKg),
      null => '',
    },
  );
  bool _submitted = false;
  bool _busy = false;

  bool get _isEditing => widget.entry != null;

  @override
  void dispose() {
    _weight.dispose();
    super.dispose();
  }

  Set<BodyWeightValidationError> get _errors => _submitted
      ? _draft.validate(today: DateTime.now())
      : const <BodyWeightValidationError>{};

  /// Whether saving would replace another entry on the chosen date.
  bool get _replacesOther {
    final date = _draft.date;
    final weights = ref.watch(bodyWeightsProvider).value ?? const [];
    return date != null &&
        weights.any((w) => w.date == date && w.id != widget.entry?.id);
  }

  Future<void> _run(
    Future<void> Function(BodyMetricsRepository repository) action,
    String done,
    String failed,
  ) async {
    setState(() => _busy = true);
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    try {
      await action(ref.read(bodyMetricsRepositoryProvider));
      navigator.pop();
      messenger.showSnackBar(SnackBar(content: Text(done)));
    } on Exception {
      messenger.showSnackBar(SnackBar(content: Text(failed)));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _save() async {
    setState(() => _submitted = true);
    if (_errors.isNotEmpty) return;
    await _run(
      (repository) async => _isEditing
          ? await repository.updateWeight(widget.entry!.id, _draft)
          : await repository.logWeight(_draft),
      ProfileStrings.weightSaved,
      ProfileStrings.saveError,
    );
  }

  Future<void> _delete() async {
    if (!await confirmDeleteEntry(context) || !mounted) return;
    await _run(
      (repository) => repository.deleteWeight(widget.entry!.id),
      ProfileStrings.entryDeleted,
      ProfileStrings.deleteError,
    );
  }

  String? _error(List<BodyWeightValidationError> candidates) =>
      firstErrorMessage(_errors, candidates, bodyWeightErrorMessage);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final today = calendarDate(DateTime.now());

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
                _isEditing
                    ? ProfileStrings.editWeight
                    : ProfileStrings.logWeight,
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              DecimalField(
                controller: _weight,
                label: ProfileStrings.bodyWeight,
                suffix: ProfileStrings.kg,
                errorText: _error(const [
                  BodyWeightValidationError.weightRequired,
                  BodyWeightValidationError.weightOutOfRange,
                ]),
                onChanged: (kg) =>
                    setState(() => _draft = _draft.copyWith(weightKg: kg)),
              ),
              const SizedBox(height: 16),
              DateField(
                label: ProfileStrings.date,
                value: _draft.date,
                firstDate: DateTime.utc(today.year - 20),
                lastDate: today,
                helperText: _replacesOther
                    ? ProfileStrings.replacesEntry
                    : null,
                errorText: _error(const [
                  BodyWeightValidationError.dateRequired,
                  BodyWeightValidationError.dateInFuture,
                ]),
                onChanged: (date) =>
                    setState(() => _draft = _draft.copyWith(date: date)),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  if (_isEditing) ...[
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(0, 52),
                          foregroundColor: theme.colorScheme.error,
                        ),
                        onPressed: _busy ? null : _delete,
                        child: const Text(ProfileStrings.delete),
                      ),
                    ),
                    const SizedBox(width: 12),
                  ],
                  Expanded(
                    flex: 2,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(0, 52),
                      ),
                      onPressed: _busy ? null : _save,
                      child: const Text(ProfileStrings.save),
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
