import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/utils/calendar_date.dart';
import '../../exercises/domain/enums/equipment.dart';
import 'enums/experience_level.dart';
import 'enums/sex.dart';
import 'enums/training_goal.dart';
import 'user_profile.dart';

part 'user_profile_draft.freezed.dart';

const int kAliasMaxLength = 30;
const double kMinHeightCm = 100;
const double kMaxHeightCm = 250;
const int kMinDaysPerWeek = 1;
const int kMaxDaysPerWeek = 7;
const int kMinSessionDurationMin = 10;
const int kMaxSessionDurationMin = 300;
const int kMinAge = 10;
const int kMaxAge = 100;

enum ProfileValidationError {
  aliasRequired,
  aliasTooLong,
  birthDateOutOfRange,
  heightRequired,
  heightOutOfRange,
  experienceLevelRequired,
  goalRequired,
  daysPerWeekRequired,
  daysPerWeekOutOfRange,
  sessionDurationRequired,
  sessionDurationOutOfRange,
  equipmentRequired,
}

/// Editable profile data, as entered in onboarding or in the edit form.
@freezed
abstract class UserProfileDraft with _$UserProfileDraft {
  const factory UserProfileDraft({
    @Default('') String alias,

    /// Optional calendar date (UTC midnight).
    DateTime? birthDate,
    Sex? sex,
    double? heightCm,
    ExperienceLevel? experienceLevel,
    TrainingGoal? goal,
    int? daysPerWeek,
    int? sessionDurationMin,
    @Default(<Equipment>[]) List<Equipment> equipment,
  }) = _UserProfileDraft;

  const UserProfileDraft._();

  factory UserProfileDraft.fromProfile(UserProfile profile) => UserProfileDraft(
    alias: profile.alias,
    birthDate: profile.birthDate,
    sex: profile.sex,
    heightCm: profile.heightCm,
    experienceLevel: profile.experienceLevel,
    goal: profile.goal,
    daysPerWeek: profile.daysPerWeek,
    sessionDurationMin: profile.sessionDurationMin,
    equipment: profile.equipment,
  );

  /// Checks the draft against the business rules. [today] bounds the age.
  Set<ProfileValidationError> validate({required DateTime today}) {
    final errors = <ProfileValidationError>{};

    final trimmed = alias.trim();
    if (trimmed.isEmpty) {
      errors.add(ProfileValidationError.aliasRequired);
    } else if (trimmed.length > kAliasMaxLength) {
      errors.add(ProfileValidationError.aliasTooLong);
    }

    final birth = birthDate;
    if (birth != null) {
      final day = calendarDate(today);
      final age = yearsBetween(birth, day);
      if (calendarDate(birth).isAfter(day) || age < kMinAge || age > kMaxAge) {
        errors.add(ProfileValidationError.birthDateOutOfRange);
      }
    }

    final height = heightCm;
    if (height == null) {
      errors.add(ProfileValidationError.heightRequired);
    } else if (height < kMinHeightCm || height > kMaxHeightCm) {
      errors.add(ProfileValidationError.heightOutOfRange);
    }

    if (experienceLevel == null) {
      errors.add(ProfileValidationError.experienceLevelRequired);
    }
    if (goal == null) {
      errors.add(ProfileValidationError.goalRequired);
    }

    final days = daysPerWeek;
    if (days == null) {
      errors.add(ProfileValidationError.daysPerWeekRequired);
    } else if (days < kMinDaysPerWeek || days > kMaxDaysPerWeek) {
      errors.add(ProfileValidationError.daysPerWeekOutOfRange);
    }

    final duration = sessionDurationMin;
    if (duration == null) {
      errors.add(ProfileValidationError.sessionDurationRequired);
    } else if (duration < kMinSessionDurationMin ||
        duration > kMaxSessionDurationMin) {
      errors.add(ProfileValidationError.sessionDurationOutOfRange);
    }

    if (equipment.isEmpty) {
      errors.add(ProfileValidationError.equipmentRequired);
    }
    return errors;
  }
}
