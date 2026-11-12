import 'package:app_entrenamiento/core/routing/app_routes.dart';
import 'package:app_entrenamiento/core/strings/app_strings.dart';
import 'package:app_entrenamiento/features/exercises/domain/enums/difficulty.dart';
import 'package:app_entrenamiento/features/exercises/domain/enums/equipment.dart';
import 'package:app_entrenamiento/features/exercises/domain/enums/exercise_type.dart';
import 'package:app_entrenamiento/features/exercises/domain/enums/muscle_group.dart';
import 'package:app_entrenamiento/features/exercises/domain/exercise.dart';
import 'package:app_entrenamiento/features/exercises/presentation/exercise_strings.dart';
import 'package:app_entrenamiento/features/exercises/presentation/screens/exercise_detail_screen.dart';
import 'package:app_entrenamiento/features/exercises/presentation/screens/exercise_list_screen.dart';
import 'package:app_entrenamiento/features/exercises/presentation/widgets/exercise_filter_sheet.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../../helpers/pump_app.dart';

const _bench = Exercise(
  id: 'bench',
  name: 'Press de Banca (Barra)',
  primaryMuscle: MuscleGroup.chest,
  secondaryMuscles: [MuscleGroup.triceps],
  type: ExerciseType.compound,
  equipment: Equipment.barbell,
  difficulty: Difficulty.intermediate,
  instructions: '1. Acuéstate en el banco.',
  commonMistakes: '- Rebotar la barra.',
  isSeed: true,
);
const _chestMachine = Exercise(
  id: 'chest-machine',
  name: 'Press de Pecho (Máquina)',
  primaryMuscle: MuscleGroup.chest,
  type: ExerciseType.compound,
  equipment: Equipment.machine,
  difficulty: Difficulty.beginner,
  isSeed: true,
);
const _curl = Exercise(
  id: 'curl',
  name: 'Curl Martillo (Mancuerna)',
  primaryMuscle: MuscleGroup.biceps,
  type: ExerciseType.isolation,
  equipment: Equipment.dumbbell,
  difficulty: Difficulty.beginner,
  isSeed: true,
);
const _custom = Exercise(
  id: 'custom',
  name: 'Remo en T (Barra)',
  primaryMuscle: MuscleGroup.back,
  type: ExerciseType.compound,
  equipment: Equipment.barbell,
  difficulty: Difficulty.intermediate,
  isCustom: true,
);
const _all = [_bench, _chestMachine, _curl, _custom];

Future<void> openLibrary(WidgetTester tester) =>
    pumpApp(tester, location: AppRoutes.exercises, exercises: _all);

void main() {
  testWidgets('given the routines tab, when "Ejercicios" is tapped, '
      'then the library opens', (tester) async {
    await pumpApp(tester, location: AppRoutes.routines, exercises: _all);

    await tester.tap(find.text(AppStrings.exerciseLibrary));
    await tester.pumpAndSettle();

    expect(find.byType(ExerciseListScreen), findsOneWidget);
  });

  testWidgets('given the library, when it opens, '
      'then exercises are grouped by muscle with counts', (tester) async {
    await openLibrary(tester);

    expect(find.text('Pecho (2)'), findsOneWidget);
    expect(find.text('Espalda (1)'), findsOneWidget);
    expect(find.text('Bíceps (1)'), findsOneWidget);
    for (final exercise in _all) {
      expect(find.text(exercise.name), findsOneWidget);
    }
    expect(find.text(ExerciseStrings.custom), findsOneWidget);
  });

  testWidgets('given the library, when searching without accents, '
      'then only matching exercises remain', (tester) async {
    await openLibrary(tester);

    await tester.enterText(find.byType(TextField), 'MAQUINA');
    await tester.pumpAndSettle();

    expect(find.text(_chestMachine.name), findsOneWidget);
    expect(find.text(_bench.name), findsNothing);
    expect(find.text(_curl.name), findsNothing);
  });

  testWidgets(
    'given a search with no results, when "Limpiar filtros" is tapped, '
    'then the full list is back',
    (tester) async {
      await openLibrary(tester);
      await tester.enterText(find.byType(TextField), 'zzz');
      await tester.pumpAndSettle();
      expect(find.text(ExerciseStrings.noResults), findsOneWidget);

      await tester.tap(find.text(ExerciseStrings.clearFilters));
      await tester.pumpAndSettle();

      expect(find.text(ExerciseStrings.noResults), findsNothing);
      expect(find.text(_bench.name), findsOneWidget);
      expect(find.text(_curl.name), findsOneWidget);
    },
  );

  testWidgets('given the filter sheet, when "Mancuerna" is selected, '
      'then only dumbbell exercises remain and the badge shows 1', (
    tester,
  ) async {
    await openLibrary(tester);

    await tester.tap(find.byTooltip(ExerciseStrings.filters));
    await tester.pumpAndSettle();
    final dumbbellChip = find.widgetWithText(FilterChip, 'Mancuerna');
    await tester.scrollUntilVisible(
      dumbbellChip,
      100,
      scrollable: find
          .descendant(
            of: find.byType(ExerciseFilterSheet),
            matching: find.byType(Scrollable),
          )
          .first,
    );
    await tester.pumpAndSettle();
    await tester.tap(dumbbellChip);
    await tester.pumpAndSettle();
    await tester.tap(find.text(ExerciseStrings.done));
    await tester.pumpAndSettle();

    expect(find.text(_curl.name), findsOneWidget);
    expect(find.text(_bench.name), findsNothing);
    expect(find.text(_custom.name), findsNothing);
    expect(
      find.descendant(of: find.byType(Badge), matching: find.text('1')),
      findsOneWidget,
    );
  });

  testWidgets('given the library, when an exercise is tapped, '
      'then its detail shows muscles, instructions and mistakes', (
    tester,
  ) async {
    await openLibrary(tester);

    await tester.tap(find.text(_bench.name));
    await tester.pumpAndSettle();

    expect(find.byType(ExerciseDetailScreen), findsOneWidget);
    expect(find.text('Intermedio'), findsOneWidget);
    for (final text in [
      'Pecho',
      'Tríceps',
      _bench.instructions,
      _bench.commonMistakes,
    ]) {
      await tester.scrollUntilVisible(find.text(text), 100);
      expect(find.text(text), findsOneWidget);
    }
  });

  testWidgets('given an unknown exercise id, when its detail opens, '
      'then a not found message is shown', (tester) async {
    await pumpApp(
      tester,
      location: AppRoutes.exerciseDetail('missing'),
      exercises: _all,
    );

    expect(find.text(ExerciseStrings.notFound), findsOneWidget);
  });
}
