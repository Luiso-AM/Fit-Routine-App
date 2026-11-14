import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/tables/user_profile_table.dart';

part 'profile_dao.g.dart';

@DriftAccessor(tables: [UserProfile])
class ProfileDao extends DatabaseAccessor<AppDatabase> with _$ProfileDaoMixin {
  ProfileDao(super.attachedDatabase);

  // The table holds a single row; limit(1) guards against a stray second one.
  SimpleSelectStatement<$UserProfileTable, UserProfileRow> _single() =>
      select(userProfile)
        ..orderBy([(p) => OrderingTerm.asc(p.createdAt)])
        ..limit(1);

  Stream<UserProfileRow?> watchSingle() => _single().watchSingleOrNull();

  Future<UserProfileRow?> getSingle() => _single().getSingleOrNull();

  Future<UserProfileRow> insertRow(UserProfileCompanion row) =>
      into(userProfile).insertReturning(row);

  Future<void> updateById(String id, UserProfileCompanion changes) =>
      (update(userProfile)..where((p) => p.id.equals(id))).write(changes);
}
