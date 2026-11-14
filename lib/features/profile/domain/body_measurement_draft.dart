import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/utils/calendar_date.dart';
import 'body_measurement.dart';

part 'body_measurement_draft.freezed.dart';

const int kMinCircumferenceCm = 10;
const int kMaxCircumferenceCm = 300;
const int kMinBodyFatPct = 1;
const int kMaxBodyFatPct = 75;

enum BodyMeasurementValidationError {
  dateRequired,
  dateInFuture,
  noValues,
  waistOutOfRange,
  chestOutOfRange,
  armOutOfRange,
  legOutOfRange,
  hipOutOfRange,
  bodyFatOutOfRange,
}

@freezed
abstract class BodyMeasurementDraft with _$BodyMeasurementDraft {
  const factory BodyMeasurementDraft({
    /// Calendar date (UTC midnight).
    DateTime? date,
    double? waistCm,
    double? chestCm,
    double? armCm,
    double? legCm,
    double? hipCm,
    double? bodyFatPct,
  }) = _BodyMeasurementDraft;

  const BodyMeasurementDraft._();

  factory BodyMeasurementDraft.fromMeasurement(BodyMeasurement m) =>
      BodyMeasurementDraft(
        date: m.date,
        waistCm: m.waistCm,
        chestCm: m.chestCm,
        armCm: m.armCm,
        legCm: m.legCm,
        hipCm: m.hipCm,
        bodyFatPct: m.bodyFatPct,
      );

  Set<BodyMeasurementValidationError> validate({required DateTime today}) {
    final errors = <BodyMeasurementValidationError>{};

    final day = date;
    if (day == null) {
      errors.add(BodyMeasurementValidationError.dateRequired);
    } else if (calendarDate(day).isAfter(calendarDate(today))) {
      errors.add(BodyMeasurementValidationError.dateInFuture);
    }

    final circumferences = {
      BodyMeasurementValidationError.waistOutOfRange: waistCm,
      BodyMeasurementValidationError.chestOutOfRange: chestCm,
      BodyMeasurementValidationError.armOutOfRange: armCm,
      BodyMeasurementValidationError.legOutOfRange: legCm,
      BodyMeasurementValidationError.hipOutOfRange: hipCm,
    };
    for (final MapEntry(key: error, value: cm) in circumferences.entries) {
      if (cm != null &&
          (cm < kMinCircumferenceCm || cm > kMaxCircumferenceCm)) {
        errors.add(error);
      }
    }

    final fat = bodyFatPct;
    if (fat != null && (fat < kMinBodyFatPct || fat > kMaxBodyFatPct)) {
      errors.add(BodyMeasurementValidationError.bodyFatOutOfRange);
    }

    if ([...circumferences.values, fat].every((v) => v == null)) {
      errors.add(BodyMeasurementValidationError.noValues);
    }
    return errors;
  }
}
