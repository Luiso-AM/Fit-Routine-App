import 'body_weight_draft.dart';
import 'user_profile.dart';
import 'user_profile_draft.dart';

abstract interface class ProfileRepository {
  /// The profile, or `null` before onboarding. Re-emitted on every change.
  Stream<UserProfile?> watch();

  Future<UserProfile?> get();

  /// Creates the profile and its first body weight entry in one transaction.
  ///
  /// Throws [ProfileAlreadyExistsException], [ProfileValidationException] or
  /// `BodyWeightValidationException`.
  Future<UserProfile> create(
    UserProfileDraft profile,
    BodyWeightDraft initialWeight,
  );

  /// Throws [ProfileNotFoundException] or [ProfileValidationException].
  Future<void> update(UserProfileDraft draft);
}

class ProfileAlreadyExistsException implements Exception {
  const ProfileAlreadyExistsException();

  @override
  String toString() => 'ProfileAlreadyExistsException';
}

class ProfileNotFoundException implements Exception {
  const ProfileNotFoundException();

  @override
  String toString() => 'ProfileNotFoundException';
}

class ProfileValidationException implements Exception {
  const ProfileValidationException(this.errors);

  final Set<ProfileValidationError> errors;

  @override
  String toString() => 'ProfileValidationException: $errors';
}
