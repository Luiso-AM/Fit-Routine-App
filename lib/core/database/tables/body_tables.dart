// Drift check() constraints reference their own column getter by design.
// ignore_for_file: recursive_getters

import 'package:drift/drift.dart';

import 'table_mixins.dart';

@DataClassName('BodyWeightEntryRow')
@TableIndex(name: 'idx_body_weight_entries_date', columns: {#date})
class BodyWeightEntries extends Table with EntityColumns {
  DateTimeColumn get date => dateTime()();

  RealColumn get weightKg => real().check(weightKg.isBiggerThanValue(0))();
}

/// Body circumferences in cm. Every measurement is optional.
@DataClassName('BodyMeasurementRow')
@TableIndex(name: 'idx_body_measurements_date', columns: {#date})
class BodyMeasurements extends Table with EntityColumns {
  DateTimeColumn get date => dateTime()();

  RealColumn get waistCm => real().nullable()();

  RealColumn get chestCm => real().nullable()();

  RealColumn get armCm => real().nullable()();

  RealColumn get legCm => real().nullable()();

  RealColumn get hipCm => real().nullable()();

  RealColumn get bodyFatPct =>
      real().nullable().check(bodyFatPct.isBetweenValues(0, 100))();
}
