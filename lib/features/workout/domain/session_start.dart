import 'package:freezed_annotation/freezed_annotation.dart';

part 'session_start.freezed.dart';

/// When a finished session started and which routine day it came from,
/// without its exercises and sets.
@freezed
abstract class SessionStart with _$SessionStart {
  const factory SessionStart({
    required String sessionId,

    /// `null` for free sessions, or when the routine day was removed.
    String? routineDayId,
    required DateTime startedAt,
  }) = _SessionStart;
}
