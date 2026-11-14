import 'package:app_entrenamiento/core/utils/calendar_date.dart';
import 'package:app_entrenamiento/features/profile/domain/body_measurement.dart';
import 'package:app_entrenamiento/features/profile/domain/body_measurement_draft.dart';
import 'package:app_entrenamiento/features/profile/domain/body_metrics_repository.dart';
import 'package:app_entrenamiento/features/profile/domain/body_weight_draft.dart';
import 'package:app_entrenamiento/features/profile/domain/body_weight_entry.dart';

import 'watchable.dart';

/// In-memory [BodyMetricsRepository] for widget tests. Follows the same
/// rules as the Drift implementation.
class FakeBodyMetricsRepository
    with Watchable
    implements BodyMetricsRepository {
  FakeBodyMetricsRepository({
    Iterable<BodyWeightEntry> weights = const [],
    Iterable<BodyMeasurement> measurements = const [],
  }) : _weights = {for (final w in weights) w.id: w},
       _measurements = [...measurements];

  final Map<String, BodyWeightEntry> _weights;
  final List<BodyMeasurement> _measurements;
  int _nextId = 1;

  List<BodyWeightEntry> get weights =>
      _weights.values.toList()..sort((a, b) => b.date.compareTo(a.date));

  List<BodyMeasurement> get measurements {
    // Newest date first; on the same date, the latest logged first.
    final indexed = _measurements.indexed.toList()
      ..sort((a, b) {
        final byDate = b.$2.date.compareTo(a.$2.date);
        return byDate != 0 ? byDate : b.$1.compareTo(a.$1);
      });
    return [for (final (_, m) in indexed) m];
  }

  String _newId(String prefix) => '$prefix-${_nextId++}';

  @override
  Stream<List<BodyWeightEntry>> watchWeights() => watchValue(() => weights);

  @override
  Future<BodyWeightEntry> logWeight(BodyWeightDraft draft) async {
    _validateWeight(draft);
    final date = calendarDate(draft.date!);
    final existing = _weights.values.where((w) => w.date == date).firstOrNull;
    final entry = BodyWeightEntry(
      id: existing?.id ?? _newId('weight'),
      date: date,
      weightKg: draft.weightKg!,
    );
    _weights[entry.id] = entry;
    notifyChanged();
    return entry;
  }

  @override
  Future<void> updateWeight(String id, BodyWeightDraft draft) async {
    _validateWeight(draft);
    if (!_weights.containsKey(id)) throw BodyEntryNotFoundException(id);
    final date = calendarDate(draft.date!);
    _weights
      ..removeWhere((key, w) => key != id && w.date == date)
      ..[id] = BodyWeightEntry(id: id, date: date, weightKg: draft.weightKg!);
    notifyChanged();
  }

  @override
  Future<void> deleteWeight(String id) async {
    if (_weights.remove(id) == null) throw BodyEntryNotFoundException(id);
    notifyChanged();
  }

  @override
  Stream<List<BodyMeasurement>> watchMeasurements() =>
      watchValue(() => measurements);

  @override
  Stream<BodyMeasurement?> watchMeasurementById(String id) =>
      watchValue(() => _measurements.where((m) => m.id == id).firstOrNull);

  @override
  Future<BodyMeasurement> logMeasurement(BodyMeasurementDraft draft) async {
    _validateMeasurement(draft);
    final measurement = _fromDraft(_newId('measurement'), draft);
    _measurements.add(measurement);
    notifyChanged();
    return measurement;
  }

  @override
  Future<void> updateMeasurement(String id, BodyMeasurementDraft draft) async {
    _validateMeasurement(draft);
    final index = _measurements.indexWhere((m) => m.id == id);
    if (index < 0) throw BodyEntryNotFoundException(id);
    _measurements[index] = _fromDraft(id, draft);
    notifyChanged();
  }

  @override
  Future<void> deleteMeasurement(String id) async {
    final index = _measurements.indexWhere((m) => m.id == id);
    if (index < 0) throw BodyEntryNotFoundException(id);
    _measurements.removeAt(index);
    notifyChanged();
  }

  void _validateWeight(BodyWeightDraft draft) {
    final errors = draft.validate(today: DateTime.now());
    if (errors.isNotEmpty) throw BodyWeightValidationException(errors);
  }

  void _validateMeasurement(BodyMeasurementDraft draft) {
    final errors = draft.validate(today: DateTime.now());
    if (errors.isNotEmpty) throw BodyMeasurementValidationException(errors);
  }

  BodyMeasurement _fromDraft(String id, BodyMeasurementDraft draft) =>
      BodyMeasurement(
        id: id,
        date: calendarDate(draft.date!),
        waistCm: draft.waistCm,
        chestCm: draft.chestCm,
        armCm: draft.armCm,
        legCm: draft.legCm,
        hipCm: draft.hipCm,
        bodyFatPct: draft.bodyFatPct,
      );
}
