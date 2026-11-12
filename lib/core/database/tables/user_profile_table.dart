// Drift check() constraints reference their own column getter by design.
// ignore_for_file: recursive_getters

import 'package:drift/drift.dart';

import '../../../features/exercises/domain/enums/equipment.dart';
import '../../../features/profile/domain/enums/experience_level.dart';
import '../../../features/profile/domain/enums/sex.dart';
import '../../../features/profile/domain/enums/training_goal.dart';
import '../converters/enum_list_converter.dart';
import 'table_mixins.dart';

/// The local user's profile. The app holds a single row.
@DataClassName('UserProfileRow')
class UserProfile extends Table with EntityColumns {
  @override
  String get tableName => 'user_profile';

  TextColumn get alias => text()();

  /// Age is derived from this date.
  DateTimeColumn get birthDate => dateTime().nullable()();

  TextColumn get sex => textEnum<Sex>().nullable()();

  RealColumn get heightCm => real()();

  TextColumn get experienceLevel => textEnum<ExperienceLevel>()();

  TextColumn get goal => textEnum<TrainingGoal>()();

  IntColumn get daysPerWeek =>
      integer().check(daysPerWeek.isBetweenValues(1, 7))();

  IntColumn get sessionDurationMin =>
      integer().check(sessionDurationMin.isBiggerThanValue(0))();

  TextColumn get equipment => text()
      .map(const EnumListConverter(Equipment.values))
      .withDefault(const Constant('[]'))();
}
