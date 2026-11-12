import 'package:material_ui/material_ui.dart';

import '../../../../core/strings/enum_labels.dart';
import '../../../../core/widgets/exercise_image.dart';
import '../../domain/exercise.dart';
import '../exercise_strings.dart';

class ExerciseTile extends StatelessWidget {
  const ExerciseTile({required this.exercise, required this.onTap, super.key});

  final Exercise exercise;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      onTap: onTap,
      minTileHeight: 64,
      leading: ExerciseImage(
        imagePath: exercise.imagePath,
        width: 48,
        height: 48,
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text(exercise.name),
      subtitle: Text(
        '${exercise.equipment.label} · ${exercise.type.label}',
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
      trailing: exercise.isCustom
          ? Text(
              ExerciseStrings.custom,
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.primary,
              ),
            )
          : null,
    );
  }
}
