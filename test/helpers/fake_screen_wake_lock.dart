import 'package:app_entrenamiento/core/widgets/keep_screen_on.dart';

/// Records whether the screen is being kept on.
class FakeScreenWakeLock implements ScreenWakeLock {
  bool enabled = false;

  @override
  Future<void> setEnabled({required bool enabled}) async {
    this.enabled = enabled;
  }
}
