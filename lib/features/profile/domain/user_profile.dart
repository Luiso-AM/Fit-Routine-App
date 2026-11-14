import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/utils/calendar_date.dart';
import '../../exercises/domain/enums/equipment.dart';
import 'enums/experience_level.dart';
import 'enums/sex.dart';
import 'enums/training_goal.dart';

part 'user_profile.freezed.dart';

/// The local user's profile. The app holds a single one.
@freezed
abstract class UserProfile with _$UserProfile {
  const factory UserProfile({
    required String id,
    required String alias,

    /// Calendar date (UTC midnight). `null` when not given.
    DateTime? birthDate,

    /// `null` means "prefer not to say".
    Sex? sex,
    required double heightCm,
    required ExperienceLevel experienceLevel,
    required TrainingGoal goal,
    required int daysPerWeek,
    required int sessionDurationMin,
    @Default(<Equipment>[]) List<Equipment> equipment,
  }) = _UserProfile;

  const UserProfile._();

  /// Age in whole years on [today], or `null` without a birth date.
  int? ageOn(DateTime today) {
    final birth = birthDate;
    return birth == null ? null : yearsBetween(birth, calendarDate(today));
  }
}
