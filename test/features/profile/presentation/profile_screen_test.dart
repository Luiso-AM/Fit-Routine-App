import 'package:app_entrenamiento/core/routing/app_routes.dart';
import 'package:app_entrenamiento/features/profile/domain/enums/sex.dart';
import 'package:app_entrenamiento/features/profile/presentation/profile_screen.dart';
import 'package:app_entrenamiento/features/profile/presentation/profile_strings.dart';
import 'package:app_entrenamiento/features/profile/presentation/screens/profile_form_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../../helpers/fake_profile_repository.dart';
import '../../../helpers/pump_app.dart';

Finder _field(String label) => find.widgetWithText(TextField, label);

Future<void> _tapInForm(WidgetTester tester, Finder finder) async {
  // The ListView builds lazily: scroll until built, then fully into view.
  await tester.scrollUntilVisible(
    finder,
    200,
    scrollable: find.byType(Scrollable).first,
  );
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

/// Scrolls the screen's list until [text] is visible.
Future<void> _scrollTo(WidgetTester tester, String text) =>
    tester.scrollUntilVisible(
      find.text(text),
      200,
      scrollable: find.byType(Scrollable).first,
    );

void main() {
  testWidgets('given a profile, when the profile tab opens, '
      'then its data is shown', (tester) async {
    await pumpApp(
      tester,
      location: AppRoutes.profile,
      profile: testProfile.copyWith(sex: Sex.female, heightCm: 168.5),
    );

    expect(find.text('Alex'), findsOneWidget);
    expect(find.text('Mujer'), findsOneWidget);
    expect(find.text('168.5 cm'), findsOneWidget);
    expect(find.text(ProfileStrings.notSpecified), findsOneWidget); // age
    await _scrollTo(tester, 'Barra, Mancuerna');
    expect(find.text('4 días'), findsOneWidget);
    expect(find.text('60 min'), findsOneWidget);
    expect(find.text('Barra, Mancuerna'), findsOneWidget);
  });

  testWidgets('given the profile tab, when edit is tapped, '
      'then the form opens with the current values', (tester) async {
    await pumpApp(tester, location: AppRoutes.profile);

    await tester.tap(find.byTooltip(ProfileStrings.editProfile));
    await tester.pumpAndSettle();

    expect(find.byType(ProfileFormScreen), findsOneWidget);
    expect(find.text('Alex'), findsOneWidget);
    expect(find.text('175'), findsOneWidget);
  });

  testWidgets('given the edit form, when alias and days are changed and saved, '
      'then the profile tab shows the new values', (tester) async {
    final app = await pumpApp(tester, location: AppRoutes.profile);
    await tester.tap(find.byTooltip(ProfileStrings.editProfile));
    await tester.pumpAndSettle();

    await tester.enterText(_field(ProfileStrings.alias), 'Sam');
    // Close the keyboard, or the focused field scrolls back into view.
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await _tapInForm(tester, find.widgetWithText(ChoiceChip, '5'));
    await tester.tap(find.text(ProfileStrings.save));
    await tester.pumpAndSettle();

    expect(find.byType(ProfileScreen), findsOneWidget);
    expect(find.text('Sam'), findsOneWidget);
    await _scrollTo(tester, '5 días');
    expect(app.profile.profile!.daysPerWeek, 5);
    expect(find.text('5 días'), findsOneWidget);
    expect(find.text(ProfileStrings.profileSaved), findsOneWidget);
  });

  testWidgets('given the edit form, when the alias is cleared and saved, '
      'then an error is shown and nothing changes', (tester) async {
    final app = await pumpApp(tester, location: AppRoutes.profileEdit);

    await tester.enterText(_field(ProfileStrings.alias), '  ');
    await tester.tap(find.text(ProfileStrings.save));
    await tester.pumpAndSettle();

    expect(find.byType(ProfileFormScreen), findsOneWidget);
    expect(find.text(ProfileStrings.aliasRequired), findsOneWidget);
    expect(app.profile.profile!.alias, 'Alex');
  });

  testWidgets('given the edit form, when all equipment is unselected, '
      'then saving is rejected', (tester) async {
    await pumpApp(tester, location: AppRoutes.profileEdit);

    await _tapInForm(tester, find.widgetWithText(FilterChip, 'Barra'));
    await _tapInForm(tester, find.widgetWithText(FilterChip, 'Mancuerna'));
    await tester.tap(find.text(ProfileStrings.save));
    await tester.pumpAndSettle();

    expect(find.text(ProfileStrings.equipmentRequired), findsOneWidget);
  });
}
