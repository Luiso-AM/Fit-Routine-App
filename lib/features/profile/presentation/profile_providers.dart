import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/profile_data_providers.dart';
import '../domain/body_measurement.dart';
import '../domain/body_weight_entry.dart';
import '../domain/user_profile.dart';

part 'profile_providers.g.dart';

/// The user's profile, `null` before onboarding. Kept alive because the
/// router depends on it.
@Riverpod(keepAlive: true)
Stream<UserProfile?> currentProfile(Ref ref) =>
    ref.watch(profileRepositoryProvider).watch();

/// Body weight entries, newest first.
@riverpod
Stream<List<BodyWeightEntry>> bodyWeights(Ref ref) =>
    ref.watch(bodyMetricsRepositoryProvider).watchWeights();

/// Body measurements, newest first.
@riverpod
Stream<List<BodyMeasurement>> bodyMeasurements(Ref ref) =>
    ref.watch(bodyMetricsRepositoryProvider).watchMeasurements();

@riverpod
Stream<BodyMeasurement?> bodyMeasurementById(Ref ref, String id) =>
    ref.watch(bodyMetricsRepositoryProvider).watchMeasurementById(id);
