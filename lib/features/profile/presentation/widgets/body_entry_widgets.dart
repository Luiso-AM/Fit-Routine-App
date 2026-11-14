import 'package:material_ui/material_ui.dart';

import '../../../../core/utils/decimal_input.dart';
import '../../domain/body_measurement.dart';
import '../profile_strings.dart';

/// Asks before deleting a body weight or measurement entry.
Future<bool> confirmDeleteEntry(BuildContext context) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text(ProfileStrings.deleteEntryTitle),
      content: const Text(ProfileStrings.deleteEntryMessage),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text(ProfileStrings.cancel),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text(ProfileStrings.delete),
        ),
      ],
    ),
  );
  return confirmed ?? false;
}

/// Formats a calendar date for display, e.g. "14 nov 2026".
String formatEntryDate(BuildContext context, DateTime date) =>
    MaterialLocalizations.of(context).formatMediumDate(date);

/// The values present in [m], as (label, formatted value) pairs.
List<(String, String)> measurementValues(BodyMeasurement m) {
  String cm(double v) => '${formatDecimalInput(v)} ${ProfileStrings.cm}';
  return [
    if (m.waistCm case final v?) (ProfileStrings.waist, cm(v)),
    if (m.chestCm case final v?) (ProfileStrings.chest, cm(v)),
    if (m.armCm case final v?) (ProfileStrings.arm, cm(v)),
    if (m.legCm case final v?) (ProfileStrings.leg, cm(v)),
    if (m.hipCm case final v?) (ProfileStrings.hip, cm(v)),
    if (m.bodyFatPct case final v?)
      (
        ProfileStrings.bodyFat,
        '${formatDecimalInput(v)} ${ProfileStrings.percent}',
      ),
  ];
}

/// Centered message for an empty or failed list.
class EmptyMessage extends StatelessWidget {
  const EmptyMessage(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}
