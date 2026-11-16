/// Rules of the rest timer between sets.
///
/// A rest is stored as the moment it ends, not as a countdown, so it
/// survives the app going to the background or being killed.
abstract final class RestTimer {
  /// How much the −/+ buttons move the end of a rest.
  static const Duration adjustStep = Duration(seconds: 15);

  /// When a rest of [restSeconds] started at [now] ends. `null` if the
  /// exercise has no rest.
  static DateTime? endAfter(int? restSeconds, DateTime now) {
    if (restSeconds == null || restSeconds <= 0) return null;
    return now.add(Duration(seconds: restSeconds));
  }

  /// The end of a rest ending at [endsAt] moved by [delta]. `null` if the
  /// rest would be over by [now].
  static DateTime? adjust(DateTime endsAt, Duration delta, DateTime now) {
    final moved = endsAt.add(delta);
    return moved.isAfter(now) ? moved : null;
  }

  /// Time left until [endsAt], never negative.
  static Duration remaining(DateTime endsAt, DateTime now) {
    final left = endsAt.difference(now);
    return left.isNegative ? Duration.zero : left;
  }

  /// Whether a rest ending at [endsAt] is still running at [now].
  static bool isRunning(DateTime? endsAt, DateTime now) =>
      endsAt != null && endsAt.isAfter(now);
}
