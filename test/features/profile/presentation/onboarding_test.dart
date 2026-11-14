import 'package:app_entrenamiento/core/routing/app_routes.dart';
import 'package:app_entrenamiento/core/utils/calendar_date.dart';
import 'package:app_entrenamiento/features/dashboard/presentation/dashboard_screen.dart';
import 'package:app_entrenamiento/features/exercises/domain/enums/equipment.dart';
import 'package:app_entrenamiento/features/profile/domain/enums/experience_level.dart';
import 'package:app_entrenamiento/features/profile/domain/enums/training_goal.dart';
import 'package:app_entrenamiento/features/profile/presentation/profile_strings.dart';
import 'package:app_entrenamiento/features/profile/presentation/screens/onboarding_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../../helpers/pump_app.dart';

Finder _field(String label) => find.widgetWithText(TextField, label);

Future<void> _tap(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

Future<void> _next(WidgetTester tester) =>
    _tap(tester, find.text(ProfileStrings.next));

Future<void> _fillAboutYou(WidgetTester tester) async {
  await tester.enterText(_field(ProfileStrings.alias), 'Alex');
  await tester.enterText(_field(ProfileStrings.height), '175,5');
  await tester.enterText(_field(ProfileStrings.bodyWeight), '78.4');
  await tester.pump();
}

Future<void> _fillTraining(WidgetTester tester) async {
  await _tap(tester, find.text('Intermedio'));
  await _tap(tester, find.text('Ganar fuerza'));
  await _tap(tester, find.widgetWithText(ChoiceChip, '4'));
  await tester.enterText(_field(ProfileStrings.sessionDuration), '60');
  await tester.pump();
}

void main() {
  testWidgets('given no profile, when the app starts, '
      'then onboarding is shown without the tab bar', (tester) async {
    await pumpApp(tester, profile: null);

    expect(find.byType(OnboardingScreen), findsOneWidget);
    expect(find.byType(NavigationBar), findsNothing);
    expect(find.text(ProfileStrings.stepAboutYou), findsOneWidget);
  });

  testWidgets('given no profile, when a tab route is opened, '
      'then it redirects to onboarding', (tester) async {
    await pumpApp(tester, profile: null, location: AppRoutes.profile);

    expect(find.byType(OnboardingScreen), findsOneWidget);
  });

  testWidgets('given a profile, when onboarding is opened, '
      'then it redirects home', (tester) async {
    await pumpApp(tester, location: AppRoutes.onboarding);

    expect(find.byType(OnboardingScreen), findsNothing);
    expect(find.byType(DashboardScreen), findsOneWidget);
  });

  testWidgets('given an empty first step, when "Siguiente" is tapped, '
      'then required errors are shown and the step does not change', (
    tester,
  ) async {
    await pumpApp(tester, profile: null);

    await _next(tester);

    expect(find.text(ProfileStrings.aliasRequired), findsOneWidget);
    expect(find.text(ProfileStrings.heightRequired), findsOneWidget);
    expect(find.text(ProfileStrings.weightRequired), findsOneWidget);
    expect(find.text(ProfileStrings.stepAboutYou), findsOneWidget);
  });

  testWidgets('given the second step, when "Atrás" is tapped, '
      'then the first step keeps its values', (tester) async {
    await pumpApp(tester, profile: null);
    await _fillAboutYou(tester);
    await _next(tester);
    expect(find.text(ProfileStrings.stepTraining), findsOneWidget);

    await _tap(tester, find.text(ProfileStrings.back));

    expect(find.text(ProfileStrings.stepAboutYou), findsOneWidget);
    expect(find.text('Alex'), findsOneWidget);
    expect(find.text('175.5'), findsOneWidget);
    expect(find.text('78.4'), findsOneWidget);
  });

  testWidgets('given every step completed, when "Comenzar" is tapped, '
      'then the profile and the first weight are saved and home opens', (
    tester,
  ) async {
    final app = await pumpApp(tester, profile: null);

    await _fillAboutYou(tester);
    await _next(tester);
    await _fillTraining(tester);
    await _next(tester);
    await _tap(tester, find.text(ProfileStrings.finish));
    expect(find.text(ProfileStrings.equipmentRequired), findsOneWidget);
    await _tap(tester, find.text('Mancuerna'));
    await _tap(tester, find.text(ProfileStrings.finish));

    expect(find.byType(DashboardScreen), findsOneWidget);
    final profile = app.profile.profile!;
    expect(profile.alias, 'Alex');
    expect(profile.heightCm, 175.5);
    expect(profile.birthDate, isNull);
    expect(profile.sex, isNull);
    expect(profile.experienceLevel, ExperienceLevel.intermediate);
    expect(profile.goal, TrainingGoal.strength);
    expect(profile.daysPerWeek, 4);
    expect(profile.sessionDurationMin, 60);
    expect(profile.equipment, [Equipment.dumbbell]);
    final weight = app.bodyMetrics.weights.single;
    expect(weight.weightKg, 78.4);
    expect(weight.date, calendarDate(DateTime.now()));
  });
}
