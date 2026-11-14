import 'package:app_entrenamiento/app/bootstrap.dart';
import 'package:app_entrenamiento/core/database/app_database.dart';
import 'package:app_entrenamiento/core/database/database_provider.dart';
import 'package:app_entrenamiento/features/profile/presentation/profile_providers.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ProviderContainer container;

  setUp(() {
    container = ProviderContainer(
      overrides: [
        appDatabaseProvider.overrideWithValue(
          AppDatabase(NativeDatabase.memory()),
        ),
      ],
    );
  });

  tearDown(() => container.dispose());

  test('given a new database, when bootstrapping, '
      'then it completes with the profile already loaded', () async {
    // A timeout instead of hanging forever, like the app did on start.
    await bootstrap(container).timeout(const Duration(seconds: 5));

    final profile = container.read(currentProfileProvider);
    expect(profile.hasValue, isTrue);
    expect(profile.value, isNull);
  });
}
