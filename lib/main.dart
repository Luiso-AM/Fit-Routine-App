import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import 'app/app.dart';
import 'features/exercises/data/exercise_data_providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final container = ProviderContainer();
  // Base data must exist before the first screen reads it.
  await container.read(exerciseSeederProvider).run();

  runApp(UncontrolledProviderScope(container: container, child: const App()));
}
