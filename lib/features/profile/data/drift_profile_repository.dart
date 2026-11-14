import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/tables/table_mixins.dart';
import '../domain/body_metrics_repository.dart';
import '../domain/body_weight_draft.dart';
import '../domain/profile_repository.dart';
import '../domain/user_profile.dart';
import '../domain/user_profile_draft.dart';
import 'body_metrics_dao.dart';
import 'drift_body_metrics_repository.dart';
import 'profile_dao.dart';
import 'profile_mapper.dart';

class DriftProfileRepository implements ProfileRepository {
  /// [clock] returns the current local time; it bounds ages and dates.
  DriftProfileRepository(AppDatabase db, {this._clock = DateTime.now})
    : _db = db,
      _dao = ProfileDao(db),
      _bodyDao = BodyMetricsDao(db);

  final AppDatabase _db;
  final ProfileDao _dao;
  final BodyMetricsDao _bodyDao;
  final DateTime Function() _clock;

  @override
  Stream<UserProfile?> watch() =>
      _dao.watchSingle().map((row) => row?.toDomain());

  @override
  Future<UserProfile?> get() async => (await _dao.getSingle())?.toDomain();

  @override
  Future<UserProfile> create(
    UserProfileDraft profile,
    BodyWeightDraft initialWeight,
  ) async {
    final today = _clock();
    final profileErrors = profile.validate(today: today);
    if (profileErrors.isNotEmpty) {
      throw ProfileValidationException(profileErrors);
    }
    final weightErrors = initialWeight.validate(today: today);
    if (weightErrors.isNotEmpty) {
      throw BodyWeightValidationException(weightErrors);
    }

    return _db.transaction(() async {
      if (await _dao.getSingle() != null) {
        throw const ProfileAlreadyExistsException();
      }
      final row = await _dao.insertRow(profile.toCompanion());
      await upsertWeightForDate(_bodyDao, initialWeight);
      return row.toDomain();
    });
  }

  @override
  Future<void> update(UserProfileDraft draft) async {
    final errors = draft.validate(today: _clock());
    if (errors.isNotEmpty) throw ProfileValidationException(errors);

    final row = await _dao.getSingle();
    if (row == null) throw const ProfileNotFoundException();
    await _dao.updateById(
      row.id,
      draft.toCompanion().copyWith(updatedAt: Value(nowUtc())),
    );
  }
}
