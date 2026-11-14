import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/tables/body_tables.dart';

part 'body_metrics_dao.g.dart';

@DriftAccessor(tables: [BodyWeightEntries, BodyMeasurements])
class BodyMetricsDao extends DatabaseAccessor<AppDatabase>
    with _$BodyMetricsDaoMixin {
  BodyMetricsDao(super.attachedDatabase);

  // Body weight.

  Stream<List<BodyWeightEntryRow>> watchWeights() =>
      (select(bodyWeightEntries)..orderBy([
            (w) => OrderingTerm.desc(w.date),
            (w) => OrderingTerm.desc(w.createdAt),
          ]))
          .watch();

  Future<BodyWeightEntryRow?> getWeightById(String id) => (select(
    bodyWeightEntries,
  )..where((w) => w.id.equals(id))).getSingleOrNull();

  Future<List<BodyWeightEntryRow>> getWeightsOn(DateTime date) =>
      (select(bodyWeightEntries)..where((w) => w.date.equals(date))).get();

  Future<BodyWeightEntryRow> insertWeight(BodyWeightEntriesCompanion row) =>
      into(bodyWeightEntries).insertReturning(row);

  Future<void> updateWeightById(
    String id,
    BodyWeightEntriesCompanion changes,
  ) =>
      (update(bodyWeightEntries)..where((w) => w.id.equals(id))).write(changes);

  Future<int> deleteWeightById(String id) =>
      (delete(bodyWeightEntries)..where((w) => w.id.equals(id))).go();

  // Measurements.

  Stream<List<BodyMeasurementRow>> watchMeasurements() =>
      (select(bodyMeasurements)..orderBy([
            (m) => OrderingTerm.desc(m.date),
            (m) => OrderingTerm.desc(m.createdAt),
          ]))
          .watch();

  Stream<BodyMeasurementRow?> watchMeasurementById(String id) => (select(
    bodyMeasurements,
  )..where((m) => m.id.equals(id))).watchSingleOrNull();

  Future<BodyMeasurementRow?> getMeasurementById(String id) => (select(
    bodyMeasurements,
  )..where((m) => m.id.equals(id))).getSingleOrNull();

  Future<BodyMeasurementRow> insertMeasurement(BodyMeasurementsCompanion row) =>
      into(bodyMeasurements).insertReturning(row);

  Future<void> updateMeasurementById(
    String id,
    BodyMeasurementsCompanion changes,
  ) => (update(bodyMeasurements)..where((m) => m.id.equals(id))).write(changes);

  Future<int> deleteMeasurementById(String id) =>
      (delete(bodyMeasurements)..where((m) => m.id.equals(id))).go();
}
