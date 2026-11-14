import 'package:app_entrenamiento/features/profile/domain/enums/experience_level.dart';
import 'package:app_entrenamiento/features/profile/domain/enums/training_goal.dart';
import 'package:app_entrenamiento/features/profile/domain/user_profile.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const profile = UserProfile(
    id: 'p',
    alias: 'Luis',
    heightCm: 175,
    experienceLevel: ExperienceLevel.intermediate,
    goal: TrainingGoal.hypertrophy,
    daysPerWeek: 4,
    sessionDurationMin: 60,
  );

  test('given no birth date, when asking the age, then it is null', () {
    expect(profile.ageOn(DateTime(2026, 11, 14)), isNull);
  });

  test('given a birth date, when asking the age the day before the birthday, '
      'then the year is not counted yet', () {
    final withBirth = profile.copyWith(birthDate: DateTime.utc(1995, 11, 15));
    expect(withBirth.ageOn(DateTime(2026, 11, 14, 23)), 30);
    expect(withBirth.ageOn(DateTime(2026, 11, 15, 0, 1)), 31);
  });
}
