import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../../../core/utils/calendar_date.dart';
import '../domain/body_measurement.dart';
import '../domain/body_measurement_draft.dart';
import '../domain/body_weight_draft.dart';
import '../domain/body_weight_entry.dart';

extension BodyWeightEntryRowMapper on BodyWeightEntryRow {
  BodyWeightEntry toDomain() => BodyWeightEntry(
    id: id,
    date: calendarDate(date.toUtc()),
    weightKg: weightKg,
  );
}

extension BodyWeightDraftMapper on BodyWeightDraft {
  /// Columns of a validated draft. Required fields must be set.
  BodyWeightEntriesCompanion toCompanion() => BodyWeightEntriesCompanion(
    date: Value(calendarDate(date!)),
    weightKg: Value(weightKg!),
  );
}

extension BodyMeasurementRowMapper on BodyMeasurementRow {
  BodyMeasurement toDomain() => BodyMeasurement(
    id: id,
    date: calendarDate(date.toUtc()),
    waistCm: waistCm,
    chestCm: chestCm,
    armCm: armCm,
    legCm: legCm,
    hipCm: hipCm,
    bodyFatPct: bodyFatPct,
  );
}

extension BodyMeasurementDraftMapper on BodyMeasurementDraft {
  /// Columns of a validated draft. Absent values are written as null.
  BodyMeasurementsCompanion toCompanion() => BodyMeasurementsCompanion(
    date: Value(calendarDate(date!)),
    waistCm: Value(waistCm),
    chestCm: Value(chestCm),
    armCm: Value(armCm),
    legCm: Value(legCm),
    hipCm: Value(hipCm),
    bodyFatPct: Value(bodyFatPct),
  );
}
