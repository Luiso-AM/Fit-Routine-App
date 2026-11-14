import 'package:app_entrenamiento/features/exercises/domain/enums/equipment.dart';
import 'package:app_entrenamiento/features/profile/domain/enums/experience_level.dart';
import 'package:app_entrenamiento/features/profile/domain/enums/training_goal.dart';
import 'package:app_entrenamiento/features/profile/domain/user_profile_draft.dart';
import 'package:flutter_test/flutter_test.dart';

final _today = DateTime(2026, 11, 14);

const _valid = UserProfileDraft(
  alias: 'Luis',
  heightCm: 175,
  experienceLevel: ExperienceLevel.intermediate,
  goal: TrainingGoal.hypertrophy,
  daysPerWeek: 4,
  sessionDurationMin: 60,
  equipment: [Equipment.barbell],
);

Set<ProfileValidationError> _errors(UserProfileDraft draft) =>
    draft.validate(today: _today);

void main() {
  test('given a complete draft without optional fields, when validated, '
      'then it has no errors', () {
    expect(_errors(_valid), isEmpty);
  });

  test('given an empty draft, when validated, '
      'then every required field is reported', () {
    expect(_errors(const UserProfileDraft()), {
      ProfileValidationError.aliasRequired,
      ProfileValidationError.heightRequired,
      ProfileValidationError.experienceLevelRequired,
      ProfileValidationError.goalRequired,
      ProfileValidationError.daysPerWeekRequired,
      ProfileValidationError.sessionDurationRequired,
      ProfileValidationError.equipmentRequired,
    });
  });

  group('alias', () {
    test('given only spaces, when validated, then it is required', () {
      expect(_errors(_valid.copyWith(alias: '   ')), {
        ProfileValidationError.aliasRequired,
      });
    });

    test('given more than the maximum length, when validated, '
        'then it is too long', () {
      expect(_errors(_valid.copyWith(alias: 'a' * (kAliasMaxLength + 1))), {
        ProfileValidationError.aliasTooLong,
      });
    });
  });

  group('birth date', () {
    test('given a date in the future, when validated, '
        'then it is out of range', () {
      expect(_errors(_valid.copyWith(birthDate: DateTime.utc(2026, 11, 15))), {
        ProfileValidationError.birthDateOutOfRange,
      });
    });

    test('given an age below the minimum, when validated, '
        'then it is out of range', () {
      expect(_errors(_valid.copyWith(birthDate: DateTime.utc(2017, 1, 1))), {
        ProfileValidationError.birthDateOutOfRange,
      });
    });

    test('given exactly the minimum and maximum ages, when validated, '
        'then they are accepted', () {
      expect(
        _errors(_valid.copyWith(birthDate: DateTime.utc(2016, 11, 14))),
        isEmpty,
      );
      expect(
        _errors(_valid.copyWith(birthDate: DateTime.utc(1926, 1, 1))),
        isEmpty,
      );
    });

    test('given an age above the maximum, when validated, '
        'then it is out of range', () {
      expect(_errors(_valid.copyWith(birthDate: DateTime.utc(1925, 1, 1))), {
        ProfileValidationError.birthDateOutOfRange,
      });
    });
  });

  group('ranges', () {
    test('given values outside their limits, when validated, '
        'then each one is reported', () {
      final draft = _valid.copyWith(
        heightCm: kMaxHeightCm + 1,
        daysPerWeek: 0,
        sessionDurationMin: kMaxSessionDurationMin + 1,
      );
      expect(_errors(draft), {
        ProfileValidationError.heightOutOfRange,
        ProfileValidationError.daysPerWeekOutOfRange,
        ProfileValidationError.sessionDurationOutOfRange,
      });
    });

    test('given values on their limits, when validated, '
        'then they are accepted', () {
      final low = _valid.copyWith(
        heightCm: kMinHeightCm,
        daysPerWeek: kMinDaysPerWeek,
        sessionDurationMin: kMinSessionDurationMin,
      );
      final high = _valid.copyWith(
        heightCm: kMaxHeightCm,
        daysPerWeek: kMaxDaysPerWeek,
        sessionDurationMin: kMaxSessionDurationMin,
      );
      expect(_errors(low), isEmpty);
      expect(_errors(high), isEmpty);
    });
  });
}
