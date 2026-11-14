import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import 'app/app.dart';
import 'features/exercises/data/exercise_data_providers.dart';
import 'features/profile/presentation/profile_providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final container = ProviderContainer();
  // Base data must exist before the first screen reads it.
  await container.read(exerciseSeederProvider).run();
  // Known before the router starts, so it opens onboarding without a flash
  // of the home screen.
  await container.read(currentProfileProvider.future);

  runApp(UncontrolledProviderScope(container: container, child: const App()));
}
