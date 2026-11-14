import 'package:app_entrenamiento/core/routing/app_routes.dart';
import 'package:app_entrenamiento/core/units/weight_unit.dart';
import 'package:app_entrenamiento/features/exercises/domain/enums/difficulty.dart';
import 'package:app_entrenamiento/features/exercises/domain/enums/equipment.dart';
import 'package:app_entrenamiento/features/exercises/domain/enums/exercise_type.dart';
import 'package:app_entrenamiento/features/exercises/domain/enums/muscle_group.dart';
import 'package:app_entrenamiento/features/exercises/domain/exercise.dart';
import 'package:app_entrenamiento/features/routines/domain/routine.dart';
import 'package:app_entrenamiento/features/routines/presentation/routine_strings.dart';
import 'package:app_entrenamiento/features/routines/presentation/screens/exercise_picker_screen.dart';
import 'package:app_entrenamiento/features/routines/presentation/screens/routine_day_screen.dart';
import 'package:app_entrenamiento/features/routines/presentation/screens/routine_detail_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../../helpers/pump_app.dart';

const _bench = Exercise(
  id: 'bench',
  name: 'Press de Banca (Barra)',
  primaryMuscle: MuscleGroup.chest,
  type: ExerciseType.compound,
  equipment: Equipment.barbell,
  difficulty: Difficulty.intermediate,
);
const _fly = Exercise(
  id: 'fly',
  name: 'Aperturas (Polea)',
  primaryMuscle: MuscleGroup.chest,
  type: ExerciseType.isolation,
  equipment: Equipment.cable,
  difficulty: Difficulty.beginner,
  preferredUnit: WeightUnit.lb,
);
const _row = Exercise(
  id: 'row',
  name: 'Remo (Barra)',
  primaryMuscle: MuscleGroup.back,
  type: ExerciseType.compound,
  equipment: Equipment.barbell,
  difficulty: Difficulty.intermediate,
);
const _exercises = [_bench, _fly, _row];

RoutineExercise _planned(String id, String exerciseId, int position) =>
    RoutineExercise(
      id: id,
      routineDayId: 'd1',
      exerciseId: exerciseId,
      position: position,
      targetSets: 3,
      targetRepsMin: 10,
      targetRepsMax: 12,
      restSeconds: 120,
    );

Routine _routine({List<RoutineExercise>? exercises}) => Routine(
  id: 'r1',
  name: 'Mi rutina',
  days: [
    RoutineDay(
      id: 'd1',
      routineId: 'r1',
      name: 'Push',
      position: 0,
      exercises: exercises ?? [_planned('e1', _bench.id, 0)],
    ),
  ],
);

final _dayRoute = AppRoutes.routineDay('r1', 'd1');

Finder _field(String label) => find.widgetWithText(TextField, label);

