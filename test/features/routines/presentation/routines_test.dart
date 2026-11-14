import 'package:app_entrenamiento/core/routing/app_routes.dart';
import 'package:app_entrenamiento/features/exercises/data/seed/seed_exercises.dart';
import 'package:app_entrenamiento/features/exercises/domain/enums/muscle_group.dart';
import 'package:app_entrenamiento/features/routines/domain/enums/routine_template_type.dart';
import 'package:app_entrenamiento/features/routines/domain/routine.dart';
import 'package:app_entrenamiento/features/routines/presentation/routine_strings.dart';
import 'package:app_entrenamiento/features/routines/presentation/screens/routine_detail_screen.dart';
import 'package:app_entrenamiento/features/routines/presentation/screens/routines_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../../helpers/pump_app.dart';

final _bench = seedExercises.firstWhere(
  (e) => e.primaryMuscle == MuscleGroup.chest,
);
final _row = seedExercises.firstWhere(
  (e) => e.primaryMuscle == MuscleGroup.back,
);

RoutineExercise _planned(String dayId, String exerciseId, int position) =>
    RoutineExercise(
      id: '$dayId-$position',
      routineDayId: dayId,
      exerciseId: exerciseId,
      position: position,
      targetSets: 3,
      targetRepsMin: 10,
      targetRepsMax: 12,
      restSeconds: 120,
    );

final _routine = Routine(
  id: 'r1',
  name: 'Mi rutina',
  notes: 'Calentar antes',
  days: [
    RoutineDay(
      id: 'd1',
      routineId: 'r1',
      name: 'Push',
      position: 0,
      weekday: DateTime.monday,
      exercises: [_planned('d1', _bench.id, 0)],
    ),
    RoutineDay(
      id: 'd2',
      routineId: 'r1',
      name: 'Pull',
      position: 1,
      exercises: [_planned('d2', _row.id, 0)],
    ),
  ],
);

Finder _field(String label) => find.widgetWithText(TextField, label);

