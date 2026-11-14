import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/tables/table_mixins.dart';
import '../domain/body_measurement.dart';
import '../domain/body_measurement_draft.dart';
import '../domain/body_metrics_repository.dart';
import '../domain/body_weight_draft.dart';
import '../domain/body_weight_entry.dart';
import 'body_metrics_dao.dart';
import 'body_metrics_mapper.dart';

class DriftBodyMetricsRepository implements BodyMetricsRepository {
  /// [clock] returns the current local time; it bounds future dates.
  DriftBodyMetricsRepository(AppDatabase db, {this._clock = DateTime.now})
    : _db = db,
      _dao = BodyMetricsDao(db);

  final AppDatabase _db;
  final BodyMetricsDao _dao;
  final DateTime Function() _clock;

  @override
  Stream<List<BodyWeightEntry>> watchWeights() => _dao.watchWeights().map(
    (rows) => [for (final row in rows) row.toDomain()],
  );

  @override
  Future<BodyWeightEntry> logWeight(BodyWeightDraft draft) async {
    _validateWeight(draft);
    return _db.transaction(() => upsertWeightForDate(_dao, draft));
  }

  @override
  Future<void> updateWeight(String id, BodyWeightDraft draft) async {
    _validateWeight(draft);
    await _db.transaction(() async {
      if (await _dao.getWeightById(id) == null) {
        throw BodyEntryNotFoundException(id);
      }
      final companion = draft.toCompanion();
      // Keep one entry per day: this entry replaces any other on its date.
      for (final other in await _dao.getWeightsOn(companion.date.value)) {
        if (other.id != id) await _dao.deleteWeightById(other.id);
      }
      await _dao.updateWeightById(
        id,
        companion.copyWith(updatedAt: Value(nowUtc())),
      );
    });
  }

  @override
  Future<void> deleteWeight(String id) async {
    if (await _dao.deleteWeightById(id) == 0) {
      throw BodyEntryNotFoundException(id);
    }
  }

  @override
  Stream<List<BodyMeasurement>> watchMeasurements() => _dao
      .watchMeasurements()
      .map((rows) => [for (final row in rows) row.toDomain()]);

  @override
  Stream<BodyMeasurement?> watchMeasurementById(String id) =>
      _dao.watchMeasurementById(id).map((row) => row?.toDomain());

  @override
  Future<BodyMeasurement> logMeasurement(BodyMeasurementDraft draft) async {
    _validateMeasurement(draft);
    return (await _dao.insertMeasurement(draft.toCompanion())).toDomain();
  }

  @override
  Future<void> updateMeasurement(String id, BodyMeasurementDraft draft) async {
    _validateMeasurement(draft);
    if (await _dao.getMeasurementById(id) == null) {
      throw BodyEntryNotFoundException(id);
    }
    await _dao.updateMeasurementById(
      id,
      draft.toCompanion().copyWith(updatedAt: Value(nowUtc())),
    );
  }

  @override
  Future<void> deleteMeasurement(String id) async {
    if (await _dao.deleteMeasurementById(id) == 0) {
      throw BodyEntryNotFoundException(id);
    }
  }

  void _validateWeight(BodyWeightDraft draft) {
    final errors = draft.validate(today: _clock());
    if (errors.isNotEmpty) throw BodyWeightValidationException(errors);
  }

  void _validateMeasurement(BodyMeasurementDraft draft) {
    final errors = draft.validate(today: _clock());
    if (errors.isNotEmpty) throw BodyMeasurementValidationException(errors);
  }
}

/// Inserts a validated weight, or replaces the weight of the entry already on
/// that date. Call it inside a transaction.
Future<BodyWeightEntry> upsertWeightForDate(
  BodyMetricsDao dao,
  BodyWeightDraft draft,
) async {
  final companion = draft.toCompanion();
  final existing = await dao.getWeightsOn(companion.date.value);
  if (existing.isEmpty) {
    return (await dao.insertWeight(companion)).toDomain();
  }
  final kept = existing.first;
  for (final extra in existing.skip(1)) {
    await dao.deleteWeightById(extra.id);
  }
  await dao.updateWeightById(
    kept.id,
    companion.copyWith(updatedAt: Value(nowUtc())),
  );
  return (await dao.getWeightById(kept.id))!.toDomain();
}
