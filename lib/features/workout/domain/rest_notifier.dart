/// Tells the user when a rest ends, even if the app is in the background
/// or was closed.
abstract interface class RestNotifier {
  /// Shows a notification at [endsAt], replacing any one already
  /// scheduled. Asks for permission the first time if needed. A time
  /// already past only cancels the scheduled one.
  Future<void> schedule(DateTime endsAt);

  /// Cancels the scheduled notification, if any.
  Future<void> cancel();
}
