import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/database/database_provider.dart';
import '../domain/routine_repository.dart';
import 'drift_routine_repository.dart';

part 'routine_data_providers.g.dart';

/// Exposes the repository through its domain interface.
@Riverpod(keepAlive: true)
RoutineRepository routineRepository(Ref ref) =>
    DriftRoutineRepository(ref.watch(appDatabaseProvider));
