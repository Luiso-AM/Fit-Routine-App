import 'package:app_entrenamiento/features/workout/domain/rest_notifier.dart';
import 'package:mocktail/mocktail.dart';

/// [RestNotifier] that records calls instead of showing notifications.
class MockRestNotifier extends Mock implements RestNotifier {
  MockRestNotifier() {
    when(() => schedule(any())).thenAnswer((_) async {});
    when(cancel).thenAnswer((_) async {});
  }
}
