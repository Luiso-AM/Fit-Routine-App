import 'package:app_entrenamiento/features/exercises/domain/enums/equipment.dart';
import 'package:app_entrenamiento/features/profile/domain/body_metrics_repository.dart';
import 'package:app_entrenamiento/features/profile/domain/body_weight_draft.dart';
import 'package:app_entrenamiento/features/profile/domain/enums/experience_level.dart';
import 'package:app_entrenamiento/features/profile/domain/enums/training_goal.dart';
import 'package:app_entrenamiento/features/profile/domain/profile_repository.dart';
import 'package:app_entrenamiento/features/profile/domain/user_profile.dart';
import 'package:app_entrenamiento/features/profile/domain/user_profile_draft.dart';

import 'fake_body_metrics_repository.dart';
import 'watchable.dart';

/// A complete profile, so that screens behind onboarding are reachable.
const testProfile = UserProfile(
  id: 'profile',
  alias: 'Alex',
  heightCm: 175,
  experienceLevel: ExperienceLevel.intermediate,
  goal: TrainingGoal.hypertrophy,
  daysPerWeek: 4,
  sessionDurationMin: 60,
  equipment: [Equipment.barbell, Equipment.dumbbell],
);

/// In-memory [ProfileRepository] for widget tests. The initial weight of
/// [create] is logged in [bodyMetrics].
class FakeProfileRepository with Watchable implements ProfileRepository {
  FakeProfileRepository({this._profile, required this.bodyMetrics});

  final FakeBodyMetricsRepository bodyMetrics;
  UserProfile? _profile;

  UserProfile? get profile => _profile;

  @override
  Stream<UserProfile?> watch() => watchValue(() => _profile);

  @override
  Future<UserProfile?> get() async => _profile;

  @override
  Future<UserProfile> create(
    UserProfileDraft profile,
    BodyWeightDraft initialWeight,
  ) async {
    if (_profile != null) throw const ProfileAlreadyExistsException();
    _validate(profile);
    final weightErrors = initialWeight.validate(today: DateTime.now());
    if (weightErrors.isNotEmpty) {
      throw BodyWeightValidationException(weightErrors);
    }
    await bodyMetrics.logWeight(initialWeight);
    final created = _fromDraft('profile', profile);
    _profile = created;
    notifyChanged();
    return created;
  }

  @override
  Future<void> update(UserProfileDraft draft) async {
    final current = _profile;
    if (current == null) throw const ProfileNotFoundException();
    _validate(draft);
    _profile = _fromDraft(current.id, draft);
    notifyChanged();
  }

  void _validate(UserProfileDraft draft) {
    final errors = draft.validate(today: DateTime.now());
    if (errors.isNotEmpty) throw ProfileValidationException(errors);
  }

  UserProfile _fromDraft(String id, UserProfileDraft draft) => UserProfile(
    id: id,
    alias: draft.alias.trim(),
    birthDate: draft.birthDate,
    sex: draft.sex,
    heightCm: draft.heightCm!,
    experienceLevel: draft.experienceLevel!,
    goal: draft.goal!,
    daysPerWeek: draft.daysPerWeek!,
    sessionDurationMin: draft.sessionDurationMin!,
    equipment: draft.equipment,
  );
}
