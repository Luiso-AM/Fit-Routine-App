import 'package:material_ui/material_ui.dart';

// The theme's tonal color is the warning orange, so secondary buttons and
// progress tracks of the workout use the raised surface instead.

/// Neutral filled style for secondary icon buttons.
ButtonStyle neutralIconButtonStyle(ThemeData theme) => IconButton.styleFrom(
  backgroundColor: theme.colorScheme.surfaceContainerHigh,
  foregroundColor: theme.colorScheme.onSurface,
);

/// Neutral filled style for secondary buttons.
ButtonStyle neutralButtonStyle(ThemeData theme) => FilledButton.styleFrom(
  backgroundColor: theme.colorScheme.surfaceContainerHigh,
  foregroundColor: theme.colorScheme.onSurface,
  minimumSize: const Size(0, 48),
);

/// Centered message for empty or failed states.
class WorkoutMessage extends StatelessWidget {
  const WorkoutMessage(this.text, {this.action, super.key});

  final String text;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            if (action != null) ...[const SizedBox(height: 16), action!],
          ],
        ),
      ),
    );
  }
}