Future<void> _tap(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

List<RoutineExercise> _dayExercises(PumpedApp app) =>
    app.routines.routines.single.days.single.exercises;

void main() {
  testWidgets('given a routine detail, when a day card is tapped, '
      'then the day opens with its exercises and targets', (tester) async {
    await pumpApp(
      tester,
      location: AppRoutes.routineDetail('r1'),
      routines: [_routine()],
      exercises: _exercises,
    );

    await _tap(tester, find.text('Push'));

    expect(find.byType(RoutineDayScreen), findsOneWidget);
    expect(find.text(_bench.name), findsOneWidget);
    expect(find.text('3 × 10–12 · Descanso 120 s'), findsOneWidget);
    expect(find.text('Pecho'), findsOneWidget);
  });

  testWidgets('given a day with chest exercises, when the picker opens, '
      'then it is filtered by chest', (tester) async {
    await pumpApp(
      tester,
      location: _dayRoute,
      routines: [_routine()],
      exercises: _exercises,
    );

    await _tap(tester, find.text(RoutineStrings.addExercises));

    expect(find.byType(ExercisePickerScreen), findsOneWidget);
    expect(find.widgetWithText(CheckboxListTile, _fly.name), findsOneWidget);
    expect(find.widgetWithText(CheckboxListTile, _row.name), findsNothing);
    final chest = tester.widget<FilterChip>(
      find.widgetWithText(FilterChip, 'Pecho'),
    );
    expect(chest.selected, isTrue);
  });

  testWidgets('given the picker, when two exercises are selected and added, '
      'then they are appended with default targets', (tester) async {
    final app = await pumpApp(
      tester,
      location: _dayRoute,
      routines: [_routine()],
      exercises: _exercises,
    );

    await _tap(tester, find.text(RoutineStrings.addExercises));
    await _tap(tester, find.text(_fly.name));
    // Clear the chest filter to reach back exercises.
    await _tap(tester, find.widgetWithText(FilterChip, 'Pecho'));
    await _tap(tester, find.text(_row.name));
    await _tap(tester, find.text(RoutineStrings.addSelected(2)));

    expect(find.byType(RoutineDayScreen), findsOneWidget);
    final exercises = _dayExercises(app);
    expect(
      [for (final e in exercises) e.exerciseId],
      [_bench.id, _fly.id, _row.id],
    );
    expect(exercises[1].restSeconds, 90);
    expect(exercises[2].restSeconds, 120);
    expect(find.text('3 × 10–12 · Descanso 90 s'), findsOneWidget);
  });

  testWidgets('given the picker, when nothing is selected, '
      'then the add button is disabled', (tester) async {
    await pumpApp(
      tester,
      location: _dayRoute,
      routines: [_routine()],
      exercises: _exercises,
    );

    await _tap(tester, find.text(RoutineStrings.addExercises));

    final button = tester.widget<FilledButton>(
      find.widgetWithText(FilledButton, RoutineStrings.addExercises),
    );
    expect(button.onPressed, isNull);
  });

  testWidgets('given an exercise, when its targets are edited, '
      'then the card shows them', (tester) async {
    final app = await pumpApp(
      tester,
      location: _dayRoute,
      routines: [_routine()],
      exercises: _exercises,
    );

    await _tap(tester, find.text(_bench.name));
    await tester.enterText(_field(RoutineStrings.sets), '4');
    await tester.enterText(_field(RoutineStrings.repsMin), '6');
    await tester.enterText(_field(RoutineStrings.repsMax), '8');
    await tester.enterText(_field(RoutineStrings.initialWeightOptional), '60');
    await tester.enterText(_field(RoutineStrings.rest), '180');
    await _tap(tester, find.text(RoutineStrings.save));

    expect(find.text('4 × 6–8 · 60 kg · Descanso 180 s'), findsOneWidget);
    final stored = _dayExercises(app).single;
    expect(stored.initialWeightKg, 60);
  });

  testWidgets('given an exercise in lb, when an initial weight is entered, '
      'then it is stored in kg and shown in lb', (tester) async {
    final app = await pumpApp(
      tester,
      location: _dayRoute,
      routines: [
        _routine(exercises: [_planned('e1', _fly.id, 0)]),
      ],
      exercises: _exercises,
    );

    await _tap(tester, find.text(_fly.name));
    expect(find.text('lb'), findsOneWidget);
    await tester.enterText(_field(RoutineStrings.initialWeightOptional), '135');
    await _tap(tester, find.text(RoutineStrings.save));

    expect(_dayExercises(app).single.initialWeightKg, closeTo(61.235, 0.001));
    expect(find.text('3 × 10–12 · 135 lb · Descanso 120 s'), findsOneWidget);
  });

  testWidgets('given min reps above max, when saved, '
      'then an error is shown and nothing changes', (tester) async {
    final app = await pumpApp(
      tester,
      location: _dayRoute,
      routines: [_routine()],
      exercises: _exercises,
    );

    await _tap(tester, find.text(_bench.name));
    await tester.enterText(_field(RoutineStrings.repsMin), '15');
    await _tap(tester, find.text(RoutineStrings.save));

    expect(find.text(RoutineStrings.repsRangeInverted), findsOneWidget);
    expect(_dayExercises(app).single.targetRepsMin, 10);
  });

  testWidgets('given an exercise, when removal is confirmed, '
      'then the day is empty', (tester) async {
    final app = await pumpApp(
      tester,
      location: _dayRoute,
      routines: [_routine()],
      exercises: _exercises,
    );

    await _tap(tester, find.text(_bench.name));
    await _tap(
      tester,
      find.widgetWithText(OutlinedButton, RoutineStrings.remove),
    );
    expect(find.text(RoutineStrings.removeExerciseTitle), findsOneWidget);
    await _tap(tester, find.widgetWithText(TextButton, RoutineStrings.remove));

    expect(find.text(RoutineStrings.noExercisesInDay), findsOneWidget);
    expect(find.text(RoutineStrings.exerciseRemoved), findsOneWidget);
    expect(_dayExercises(app), isEmpty);
  });

  testWidgets('given an exercise, when removal is cancelled, '
      'then it is kept with its targets', (tester) async {
    final app = await pumpApp(
      tester,
      location: _dayRoute,
      routines: [_routine()],
      exercises: _exercises,
    );

    await _tap(tester, find.text(_bench.name));
    await _tap(
      tester,
      find.widgetWithText(OutlinedButton, RoutineStrings.remove),
    );
    await _tap(tester, find.text(RoutineStrings.cancel));

    expect(find.text(_bench.name), findsOneWidget);
    expect(find.text(RoutineStrings.exerciseRemoved), findsNothing);
    expect(_dayExercises(app), hasLength(1));
  });

  testWidgets('given two exercises, when the first is dragged below, '
      'then the new order is saved', (tester) async {
    final app = await pumpApp(
      tester,
      location: _dayRoute,
      routines: [
        _routine(
          exercises: [_planned('e1', _bench.id, 0), _planned('e2', _fly.id, 1)],
        ),
      ],
      exercises: _exercises,
    );

    final handle = find.byIcon(Icons.drag_indicator).first;
    final gesture = await tester.startGesture(tester.getCenter(handle));
    await tester.pump(const Duration(milliseconds: 50));
    for (var i = 0; i < 8; i++) {
      await gesture.moveBy(const Offset(0, 20));
      await tester.pump(const Duration(milliseconds: 16));
    }
    await gesture.up();
    await tester.pumpAndSettle();

    expect([for (final e in _dayExercises(app)) e.id], ['e2', 'e1']);
  });

  testWidgets('given a day, when deleted from its screen, '
      'then the routine detail opens without it', (tester) async {
    final app = await pumpApp(
      tester,
      location: _dayRoute,
      routines: [_routine()],
      exercises: _exercises,
    );

    await _tap(tester, find.byTooltip(RoutineStrings.editDay));
    await _tap(
      tester,
      find.widgetWithText(OutlinedButton, RoutineStrings.delete),
    );
    await _tap(tester, find.widgetWithText(TextButton, RoutineStrings.delete));

    expect(find.byType(RoutineDetailScreen), findsOneWidget);
    expect(find.text(RoutineStrings.noDays), findsOneWidget);
    expect(app.routines.routines.single.days, isEmpty);
  });

  testWidgets('given a day whose exercise was deleted from the library, '
      'when it opens, then the exercise is labeled as deleted', (tester) async {
    await pumpApp(
      tester,
      location: _dayRoute,
      routines: [_routine()],
      exercises: const [_fly],
    );

    expect(find.text(RoutineStrings.missingExercise), findsOneWidget);
  });
}
