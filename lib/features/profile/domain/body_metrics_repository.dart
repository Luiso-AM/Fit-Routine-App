import 'body_measurement.dart';
import 'body_measurement_draft.dart';
import 'body_weight_draft.dart';
import 'body_weight_entry.dart';

abstract interface class BodyMetricsRepository {
  /// Every body weight entry, newest date first.
  Stream<List<BodyWeightEntry>> watchWeights();

  /// Logs a body weight. If that date already has an entry, its weight is
  /// replaced, so there is never more than one entry per day.
  ///
  /// Throws [BodyWeightValidationException].
  Future<BodyWeightEntry> logWeight(BodyWeightDraft draft);

  /// Updates an entry. If another entry exists on the new date, it is
  /// replaced by this one.
  ///
  /// Throws [BodyEntryNotFoundException] or [BodyWeightValidationException].
  Future<void> updateWeight(String id, BodyWeightDraft draft);

  /// Throws [BodyEntryNotFoundException].
  Future<void> deleteWeight(String id);

  /// Every measurement, newest date first. A day may have several.
  Stream<List<BodyMeasurement>> watchMeasurements();

  Stream<BodyMeasurement?> watchMeasurementById(String id);

  /// Throws [BodyMeasurementValidationException].
  Future<BodyMeasurement> logMeasurement(BodyMeasurementDraft draft);

  /// Throws [BodyEntryNotFoundException] or
  /// [BodyMeasurementValidationException].
  Future<void> updateMeasurement(String id, BodyMeasurementDraft draft);

  /// Throws [BodyEntryNotFoundException].
  Future<void> deleteMeasurement(String id);
}

class BodyEntryNotFoundException implements Exception {
  const BodyEntryNotFoundException(this.id);

  final String id;

  @override
  String toString() => 'BodyEntryNotFoundException: $id';
}

class BodyWeightValidationException implements Exception {
  const BodyWeightValidationException(this.errors);

  final Set<BodyWeightValidationError> errors;

  @override
  String toString() => 'BodyWeightValidationException: $errors';
}

class BodyMeasurementValidationException implements Exception {
  const BodyMeasurementValidationException(this.errors);

  final Set<BodyMeasurementValidationError> errors;

  @override
  String toString() => 'BodyMeasurementValidationException: $errors';
}
