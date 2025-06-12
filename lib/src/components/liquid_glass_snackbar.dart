import 'package:flutter/material.dart';
import '../utils/liquid_glass_effects.dart';

class LiquidGlassSnackBar {
  static SnackBar create({
    required String message,
    Widget? action,
    Duration duration = const Duration(seconds: 4),
    Color? backgroundColor,
  }) {
    return SnackBar(
      content: Text(message),
      action: action as SnackBarAction?,
      duration: duration,
      backgroundColor: Colors.transparent,
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }

  static void show({
    required BuildContext context,
    required String message,
    Widget? action,
    Duration duration = const Duration(seconds: 4),
    Color? backgroundColor,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          child: LiquidGlassEffects.buildGlassContainer(
            child: Text(
              message,
              style: TextStyle(color: isDark ? Colors.white : Colors.black),
            ),
            borderRadius: 12,
            isDark: isDark,
            padding: const EdgeInsets.all(16),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        duration: duration,
        action: action is SnackBarAction ? action : null,
      ),
    );
  }
}
