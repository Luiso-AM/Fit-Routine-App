import 'package:material_ui/material_ui.dart';

import '../utils/calendar_date.dart';

/// A read-only field that opens a date picker. Values are calendar dates
/// (UTC midnight, see `calendarDate`).
class DateField extends StatelessWidget {
  const DateField({
    required this.label,
    required this.value,
    required this.onChanged,
    required this.firstDate,
    required this.lastDate,
    this.initialPickerDate,
    this.yearFirst = false,
    this.clearTooltip,
    this.helperText,
    this.errorText,
    super.key,
  });

  final String label;
  final DateTime? value;
  final ValueChanged<DateTime?> onChanged;
  final DateTime firstDate;
  final DateTime lastDate;

  /// Date shown when the picker opens and there is no [value] yet.
  final DateTime? initialPickerDate;

  /// Opens the picker on the year grid, handy for birth dates.
  final bool yearFirst;

  /// When set, a clear button is shown while there is a value.
  final String? clearTooltip;
  final String? helperText;
  final String? errorText;

  static DateTime _local(DateTime date) =>
      DateTime(date.year, date.month, date.day);

  Future<void> _pick(BuildContext context) async {
    final first = _local(firstDate);
    final last = _local(lastDate);
    var initial = _local(value ?? initialPickerDate ?? lastDate);
    if (initial.isBefore(first)) initial = first;
    if (initial.isAfter(last)) initial = last;

    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: first,
      lastDate: last,
      initialDatePickerMode: yearFirst
          ? DatePickerMode.year
          : DatePickerMode.day,
    );
    if (picked != null) onChanged(calendarDate(picked));
  }

  @override
  Widget build(BuildContext context) {
    final date = value;
    final text = date == null
        ? ''
        : MaterialLocalizations.of(context).formatMediumDate(date);

    return InkWell(
      onTap: () => _pick(context),
      borderRadius: BorderRadius.circular(4),
      child: InputDecorator(
        isEmpty: date == null,
        decoration: InputDecoration(
          labelText: label,
          helperText: helperText,
          errorText: errorText,
          suffixIcon: date != null && clearTooltip != null
              ? IconButton(
                  tooltip: clearTooltip,
                  icon: const Icon(Icons.close),
                  onPressed: () => onChanged(null),
                )
              : const Icon(Icons.calendar_today_outlined),
        ),
        child: Text(text),
      ),
    );
  }
}
