import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/database/database_provider.dart';
import '../domain/body_metrics_repository.dart';
import '../domain/profile_repository.dart';
import 'drift_body_metrics_repository.dart';
import 'drift_profile_repository.dart';

part 'profile_data_providers.g.dart';

/// Exposes the repositories through their domain interfaces.
@Riverpod(keepAlive: true)
ProfileRepository profileRepository(Ref ref) =>
    DriftProfileRepository(ref.watch(appDatabaseProvider));

@Riverpod(keepAlive: true)
BodyMetricsRepository bodyMetricsRepository(Ref ref) =>
    DriftBodyMetricsRepository(ref.watch(appDatabaseProvider));
