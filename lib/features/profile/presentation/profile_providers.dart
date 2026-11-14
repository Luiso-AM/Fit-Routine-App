import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/profile_data_providers.dart';
import '../domain/user_profile.dart';

part 'profile_providers.g.dart';

/// The user's profile, `null` before onboarding. Kept alive because the
/// router depends on it.
@Riverpod(keepAlive: true)
Stream<UserProfile?> currentProfile(Ref ref) =>
    ref.watch(profileRepositoryProvider).watch();
