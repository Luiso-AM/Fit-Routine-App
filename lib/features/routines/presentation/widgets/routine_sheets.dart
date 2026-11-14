import 'package:material_ui/material_ui.dart';

import '../../../../core/widgets/labeled_field.dart';
import '../../domain/routine_drafts.dart';
import '../routine_strings.dart';

/// Shared layout of the routine bottom sheets: title, fields and buttons,
/// lifted above the keyboard.
class _SheetScaffold extends StatelessWidget {
  const _SheetScaffold({
    required this.title,
    required this.children,
    required this.primaryLabel,
    required this.onPrimary,
    this.onDelete,
  });

  final String title;
  final List<Widget> children;
  final String primaryLabel;
  final VoidCallback onPrimary;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(title, style: theme.textTheme.titleLarge),
              const SizedBox(height: 16),
              ...children,
              const SizedBox(height: 24),
              Row(
                children: [
                  if (onDelete != null) ...[
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(0, 52),
                          foregroundColor: theme.colorScheme.error,
                        ),
                        onPressed: onDelete,
                        child: const Text(RoutineStrings.delete),
                      ),
                    ),
                    const SizedBox(width: 12),
                  ],
                  Expanded(
                    flex: 2,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(0, 52),
                      ),
                      onPressed: onPrimary,
                      child: Text(primaryLabel),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<T?> _showSheet<T>(BuildContext context, Widget sheet) =>
    showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => sheet,
    );

/// Name and notes of a routine. Returns the valid draft, or `null` if the
/// sheet was dismissed.
class RoutineInfoSheet extends StatefulWidget {
  const RoutineInfoSheet({
    required this.initial,
    required this.title,
    super.key,
  });

  final RoutineDraft initial;
  final String title;

  static Future<RoutineDraft?> show(
    BuildContext context, {
    required String title,
    RoutineDraft initial = const RoutineDraft(),
  }) => _showSheet(context, RoutineInfoSheet(initial: initial, title: title));

  @override
  State<RoutineInfoSheet> createState() => _RoutineInfoSheetState();
}

class _RoutineInfoSheetState extends State<RoutineInfoSheet> {
  late final _name = TextEditingController(text: widget.initial.name);
  late final _notes = TextEditingController(text: widget.initial.notes);
  Set<RoutineValidationError> _errors = {};

  @override
  void dispose() {
    _name.dispose();
    _notes.dispose();
    super.dispose();
  }

  void _submit() {
    final draft = RoutineDraft(name: _name.text, notes: _notes.text);
    final errors = draft.validate();
    if (errors.isNotEmpty) return setState(() => _errors = errors);
    Navigator.of(context).pop(draft);
  }

  @override
  Widget build(BuildContext context) {
    return _SheetScaffold(
      title: widget.title,
      primaryLabel: RoutineStrings.save,
      onPrimary: _submit,
      children: [
        TextField(
          controller: _name,
          autofocus: widget.initial.name.isEmpty,
          maxLength: kRoutineNameMaxLength,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            labelText: RoutineStrings.name,
            errorText: _errors.contains(RoutineValidationError.nameRequired)
                ? RoutineStrings.nameRequired
                : _errors.contains(RoutineValidationError.nameTooLong)
                ? RoutineStrings.nameTooLong
                : null,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _notes,
          minLines: 2,
          maxLines: 5,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            labelText: RoutineStrings.notesOptional,
            alignLabelWithHint: true,
            errorText: _errors.contains(RoutineValidationError.notesTooLong)
                ? RoutineStrings.notesTooLong
                : null,
          ),
        ),
      ],
    );
  }
}

/// What the user chose in the day sheet.
sealed class DaySheetResult {
  const DaySheetResult();
}

class DaySaved extends DaySheetResult {
  const DaySaved(this.draft);

  final RoutineDayDraft draft;
}

class DayDeleteRequested extends DaySheetResult {
  const DayDeleteRequested();
}

/// Name and weekday of a routine day. When [canDelete], it also offers to
/// delete the day.
class RoutineDaySheet extends StatefulWidget {
  const RoutineDaySheet({
    required this.initial,
    required this.title,
    required this.canDelete,
    super.key,
  });

  final RoutineDayDraft initial;
  final String title;
  final bool canDelete;

  static Future<DaySheetResult?> show(
    BuildContext context, {
    required String title,
    RoutineDayDraft initial = const RoutineDayDraft(),
    bool canDelete = false,
  }) => _showSheet(
    context,
    RoutineDaySheet(initial: initial, title: title, canDelete: canDelete),
  );

  @override
  State<RoutineDaySheet> createState() => _RoutineDaySheetState();
}

class _RoutineDaySheetState extends State<RoutineDaySheet> {
  late final _name = TextEditingController(text: widget.initial.name);
  late int? _weekday = widget.initial.weekday;
  Set<RoutineDayValidationError> _errors = {};

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  void _submit() {
    final draft = RoutineDayDraft(name: _name.text, weekday: _weekday);
    final errors = draft.validate();
    if (errors.isNotEmpty) return setState(() => _errors = errors);
    Navigator.of(context).pop(DaySaved(draft));
  }

  @override
  Widget build(BuildContext context) {
    return _SheetScaffold(
      title: widget.title,
      primaryLabel: RoutineStrings.save,
      onPrimary: _submit,
      onDelete: widget.canDelete
          ? () => Navigator.of(context).pop(const DayDeleteRequested())
          : null,
      children: [
        TextField(
          controller: _name,
          autofocus: widget.initial.name.isEmpty,
          maxLength: kRoutineDayNameMaxLength,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            labelText: RoutineStrings.dayName,
            hintText: RoutineStrings.dayNameHint,
            errorText: _errors.contains(RoutineDayValidationError.nameRequired)
                ? RoutineStrings.nameRequired
                : _errors.contains(RoutineDayValidationError.nameTooLong)
                ? RoutineStrings.dayNameTooLong
                : null,
          ),
        ),
        const SizedBox(height: 8),
        LabeledField(
          label: RoutineStrings.weekdayOptional,
          children: [
            ChoiceChip(
              label: const Text(RoutineStrings.noWeekday),
              selected: _weekday == null,
              onSelected: (_) => setState(() => _weekday = null),
            ),
            for (var day = DateTime.monday; day <= DateTime.sunday; day++)
              ChoiceChip(
                label: Text(RoutineStrings.weekdayInitials[day - 1]),
                tooltip: RoutineStrings.weekdays[day - 1],
                selected: _weekday == day,
                onSelected: (_) => setState(() => _weekday = day),
              ),
          ],
        ),
      ],
    );
  }
}
