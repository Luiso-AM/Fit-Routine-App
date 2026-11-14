import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/exercises/data/exercise_data_providers.dart';
import '../features/profile/presentation/profile_providers.dart';

/// Prepares the app before the first frame.
Future<void> bootstrap(ProviderContainer container) async {
  // Base data must exist before the first screen reads it.
  await container.read(exerciseSeederProvider).run();

  // Load the profile before the router starts, so it opens onboarding
  // without a flash of the home screen. Riverpod pauses providers nobody
  // listens to, and `read` does not listen: awaiting `read(...future)` would
  // never complete. Listen while waiting instead.
  final profile = container.listen(currentProfileProvider.future, (_, _) {});
  try {
    await profile.read();
  } finally {
    profile.close();
  }
}
