import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../core/routing/app_routes.dart';
import '../../../core/strings/app_strings.dart';
import '../../../core/utils/calendar_date.dart';
import '../../../core/utils/duration_format.dart';
import '../../workout/domain/session_summary.dart';
import '../../workout/domain/workout_session.dart';
import 'history_providers.dart';
import 'history_strings.dart';

/// Calendar of the days trained. Selecting a day lists its sessions, and
/// each one opens its detail.
class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  static final DateTime _firstDay = DateTime.utc(2020);

  /// Today, as a calendar date.
  final DateTime _today = calendarDate(DateTime.now());

  /// A day of the month on screen.
  late DateTime _focusedDay = _today;
  late DateTime _selectedDay = _today;

  /// First local instant of the month on screen, the key of its sessions.
  DateTime get _month => DateTime(_focusedDay.year, _focusedDay.month);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final muted = theme.textTheme.bodyMedium?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );
    final month = ref.watch(historyMonthProvider(_month));
    final byDay = month.value ?? const <DateTime, List<WorkoutSession>>{};
    final daySessions = byDay[_selectedDay] ?? const [];
    final monthTotal = byDay.values.fold(0, (n, day) => n + day.length);

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.tabProgress)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 0, 4, 8),
            child: Text(
              HistoryStrings.title,
              style: theme.textTheme.titleMedium,
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 4, 8, 12),
              child: _TrainingCalendar(
                firstDay: _firstDay,
                lastDay: _today,
                focusedDay: _focusedDay,
                selectedDay: _selectedDay,
                trainedDays: byDay,
                onDaySelected: (day) => setState(() {
                  _selectedDay = calendarDate(day);
                  _focusedDay = _selectedDay;
                }),
                onPageChanged: (focused) => setState(() {
                  _focusedDay = calendarDate(focused);
                }),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 4, 4, 16),
            child: Text(
              month.hasError
                  ? HistoryStrings.loadError
                  : HistoryStrings.monthCount(monthTotal),
              style: muted,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 0, 4, 8),
            child: Text(
              MaterialLocalizations.of(context).formatFullDate(_selectedDay),
              style: theme.textTheme.titleSmall?.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
          ),
          if (month.hasValue && daySessions.isEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 8, 4, 0),
              child: Text(HistoryStrings.noSessionsOnDay, style: muted),
            ),
          for (final session in daySessions)
            _SessionTile(key: ValueKey(session.id), session: session),
        ],
      ),
    );
  }
}

class _TrainingCalendar extends StatelessWidget {
  const _TrainingCalendar({
    required this.firstDay,
    required this.lastDay,
    required this.focusedDay,
    required this.selectedDay,
    required this.trainedDays,
    required this.onDaySelected,
    required this.onPageChanged,
  });

  final DateTime firstDay;
  final DateTime lastDay;
  final DateTime focusedDay;
  final DateTime selectedDay;
  final Map<DateTime, List<WorkoutSession>> trainedDays;
  final ValueChanged<DateTime> onDaySelected;
  final ValueChanged<DateTime> onPageChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final localizations = MaterialLocalizations.of(context);
    final text = theme.textTheme.bodyMedium!;

    final month = DateTime.utc(focusedDay.year, focusedDay.month);
    final previous = DateTime.utc(month.year, month.month - 1);
    final next = DateTime.utc(month.year, month.month + 1);
    final canGoBack = !previous.isBefore(
      DateTime.utc(firstDay.year, firstDay.month),
    );
    final canGoForward = !next.isAfter(lastDay);

    return Column(
      children: [
        // table_calendar's own header buttons need Flutter's deprecated
        // Material, so the header is built here.
        Row(
          children: [
            IconButton(
              tooltip: HistoryStrings.previousMonth,
              onPressed: canGoBack ? () => onPageChanged(previous) : null,
              icon: const Icon(Icons.chevron_left),
            ),
            Expanded(
              child: Text(
                localizations.formatMonthYear(month),
                textAlign: TextAlign.center,
                style: theme.textTheme.titleMedium,
              ),
            ),
            IconButton(
              tooltip: HistoryStrings.nextMonth,
              onPressed: canGoForward ? () => onPageChanged(next) : null,
              icon: const Icon(Icons.chevron_right),
            ),
          ],
        ),
        TableCalendar<WorkoutSession>(
          locale: Localizations.localeOf(context).toString(),
          firstDay: firstDay,
          lastDay: lastDay,
          focusedDay: focusedDay,
          currentDay: lastDay,
          headerVisible: false,
          startingDayOfWeek: StartingDayOfWeek.monday,
          availableCalendarFormats: const {CalendarFormat.month: ''},
          availableGestures: AvailableGestures.horizontalSwipe,
          rowHeight: 48,
          daysOfWeekHeight: 24,
          eventLoader: (day) => trainedDays[calendarDate(day)] ?? const [],
          selectedDayPredicate: (day) => isSameDay(day, selectedDay),
          onDaySelected: (selected, _) => onDaySelected(selected),
          onPageChanged: onPageChanged,
          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: theme.textTheme.bodySmall!.copyWith(
              color: scheme.onSurfaceVariant,
            ),
            weekendStyle: theme.textTheme.bodySmall!.copyWith(
              color: scheme.onSurfaceVariant,
            ),
          ),
          calendarStyle: CalendarStyle(
            outsideDaysVisible: false,
            markersMaxCount: 1,
            markerSize: 6,
            markerDecoration: BoxDecoration(
              color: scheme.primary,
              shape: BoxShape.circle,
            ),
            defaultTextStyle: text,
            weekendTextStyle: text,
            disabledTextStyle: text.copyWith(color: scheme.outline),
            todayTextStyle: text.copyWith(color: scheme.primary),
            todayDecoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: scheme.primary),
            ),
            selectedTextStyle: text.copyWith(color: scheme.onPrimary),
            selectedDecoration: BoxDecoration(
              color: scheme.primary,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }
}

/// A session of the selected day: what it was, when, and how much it
/// took.
class _SessionTile extends StatelessWidget {
  const _SessionTile({required this.session, super.key});

  final WorkoutSession session;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final totals = SessionTotals.of(session);
    final time = MaterialLocalizations.of(context)
        .formatTimeOfDay(TimeOfDay.fromDateTime(session.startedAt.toLocal()));
    final subtitle = [
      ?session.routineName,
      time,
      HistoryStrings.exercises(totals.exercises),
      HistoryStrings.sets(totals.sets),
    ].join(' · ');

    return Card(
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        minTileHeight: 64,
        onTap: () => context.push(AppRoutes.historySession(session.id)),
        title: Text(session.routineDayName ?? HistoryStrings.freeSession),
        subtitle: Text(subtitle),
        trailing: Text(
          formatClock(totals.duration),
          style: theme.textTheme.titleSmall,
        ),
      ),
    );
  }
}
