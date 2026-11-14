import 'package:app_entrenamiento/core/database/app_database.dart';
import 'package:app_entrenamiento/features/profile/data/drift_body_metrics_repository.dart';
import 'package:app_entrenamiento/features/profile/domain/body_measurement_draft.dart';
import 'package:app_entrenamiento/features/profile/domain/body_metrics_repository.dart';
import 'package:app_entrenamiento/features/profile/domain/body_weight_draft.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

DateTime _clock() => DateTime(2026, 11, 14, 10);

BodyWeightDraft _weight(int day, double kg) =>
    BodyWeightDraft(date: DateTime.utc(2026, 11, day), weightKg: kg);

void main() {
  late AppDatabase db;
  late DriftBodyMetricsRepository repository;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repository = DriftBodyMetricsRepository(db, clock: _clock);
  });

  tearDown(() async {
    await db.close();
  });

  group('body weight', () {
    test('given entries on several days, when watched, '
        'then they come newest first', () async {
      await repository.logWeight(_weight(10, 79));
      await repository.logWeight(_weight(14, 78));
      await repository.logWeight(_weight(12, 78.5));

      final weights = await repository.watchWeights().first;
      expect([for (final w in weights) w.date.day], [14, 12, 10]);
    });

    test('given an entry today, when another weight is logged today, '
        'then it replaces the first one', () async {
      final first = await repository.logWeight(_weight(14, 78));

      final second = await repository.logWeight(_weight(14, 77.6));

      final weights = await repository.watchWeights().first;
      expect(weights, hasLength(1));
      expect(weights.single.weightKg, 77.6);
      expect(second.id, first.id);
    });

    test('given a weight with many decimals, when logged, '
        'then it is stored without rounding', () async {
      await repository.logWeight(_weight(14, 78.123456));
      expect(
        (await repository.watchWeights().first).single.weightKg,
        78.123456,
      );
    });

    test('given an invalid weight, when logged, then it is rejected', () async {
      expect(
        repository.logWeight(_weight(15, 78)),
        throwsA(
          isA<BodyWeightValidationException>().having(
            (e) => e.errors,
            'errors',
            {BodyWeightValidationError.dateInFuture},
          ),
        ),
      );
    });

    test('given an entry, when updated, then weight and date change', () async {
      final entry = await repository.logWeight(_weight(10, 79));

      await repository.updateWeight(entry.id, _weight(11, 78.8));

      final updated = (await repository.watchWeights().first).single;
      expect(updated.id, entry.id);
      expect(updated.date, DateTime.utc(2026, 11, 11));
      expect(updated.weightKg, 78.8);
    });

    test('given an entry moved to a day that has another, when updated, '
        'then the other entry is replaced', () async {
      final moved = await repository.logWeight(_weight(10, 79));
      await repository.logWeight(_weight(11, 78));

      await repository.updateWeight(moved.id, _weight(11, 78.6));

      final weights = await repository.watchWeights().first;
      expect(weights, hasLength(1));
      expect(weights.single.id, moved.id);
      expect(weights.single.weightKg, 78.6);
    });

    test('given an entry, when deleted, then it is gone', () async {
      final entry = await repository.logWeight(_weight(10, 79));

      await repository.deleteWeight(entry.id);

      expect(await repository.watchWeights().first, isEmpty);
    });

    test('given a missing id, when updated or deleted, '
        'then it is not found', () async {
      expect(
        repository.updateWeight('missing', _weight(10, 79)),
        throwsA(isA<BodyEntryNotFoundException>()),
      );
      expect(
        repository.deleteWeight('missing'),
        throwsA(isA<BodyEntryNotFoundException>()),
      );
    });
  });

  group('measurements', () {
    final draft = BodyMeasurementDraft(
      date: DateTime.utc(2026, 11, 14),
      waistCm: 82,
      bodyFatPct: 18,
    );

    test('given a valid measurement, when logged, '
        'then only the given values are stored', () async {
      final logged = await repository.logMeasurement(draft);

      final stored = await repository.watchMeasurementById(logged.id).first;
      expect(stored, logged);
      expect(stored!.waistCm, 82);
      expect(stored.bodyFatPct, 18);
      expect(stored.chestCm, isNull);
    });

    test('given two measurements on the same day, when logged, '
        'then both are kept, newest first', () async {
      final first = await repository.logMeasurement(draft);
      await Future<void>.delayed(const Duration(milliseconds: 5));
      final second = await repository.logMeasurement(
        draft.copyWith(waistCm: 81),
      );
      await repository.logMeasurement(
        draft.copyWith(date: DateTime.utc(2026, 11, 1)),
      );

      final all = await repository.watchMeasurements().first;
      expect([for (final m in all) m.id].take(2), [second.id, first.id]);
      expect(all.last.date, DateTime.utc(2026, 11, 1));
    });

    test('given a measurement without values, when logged, '
        'then it is rejected', () async {
      expect(
        repository.logMeasurement(
          BodyMeasurementDraft(date: DateTime.utc(2026, 11, 14)),
        ),
        throwsA(isA<BodyMeasurementValidationException>()),
      );
    });

    test('given a measurement, when a value is cleared on update, '
        'then it is stored as null', () async {
      final logged = await repository.logMeasurement(draft);

      await repository.updateMeasurement(
        logged.id,
        draft.copyWith(bodyFatPct: null, armCm: 35),
      );

      final stored = await repository.watchMeasurementById(logged.id).first;
      expect(stored!.bodyFatPct, isNull);
      expect(stored.armCm, 35);
    });

    test('given a measurement, when deleted, then it is gone', () async {
      final logged = await repository.logMeasurement(draft);

      await repository.deleteMeasurement(logged.id);

      expect(await repository.watchMeasurementById(logged.id).first, isNull);
      expect(
        repository.deleteMeasurement(logged.id),
        throwsA(isA<BodyEntryNotFoundException>()),
      );
    });
  });
}
