// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'body_metrics_dao.dart';

// ignore_for_file: type=lint
mixin _$BodyMetricsDaoMixin on DatabaseAccessor<AppDatabase> {
  $BodyWeightEntriesTable get bodyWeightEntries =>
      attachedDatabase.bodyWeightEntries;
  $BodyMeasurementsTable get bodyMeasurements =>
      attachedDatabase.bodyMeasurements;
  BodyMetricsDaoManager get managers => BodyMetricsDaoManager(this);
}

class BodyMetricsDaoManager {
  final _$BodyMetricsDaoMixin _db;
  BodyMetricsDaoManager(this._db);
  $$BodyWeightEntriesTableTableManager get bodyWeightEntries =>
      $$BodyWeightEntriesTableTableManager(
        _db.attachedDatabase,
        _db.bodyWeightEntries,
      );
  $$BodyMeasurementsTableTableManager get bodyMeasurements =>
      $$BodyMeasurementsTableTableManager(
        _db.attachedDatabase,
        _db.bodyMeasurements,
      );
}
