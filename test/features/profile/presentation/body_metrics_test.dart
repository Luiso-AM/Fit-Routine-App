import 'package:app_entrenamiento/core/routing/app_routes.dart';
import 'package:app_entrenamiento/core/utils/calendar_date.dart';
import 'package:app_entrenamiento/features/profile/domain/body_measurement.dart';
import 'package:app_entrenamiento/features/profile/domain/body_weight_entry.dart';
import 'package:app_entrenamiento/features/profile/presentation/profile_screen.dart';
import 'package:app_entrenamiento/features/profile/presentation/profile_strings.dart';
import 'package:app_entrenamiento/features/profile/presentation/screens/body_measurement_form_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../../helpers/pump_app.dart';

final _today = calendarDate(DateTime.now());
final _fourDaysAgo = _today.subtract(const Duration(days: 4));

Finder _field(String label) => find.widgetWithText(TextField, label);

Future<void> _tap(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

Future<void> _confirmDelete(WidgetTester tester) async {
  expect(find.text(ProfileStrings.deleteEntryTitle), findsOneWidget);
  await _tap(tester, find.widgetWithText(TextButton, ProfileStrings.delete));
}

void main() {
  group('body weight', () {
    testWidgets('given weight entries, when the profile tab opens, '
        'then the latest weight is shown', (tester) async {
      await pumpApp(
        tester,
        location: AppRoutes.profile,
        weights: [
          BodyWeightEntry(id: 'old', date: _fourDaysAgo, weightKg: 79),
          BodyWeightEntry(id: 'new', date: _today, weightKg: 78.25),
        ],
      );

      expect(find.text('78.3 kg'), findsOneWidget);
      expect(find.textContaining('Registrado el'), findsOneWidget);
    });

    testWidgets('given no entries, when a weight is logged from the profile, '
        'then it is saved for today and shown', (tester) async {
      final app = await pumpApp(tester, location: AppRoutes.profile);
      expect(find.text(ProfileStrings.noRecords), findsNWidgets(2));

      await _tap(tester, find.text(ProfileStrings.logWeight));
      await tester.enterText(_field(ProfileStrings.bodyWeight), '77,5');
      await _tap(tester, find.text(ProfileStrings.save));

      expect(find.byType(ProfileScreen), findsOneWidget);
      expect(find.text('77.5 kg'), findsOneWidget);
      expect(find.text(ProfileStrings.weightSaved), findsOneWidget);
      final entry = app.bodyMetrics.weights.single;
      expect(entry.weightKg, 77.5);
      expect(entry.date, _today);
    });

    testWidgets('given an empty weight, when saved, '
        'then an error is shown and the sheet stays open', (tester) async {
      final app = await pumpApp(tester, location: AppRoutes.profile);

      await _tap(tester, find.text(ProfileStrings.logWeight));
      await _tap(tester, find.text(ProfileStrings.save));

      expect(find.text(ProfileStrings.weightRequired), findsOneWidget);
      expect(app.bodyMetrics.weights, isEmpty);
    });

    testWidgets('given an entry today, when another weight is logged today, '
        'then a replace hint is shown and the entry is replaced', (
      tester,
    ) async {
      final app = await pumpApp(
        tester,
        location: AppRoutes.profile,
        weights: [BodyWeightEntry(id: 'today', date: _today, weightKg: 78)],
      );

      await _tap(tester, find.text(ProfileStrings.logWeight));
      expect(find.text(ProfileStrings.replacesEntry), findsOneWidget);
      await tester.enterText(_field(ProfileStrings.bodyWeight), '77.8');
      await _tap(tester, find.text(ProfileStrings.save));

      expect(app.bodyMetrics.weights.single.weightKg, 77.8);
    });

    testWidgets('given entries, when the history opens, '
        'then they are listed newest first with the change', (tester) async {
      await pumpApp(
        tester,
        location: AppRoutes.profileWeight,
        weights: [
          BodyWeightEntry(id: 'old', date: _fourDaysAgo, weightKg: 79),
          BodyWeightEntry(id: 'new', date: _today, weightKg: 78.4),
        ],
      );

      final newest = tester.getTopLeft(find.text('78.4 kg'));
      final oldest = tester.getTopLeft(find.text('79 kg'));
      expect(newest.dy, lessThan(oldest.dy));
      expect(find.text('-0.6 kg'), findsOneWidget);
    });

    testWidgets('given an entry in the history, when it is edited, '
        'then the new weight is saved', (tester) async {
      final app = await pumpApp(
        tester,
        location: AppRoutes.profileWeight,
        weights: [BodyWeightEntry(id: 'w', date: _fourDaysAgo, weightKg: 79)],
      );

      await _tap(tester, find.text('79 kg'));
      expect(find.text(ProfileStrings.editWeight), findsOneWidget);
      await tester.enterText(_field(ProfileStrings.bodyWeight), '78.9');
      await _tap(tester, find.text(ProfileStrings.save));

      expect(find.text('78.9 kg'), findsOneWidget);
      expect(app.bodyMetrics.weights.single.date, _fourDaysAgo);
    });

    testWidgets('given an entry in the history, when it is deleted, '
        'then the empty message is shown', (tester) async {
      final app = await pumpApp(
        tester,
        location: AppRoutes.profileWeight,
        weights: [BodyWeightEntry(id: 'w', date: _today, weightKg: 79)],
      );

      await _tap(tester, find.text('79 kg'));
      await _tap(
        tester,
        find.widgetWithText(OutlinedButton, ProfileStrings.delete),
      );
      await _confirmDelete(tester);

      expect(find.text(ProfileStrings.noWeights), findsOneWidget);
      expect(app.bodyMetrics.weights, isEmpty);
    });
  });

  group('measurements', () {
    final measurement = BodyMeasurement(
      id: 'm',
      date: _fourDaysAgo,
      waistCm: 82,
      bodyFatPct: 18.5,
    );

    testWidgets('given the profile, when measurements are saved empty, '
        'then the no values error is shown', (tester) async {
      await pumpApp(tester, location: AppRoutes.profile);

      await _tap(tester, find.text(ProfileStrings.logMeasurements));
      await _tap(tester, find.text(ProfileStrings.save));

      expect(find.byType(BodyMeasurementFormScreen), findsOneWidget);
      expect(find.text(ProfileStrings.measurementNoValues), findsOneWidget);
    });

    testWidgets('given the profile, when a waist measurement is logged, '
        'then the profile shows it', (tester) async {
      final app = await pumpApp(tester, location: AppRoutes.profile);

      await _tap(tester, find.text(ProfileStrings.logMeasurements));
      await tester.enterText(_field(ProfileStrings.waist), '82,5');
      await _tap(tester, find.text(ProfileStrings.save));

      expect(find.byType(ProfileScreen), findsOneWidget);
      expect(find.text(ProfileStrings.measurementsSaved), findsOneWidget);
      expect(find.text('82.5 cm'), findsOneWidget);
      final logged = app.bodyMetrics.measurements.single;
      expect(logged.waistCm, 82.5);
      expect(logged.chestCm, isNull);
      expect(logged.date, _today);
    });

    testWidgets('given a body fat out of range, when saved, '
        'then its error is shown', (tester) async {
      await pumpApp(tester, location: AppRoutes.profileMeasurementNew);

      await tester.enterText(_field(ProfileStrings.bodyFat), '90');
      await _tap(tester, find.text(ProfileStrings.save));

      expect(find.text(ProfileStrings.bodyFatOutOfRange), findsOneWidget);
    });

    testWidgets('given a measurement in the history, when a value is cleared '
        'and another added, then the history shows the change', (tester) async {
      final app = await pumpApp(
        tester,
        location: AppRoutes.profileMeasurements,
        measurements: [measurement],
      );

      await _tap(tester, find.text('Cintura 82 cm', findRichText: true));
      expect(find.text(ProfileStrings.editMeasurements), findsOneWidget);
      await tester.enterText(_field(ProfileStrings.waist), '');
      await tester.enterText(_field(ProfileStrings.arm), '35');
      await _tap(tester, find.text(ProfileStrings.save));

      expect(find.text('Brazo 35 cm', findRichText: true), findsOneWidget);
      expect(find.text('Cintura 82 cm', findRichText: true), findsNothing);
      final updated = app.bodyMetrics.measurements.single;
      expect(updated.waistCm, isNull);
      expect(updated.bodyFatPct, 18.5);
    });

    testWidgets('given a measurement, when it is deleted from its form, '
        'then the history is empty', (tester) async {
      await pumpApp(
        tester,
        location: AppRoutes.profileMeasurements,
        measurements: [measurement],
      );

      await _tap(tester, find.text('Cintura 82 cm', findRichText: true));
      await _tap(tester, find.byTooltip(ProfileStrings.delete));
      await _confirmDelete(tester);

      expect(find.text(ProfileStrings.noMeasurements), findsOneWidget);
    });

    testWidgets('given a missing id, when its form opens, '
        'then a not found message is shown', (tester) async {
      await pumpApp(
        tester,
        location: AppRoutes.profileMeasurementEdit('missing'),
      );

      expect(find.text(ProfileStrings.measurementNotFound), findsOneWidget);
    });
  });
}
