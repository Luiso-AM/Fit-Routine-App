import 'dart:async';

/// Change notifications for in-memory fake repositories.
mixin Watchable {
  final _changes = StreamController<void>.broadcast();

  void notifyChanged() => _changes.add(null);

  /// Emits the current value on listen and again after every change. Like
  /// Drift, changes made while the subscription is paused are delivered on
  /// resume (Riverpod pauses providers of off-screen routes).
  Stream<T> watchValue<T>(T Function() read) {
    late final StreamController<T> controller;
    StreamSubscription<void>? changes;
    controller = StreamController<T>(
      onListen: () {
        changes = _changes.stream.listen((_) => controller.add(read()));
        controller.add(read());
      },
      onCancel: () => changes?.cancel(),
    );
    return controller.stream;
  }
}
