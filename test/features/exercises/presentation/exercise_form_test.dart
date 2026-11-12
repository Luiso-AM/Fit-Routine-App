import 'package:app_entrenamiento/core/routing/app_routes.dart';
import 'package:app_entrenamiento/features/exercises/domain/enums/difficulty.dart';
import 'package:app_entrenamiento/features/exercises/domain/enums/equipment.dart';
import 'package:app_entrenamiento/features/exercises/domain/enums/exercise_type.dart';
import 'package:app_entrenamiento/features/exercises/domain/enums/muscle_group.dart';
import 'package:app_entrenamiento/features/exercises/domain/exercise.dart';
import 'package:app_entrenamiento/features/exercises/presentation/exercise_strings.dart';
import 'package:app_entrenamiento/features/exercises/presentation/screens/exercise_detail_screen.dart';
import 'package:app_entrenamiento/features/exercises/presentation/screens/exercise_list_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../../helpers/pump_app.dart';

const _seed = Exercise(
  id: 'seed',
  name: 'Press de Banca (Barra)',
  primaryMuscle: MuscleGroup.chest,
  type: ExerciseType.compound,
  equipment: Equipment.barbell,
  difficulty: Difficulty.intermediate,
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
const _all = [_seed, _custom];

/// The form's ListView; each TextField has its own inner Scrollable.
final _formScroll = find.byType(Scrollable).first;

Finder _field(String label) => find.widgetWithText(TextField, label);

Future<void> _select(WidgetTester tester, String label, String option) async {
  final dropdown = find.ancestor(
    of: find.text(label),
    matching: find.byWidgetPredicate((w) => w is DropdownButtonFormField),
  );
  await tester.scrollUntilVisible(dropdown, 100, scrollable: _formScroll);
  await tester.tap(dropdown);
  await tester.pumpAndSettle();
  await tester.tap(find.text(option).last);
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('given the library, when "Nuevo ejercicio" is tapped, '
      'then the form opens', (tester) async {
    await pumpApp(tester, location: AppRoutes.exercises, exercises: _all);

    await tester.tap(find.text(ExerciseStrings.newExercise));
    await tester.pumpAndSettle();

    expect(find.text(ExerciseStrings.create), findsOneWidget);
  });

  testWidgets('given a complete form, when created, '
      'then the detail of the new custom exercise is shown', (tester) async {
    await pumpApp(tester, location: AppRoutes.exerciseNew, exercises: _all);

    await tester.enterText(_field(ExerciseStrings.name), 'Pullover (Polea)');
    await _select(tester, ExerciseStrings.primaryMuscle, 'Espalda');
    await _select(tester, ExerciseStrings.type, 'Aislamiento');
    await _select(tester, ExerciseStrings.equipment, 'Polea');
    await _select(tester, ExerciseStrings.difficulty, 'Principiante');
    await tester.tap(find.text(ExerciseStrings.create));
    await tester.pumpAndSettle();

    expect(find.byType(ExerciseDetailScreen), findsOneWidget);
    expect(find.text('Pullover (Polea)'), findsWidgets);
    expect(find.text(ExerciseStrings.custom), findsOneWidget);
  });

  testWidgets(
    'given an empty form, when saved, then required errors are shown',
    (tester) async {
      await pumpApp(tester, location: AppRoutes.exerciseNew, exercises: _all);

      await tester.tap(find.text(ExerciseStrings.create));
      await tester.pumpAndSettle();

      expect(find.byType(ExerciseDetailScreen), findsNothing);
      expect(find.text(ExerciseStrings.nameRequired), findsOneWidget);
      expect(find.text(ExerciseStrings.primaryMuscleRequired), findsOneWidget);
      await tester.scrollUntilVisible(
        find.text(ExerciseStrings.difficultyRequired),
        100,
        scrollable: _formScroll,
      );
      expect(find.text(ExerciseStrings.difficultyRequired), findsOneWidget);
    },
  );

  testWidgets('given the name of an existing exercise, when saved, '
      'then a duplicate error is shown', (tester) async {
    await pumpApp(tester, location: AppRoutes.exerciseNew, exercises: _all);

    await tester.enterText(
      _field(ExerciseStrings.name),
      'press de banca (barra)',
    );
    await tester.tap(find.text(ExerciseStrings.create));
    await tester.pumpAndSettle();

    expect(find.text(ExerciseStrings.nameDuplicate), findsOneWidget);
  });

  testWidgets('given a custom exercise, when its name is edited and saved, '
      'then the detail shows the new name', (tester) async {
    await pumpApp(
      tester,
      location: AppRoutes.exerciseEdit(_custom.id),
      exercises: _all,
    );

    await tester.enterText(_field(ExerciseStrings.name), 'Remo en T (Máquina)');
    await tester.tap(find.text(ExerciseStrings.save));
    await tester.pumpAndSettle();

    expect(find.byType(ExerciseDetailScreen), findsOneWidget);
    expect(find.text('Remo en T (Máquina)'), findsWidgets);
    expect(find.text(_custom.name), findsNothing);
  });

  testWidgets('given a custom exercise, when deleted and confirmed, '
      'then the library no longer lists it', (tester) async {
    await pumpApp(
      tester,
      location: AppRoutes.exerciseDetail(_custom.id),
      exercises: _all,
    );

    await tester.tap(find.byTooltip(ExerciseStrings.delete));
    await tester.pumpAndSettle();
    expect(find.text(ExerciseStrings.deleteTitle), findsOneWidget);
    await tester.tap(find.widgetWithText(TextButton, ExerciseStrings.delete));
    await tester.pumpAndSettle();

    expect(find.byType(ExerciseListScreen), findsOneWidget);
    expect(find.text(_custom.name), findsNothing);
    expect(find.text(_seed.name), findsOneWidget);
    expect(find.text(ExerciseStrings.deleted), findsOneWidget);
  });

  testWidgets(
    'given a custom exercise, when deletion is cancelled, then it is kept',
    (tester) async {
      await pumpApp(
        tester,
        location: AppRoutes.exerciseDetail(_custom.id),
        exercises: _all,
      );

      await tester.tap(find.byTooltip(ExerciseStrings.delete));
      await tester.pumpAndSettle();
      await tester.tap(find.text(ExerciseStrings.cancel));
      await tester.pumpAndSettle();

      expect(find.byType(ExerciseDetailScreen), findsOneWidget);
      expect(find.text(_custom.name), findsWidgets);
    },
  );

  testWidgets('given a seed exercise, when its detail opens, '
      'then it has no edit or delete actions', (tester) async {
    await pumpApp(
      tester,
      location: AppRoutes.exerciseDetail(_seed.id),
      exercises: _all,
    );

    expect(find.byTooltip(ExerciseStrings.edit), findsNothing);
    expect(find.byTooltip(ExerciseStrings.delete), findsNothing);
  });

  testWidgets('given a seed exercise, when its edit route opens, '
      'then a not editable message is shown', (tester) async {
    await pumpApp(
      tester,
      location: AppRoutes.exerciseEdit(_seed.id),
      exercises: _all,
    );

    expect(find.text(ExerciseStrings.seedNotEditable), findsOneWidget);
  });
}
