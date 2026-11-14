import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

part 'keep_screen_on.g.dart';

/// Keeps the device screen from turning off.
abstract interface class ScreenWakeLock {
  Future<void> setEnabled({required bool enabled});
}

class _WakelockPlusScreenWakeLock implements ScreenWakeLock {
  const _WakelockPlusScreenWakeLock();

  @override
  Future<void> setEnabled({required bool enabled}) =>
      WakelockPlus.toggle(enable: enabled);
}

@Riverpod(keepAlive: true)
ScreenWakeLock screenWakeLock(Ref ref) => const _WakelockPlusScreenWakeLock();

/// Keeps the screen on while [child] is visible.
///
/// Inactive tabs of the shell and covered routes run with tickers
/// disabled, so [TickerMode] tells whether the child is on screen.
class KeepScreenOn extends ConsumerStatefulWidget {
  const KeepScreenOn({required this.child, super.key});

  final Widget child;

  @override
  ConsumerState<KeepScreenOn> createState() => _KeepScreenOnState();
}

class _KeepScreenOnState extends ConsumerState<KeepScreenOn> {
  late final ScreenWakeLock _lock = ref.read(screenWakeLockProvider);
  bool? _enabled;

  void _set({required bool enabled}) {
    if (_enabled == enabled) return;
    _enabled = enabled;
    // Best effort: a platform failure must not break the workout screen.
    _lock.setEnabled(enabled: enabled).catchError((Object _) {});
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _set(enabled: TickerMode.valuesOf(context).enabled);
  }

  @override
  void dispose() {
    _set(enabled: false);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
