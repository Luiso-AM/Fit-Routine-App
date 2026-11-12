import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/routing/app_routes.dart';
import '../../../core/strings/app_strings.dart';

class RoutinesScreen extends StatelessWidget {
  const RoutinesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.tabRoutines),
        actions: [
          TextButton.icon(
            onPressed: () => context.go(AppRoutes.exercises),
            icon: const Icon(Icons.fitness_center),
            label: const Text(AppStrings.exerciseLibrary),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}
