import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../../../core/utils/calendar_date.dart';
import '../domain/user_profile.dart';
import '../domain/user_profile_draft.dart';

extension UserProfileRowMapper on UserProfileRow {
  UserProfile toDomain() => UserProfile(
    id: id,
    alias: alias,
    birthDate: birthDate == null ? null : calendarDate(birthDate!.toUtc()),
    sex: sex,
    heightCm: heightCm,
    experienceLevel: experienceLevel,
    goal: goal,
    daysPerWeek: daysPerWeek,
    sessionDurationMin: sessionDurationMin,
    equipment: equipment,
  );
}

extension UserProfileDraftMapper on UserProfileDraft {
  /// Every column of a validated draft. Required fields must be set.
  UserProfileCompanion toCompanion() => UserProfileCompanion(
    alias: Value(alias.trim()),
    birthDate: Value(birthDate == null ? null : calendarDate(birthDate!)),
    sex: Value(sex),
    heightCm: Value(heightCm!),
    experienceLevel: Value(experienceLevel!),
    goal: Value(goal!),
    daysPerWeek: Value(daysPerWeek!),
    sessionDurationMin: Value(sessionDurationMin!),
    // Stored without duplicates and in declaration order.
    equipment: Value(
      equipment.toSet().toList()..sort((a, b) => a.index.compareTo(b.index)),
    ),
  );
}
