import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/utils/calendar_date.dart';
import '../../../../core/utils/decimal_input.dart';
import '../../../../core/widgets/date_field.dart';
import '../../data/profile_data_providers.dart';
import '../../domain/body_measurement.dart';
import '../../domain/body_measurement_draft.dart';
import '../../domain/body_metrics_repository.dart';
import '../profile_providers.dart';
import '../profile_strings.dart';
import '../widgets/body_entry_widgets.dart';
import '../widgets/profile_form_fields.dart';

/// Logs body measurements, or edits the one with [measurementId].
class BodyMeasurementFormScreen extends ConsumerWidget {
  const BodyMeasurementFormScreen({this.measurementId, super.key});

  final String? measurementId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = measurementId;
    if (id == null) return const _MeasurementForm(initial: null);

    return switch (ref.watch(bodyMeasurementByIdProvider(id))) {
      AsyncData(value: final measurement?) => _MeasurementForm(
        initial: measurement,
      ),
      AsyncData() => _message(ProfileStrings.measurementNotFound),
      AsyncError() => _message(ProfileStrings.loadError),
      _ => Scaffold(
        appBar: AppBar(),
        body: const Center(child: CircularProgressIndicator()),
      ),
    };
  }

  static Widget _message(String text) =>
      Scaffold(appBar: AppBar(), body: EmptyMessage(text));
}

/// A measurement field: its label, suffix, draft accessors and range error.
typedef _Field = ({
  String label,
  String suffix,
  double? Function(BodyMeasurementDraft) read,
  BodyMeasurementDraft Function(BodyMeasurementDraft, double?) write,
  BodyMeasurementValidationError error,
});

final List<_Field> _fields = [
  (
    label: ProfileStrings.waist,
    suffix: ProfileStrings.cm,
    read: (d) => d.waistCm,
    write: (d, v) => d.copyWith(waistCm: v),
    error: BodyMeasurementValidationError.waistOutOfRange,
  ),
  (
    label: ProfileStrings.chest,
    suffix: ProfileStrings.cm,
    read: (d) => d.chestCm,
    write: (d, v) => d.copyWith(chestCm: v),
    error: BodyMeasurementValidationError.chestOutOfRange,
  ),
  (
    label: ProfileStrings.arm,
    suffix: ProfileStrings.cm,
    read: (d) => d.armCm,
    write: (d, v) => d.copyWith(armCm: v),
    error: BodyMeasurementValidationError.armOutOfRange,
  ),
  (
    label: ProfileStrings.leg,
    suffix: ProfileStrings.cm,
    read: (d) => d.legCm,
    write: (d, v) => d.copyWith(legCm: v),
    error: BodyMeasurementValidationError.legOutOfRange,
  ),
  (
    label: ProfileStrings.hip,
    suffix: ProfileStrings.cm,
    read: (d) => d.hipCm,
    write: (d, v) => d.copyWith(hipCm: v),
    error: BodyMeasurementValidationError.hipOutOfRange,
  ),
  (
    label: ProfileStrings.bodyFat,
    suffix: ProfileStrings.percent,
    read: (d) => d.bodyFatPct,
    write: (d, v) => d.copyWith(bodyFatPct: v),
    error: BodyMeasurementValidationError.bodyFatOutOfRange,
  ),
];

class _MeasurementForm extends ConsumerStatefulWidget {
  const _MeasurementForm({required this.initial});

  /// `null` when logging a new measurement.
  final BodyMeasurement? initial;

  @override
  ConsumerState<_MeasurementForm> createState() => _MeasurementFormState();
}

class _MeasurementFormState extends ConsumerState<_MeasurementForm> {
  late BodyMeasurementDraft _draft = widget.initial == null
      ? BodyMeasurementDraft(date: calendarDate(DateTime.now()))
      : BodyMeasurementDraft.fromMeasurement(widget.initial!);
  late final List<TextEditingController> _controllers = [
    for (final field in _fields)
      TextEditingController(
        text: switch (field.read(_draft)) {
          final value? => formatDecimalInput(value),
          null => '',
        },
      ),
  ];
  bool _submitted = false;
  bool _busy = false;

  bool get _isEditing => widget.initial != null;

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Set<BodyMeasurementValidationError> get _errors => _submitted
      ? _draft.validate(today: DateTime.now())
      : const <BodyMeasurementValidationError>{};

  Future<void> _run(
    Future<void> Function(BodyMetricsRepository repository) action,
    String done,
    String failed,
  ) async {
    setState(() => _busy = true);
    final messenger = ScaffoldMessenger.of(context);
    try {
      await action(ref.read(bodyMetricsRepositoryProvider));
      if (mounted) context.pop();
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
          ? await repository.updateMeasurement(widget.initial!.id, _draft)
          : await repository.logMeasurement(_draft),
      ProfileStrings.measurementsSaved,
      ProfileStrings.saveError,
    );
  }

  Future<void> _delete() async {
    if (!await confirmDeleteEntry(context) || !mounted) return;
    await _run(
      (repository) => repository.deleteMeasurement(widget.initial!.id),
      ProfileStrings.entryDeleted,
      ProfileStrings.deleteError,
    );
  }

  static String _rangeMessage(BodyMeasurementValidationError error) =>
      error == BodyMeasurementValidationError.bodyFatOutOfRange
      ? ProfileStrings.bodyFatOutOfRange
      : ProfileStrings.circumferenceOutOfRange;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final errors = _errors;
    final today = calendarDate(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isEditing
              ? ProfileStrings.editMeasurements
              : ProfileStrings.logMeasurements,
        ),
        actions: [
          if (_isEditing)
            IconButton(
              tooltip: ProfileStrings.delete,
              icon: const Icon(Icons.delete_outline),
              onPressed: _busy ? null : _delete,
            ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          Text(
            ProfileStrings.measurementsHint,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          // Shown at the top: it concerns every field, not a single one.
          if (errors.contains(BodyMeasurementValidationError.noValues)) ...[
            const SizedBox(height: 8),
            Text(
              ProfileStrings.measurementNoValues,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.error,
              ),
            ),
          ],
          const SizedBox(height: 16),
          DateField(
            label: ProfileStrings.date,
            value: _draft.date,
            firstDate: DateTime.utc(today.year - 20),
            lastDate: today,
            errorText: firstErrorMessage(errors, const [
              BodyMeasurementValidationError.dateRequired,
              BodyMeasurementValidationError.dateInFuture,
            ], _dateMessage),
            onChanged: (date) =>
                setState(() => _draft = _draft.copyWith(date: date)),
          ),
          for (final (i, field) in _fields.indexed) ...[
            const SizedBox(height: 16),
            DecimalField(
              controller: _controllers[i],
              label: field.label,
              suffix: field.suffix,
              errorText: errors.contains(field.error)
                  ? _rangeMessage(field.error)
                  : null,
              onChanged: (value) =>
                  setState(() => _draft = field.write(_draft, value)),
            ),
          ],
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: FilledButton(
            style: FilledButton.styleFrom(minimumSize: const Size(0, 52)),
            onPressed: _busy ? null : _save,
            child: const Text(ProfileStrings.save),
          ),
        ),
      ),
    );
  }

  static String _dateMessage(BodyMeasurementValidationError error) =>
      error == BodyMeasurementValidationError.dateInFuture
      ? ProfileStrings.dateInFuture
      : ProfileStrings.dateRequired;
}
