import 'package:app_entrenamiento/app/app.dart';
import 'package:app_entrenamiento/core/strings/app_strings.dart';
import 'package:app_entrenamiento/features/dashboard/presentation/dashboard_screen.dart';
import 'package:app_entrenamiento/features/profile/presentation/profile_screen.dart';
import 'package:app_entrenamiento/features/progress/presentation/progress_screen.dart';
import 'package:app_entrenamiento/features/routines/presentation/routines_screen.dart';
import 'package:app_entrenamiento/features/workout/presentation/workout_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

Future<void> pumpApp(WidgetTester tester) async {
  await tester.pumpWidget(const ProviderScope(child: App()));
  await tester.pumpAndSettle();
}

Finder navDestination(String label) =>
    find.descendant(of: find.byType(NavigationBar), matching: find.text(label));

Finder appBarTitle(String title) =>
    find.descendant(of: find.byType(AppBar), matching: find.text(title));

void main() {
  group('App shell', () {
    testWidgets('given the app starts, when it renders, '
        'then it shows five tabs and the home screen', (tester) async {
      await pumpApp(tester);

      expect(find.byType(NavigationDestination), findsNWidgets(5));
      for (final label in [
        AppStrings.tabHome,
        AppStrings.tabWorkout,
        AppStrings.tabRoutines,
        AppStrings.tabProgress,
        AppStrings.tabProfile,
      ]) {
        expect(navDestination(label), findsOneWidget);
      }
      expect(find.byType(DashboardScreen), findsOneWidget);
      expect(appBarTitle(AppStrings.tabHome), findsOneWidget);
    });

    final tabs = <String, Type>{
      AppStrings.tabWorkout: WorkoutScreen,
      AppStrings.tabRoutines: RoutinesScreen,
      AppStrings.tabProgress: ProgressScreen,
      AppStrings.tabProfile: ProfileScreen,
      AppStrings.tabHome: DashboardScreen,
    };

    for (final MapEntry(key: label, value: screenType) in tabs.entries) {
      testWidgets('given the app is open, when the "$label" tab is tapped, '
          'then its screen and title are shown', (tester) async {
        await pumpApp(tester);
        if (label == AppStrings.tabHome) {
          // Leave home first so tapping it is a real navigation.
          await tester.tap(navDestination(AppStrings.tabProfile));
          await tester.pumpAndSettle();
        }

        await tester.tap(navDestination(label));
        await tester.pumpAndSettle();

        expect(find.byType(screenType), findsOneWidget);
        expect(appBarTitle(label), findsOneWidget);
        final navBar = tester.widget<NavigationBar>(find.byType(NavigationBar));
        expect(
          navBar.selectedIndex,
          [
            AppStrings.tabHome,
            AppStrings.tabWorkout,
            AppStrings.tabRoutines,
            AppStrings.tabProgress,
            AppStrings.tabProfile,
          ].indexOf(label),
        );
      });
    }
  });
}
