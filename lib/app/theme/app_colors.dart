import 'package:flutter/material.dart';

/// Color palette for the app's dark theme.
abstract final class AppColors {
  /// Single accent color used for primary actions and key metrics.
  static const Color accent = Color(0xFFB6F36A);
  static const Color onAccent = Color(0xFF0E0F11);

  /// Secondary highlight, reserved for warnings and time-sensitive states.
  static const Color secondary = Color(0xFFFF8A3D);
  static const Color onSecondary = Color(0xFF0E0F11);

  static const Color background = Color(0xFF0E0F11);
  static const Color surface = Color(0xFF17191C);
  static const Color surfaceHigh = Color(0xFF212429);
  static const Color outline = Color(0xFF34383F);

  static const Color textPrimary = Color(0xFFF2F3F5);
  static const Color textSecondary = Color(0xFFA3A8B0);

  static const Color error = Color(0xFFFF5A5F);
  static const Color onError = Color(0xFF0E0F11);
}