Future<void> _tap(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

/// Opens the edit sheet of the day named [name].
Future<void> _editDay(WidgetTester tester, String name) => _tap(
  tester,
  find.descendant(
    of: find.ancestor(of: find.text(name), matching: find.byType(Card)),
    matching: find.byTooltip(RoutineStrings.dayActions),
  ),
);

Future<void> _confirm(WidgetTester tester) =>
    _tap(tester, find.widgetWithText(TextButton, RoutineStrings.delete));

void main() {
  group('routine list', () {
    testWidgets('given no routines, when the tab opens, '
        'then the empty message is shown', (tester) async {
      await pumpApp(tester, location: AppRoutes.routines);

      expect(find.text(RoutineStrings.noRoutines), findsOneWidget);
    });

    testWidgets('given a routine, when the tab opens, '
        'then its summary is shown', (tester) async {
      await pumpApp(tester, location: AppRoutes.routines, routines: [_routine]);

      expect(find.text('Mi rutina'), findsOneWidget);
      expect(find.text('2 días · 2 ejercicios'), findsOneWidget);
    });

    testWidgets('given the new routine sheet, when a blank routine is named, '
        'then its detail opens empty', (tester) async {
      final app = await pumpApp(tester, location: AppRoutes.routines);

      await _tap(tester, find.text(RoutineStrings.newRoutine));
      await _tap(tester, find.text(RoutineStrings.blankRoutine));
      await tester.enterText(_field(RoutineStrings.name), 'Fuerza');
      await _tap(tester, find.text(RoutineStrings.save));

      expect(find.byType(RoutineDetailScreen), findsOneWidget);
      expect(find.text('Fuerza'), findsOneWidget);
      expect(find.text(RoutineStrings.noDays), findsOneWidget);
      expect(app.routines.routines.single.templateType, isNull);
    });

    testWidgets('given the new routine sheet, when a blank routine has no '
        'name, then an error is shown', (tester) async {
      final app = await pumpApp(tester, location: AppRoutes.routines);

      await _tap(tester, find.text(RoutineStrings.newRoutine));
      await _tap(tester, find.text(RoutineStrings.blankRoutine));
      await _tap(tester, find.text(RoutineStrings.save));

      expect(find.text(RoutineStrings.nameRequired), findsOneWidget);
      expect(app.routines.routines, isEmpty);
    });

    testWidgets('given the templates, when Push / Pull / Legs is chosen, '
        'then a routine with its three days opens', (tester) async {
      final app = await pumpApp(
        tester,
        location: AppRoutes.routines,
        exercises: seedExercises,
      );

      await _tap(tester, find.text(RoutineStrings.newRoutine));
      await _tap(tester, find.text('Push / Pull / Legs'));

      expect(find.byType(RoutineDetailScreen), findsOneWidget);
      for (final day in ['Push', 'Pull', 'Legs']) {
        expect(find.text(day), findsOneWidget);
      }
      expect(find.text('6 ejercicios'), findsNWidgets(3));
      expect(
        app.routines.routines.single.templateType,
        RoutineTemplateType.pushPullLegs,
      );
    });
  });

  group('routine detail', () {
    testWidgets('given a routine, when its detail opens, then notes, days, '
        'weekdays and muscles are shown', (tester) async {
      await pumpApp(
        tester,
        location: AppRoutes.routineDetail(_routine.id),
        routines: [_routine],
        exercises: [_bench, _row],
      );

      expect(find.text('Calentar antes'), findsOneWidget);
      expect(find.text('Lunes · 1 ejercicio'), findsOneWidget);
      expect(find.text('1 ejercicio'), findsOneWidget);
      expect(find.text('Pecho'), findsOneWidget);
      expect(find.text('Espalda'), findsOneWidget);
    });

    testWidgets('given a routine, when a scheduled day is added, '
        'then it appears last with its weekday', (tester) async {
      final app = await pumpApp(
        tester,
        location: AppRoutes.routineDetail(_routine.id),
        routines: [_routine],
      );

      await _tap(tester, find.text(RoutineStrings.addDay));
      await tester.enterText(_field(RoutineStrings.dayName), 'Legs');
      await _tap(tester, find.widgetWithText(ChoiceChip, 'V'));
      await _tap(tester, find.text(RoutineStrings.save));

      expect(find.text('Viernes · 0 ejercicios'), findsOneWidget);
      final days = app.routines.routines.single.days;
      expect(days.last.name, 'Legs');
      expect(days.last.weekday, DateTime.friday);
    });

    testWidgets('given a day, when renamed and unscheduled, '
        'then the card shows the change', (tester) async {
      await pumpApp(
        tester,
        location: AppRoutes.routineDetail(_routine.id),
        routines: [_routine],
      );

      await _editDay(tester, 'Push');
      await tester.enterText(_field(RoutineStrings.dayName), 'Empuje');
      await _tap(tester, find.text(RoutineStrings.noWeekday));
      await _tap(tester, find.text(RoutineStrings.save));

      expect(find.text('Empuje'), findsOneWidget);
      expect(find.textContaining('Lunes'), findsNothing);
    });

    testWidgets('given a day, when deleted and confirmed, then it is gone', (
      tester,
    ) async {
      final app = await pumpApp(
        tester,
        location: AppRoutes.routineDetail(_routine.id),
        routines: [_routine],
      );

      await _editDay(tester, 'Push');
      await _tap(
        tester,
        find.widgetWithText(OutlinedButton, RoutineStrings.delete),
      );
      expect(find.text(RoutineStrings.deleteDayTitle), findsOneWidget);
      await _confirm(tester);

      expect(find.text('Push'), findsNothing);
      expect(app.routines.routines.single.days.single.name, 'Pull');
    });

    testWidgets('given two days, when the first is dragged below the second, '
        'then the order is saved', (tester) async {
      final app = await pumpApp(
        tester,
        location: AppRoutes.routineDetail(_routine.id),
        routines: [_routine],
      );

      final handle = find.byIcon(Icons.drag_indicator).first;
      final gesture = await tester.startGesture(tester.getCenter(handle));
      // The handle starts the drag right away, without a long press.
      await tester.pump(const Duration(milliseconds: 50));
      for (var i = 0; i < 10; i++) {
        await gesture.moveBy(const Offset(0, 20));
        await tester.pump(const Duration(milliseconds: 16));
      }
      await gesture.up();
      await tester.pumpAndSettle();

      expect(
        [for (final d in app.routines.routines.single.days) d.name],
        ['Pull', 'Push'],
      );
      final pull = tester.getTopLeft(find.text('Pull'));
      final push = tester.getTopLeft(find.text('Push'));
      expect(pull.dy, lessThan(push.dy));
    });

    testWidgets('given a routine, when its name and notes are edited, '
        'then the detail shows them', (tester) async {
      await pumpApp(
        tester,
        location: AppRoutes.routineDetail(_routine.id),
        routines: [_routine],
      );

      await _tap(tester, find.byTooltip(RoutineStrings.editRoutine));
      await tester.enterText(_field(RoutineStrings.name), 'Hipertrofia');
      await tester.enterText(_field(RoutineStrings.notesOptional), '');
      await _tap(tester, find.text(RoutineStrings.save));

      expect(find.text('Hipertrofia'), findsOneWidget);
      expect(find.text('Calentar antes'), findsNothing);
    });

    testWidgets('given a routine, when duplicated, '
        'then the copy opens with the same days', (tester) async {
      final app = await pumpApp(
        tester,
        location: AppRoutes.routineDetail(_routine.id),
        routines: [_routine],
      );

      await _tap(tester, find.byTooltip(RoutineStrings.more));
      await _tap(tester, find.text(RoutineStrings.duplicate));

      expect(find.text('Mi rutina (copia)'), findsOneWidget);
      expect(find.text(RoutineStrings.duplicated), findsOneWidget);
      final [original, copy] = app.routines.routines;
      expect(copy.id, isNot(original.id));
      expect([for (final d in copy.days) d.name], ['Push', 'Pull']);
    });

    testWidgets('given a routine, when deleted and confirmed, '
        'then the list no longer shows it', (tester) async {
      final app = await pumpApp(
        tester,
        location: AppRoutes.routineDetail(_routine.id),
        routines: [_routine],
      );

      await _tap(tester, find.byTooltip(RoutineStrings.more));
      await _tap(tester, find.text(RoutineStrings.delete));
      expect(find.text(RoutineStrings.deleteRoutineTitle), findsOneWidget);
      await _confirm(tester);

      expect(find.byType(RoutinesScreen), findsOneWidget);
      expect(find.text(RoutineStrings.noRoutines), findsOneWidget);
      expect(find.text(RoutineStrings.routineDeleted), findsOneWidget);
      expect(app.routines.routines, isEmpty);
    });

    testWidgets('given a missing routine, when its detail opens, '
        'then a not found message is shown', (tester) async {
      await pumpApp(tester, location: AppRoutes.routineDetail('missing'));

      expect(find.text(RoutineStrings.notFound), findsOneWidget);
    });
  });

  test('given a long name, when building the copy name, '
      'then it fits the maximum length', () {
    final name = RoutineStrings.copyName('a' * 60);
    expect(name.length, lessThanOrEqualTo(60));
    expect(name, endsWith(' (copia)'));
  });
}
