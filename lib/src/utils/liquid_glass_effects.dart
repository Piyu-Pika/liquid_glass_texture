// lib/src/utils/liquid_glass_effects.dart
import 'package:flutter/material.dart';
import 'dart:ui';

class LiquidGlassEffects {
  static BoxDecoration getGlassDecoration({
    Color? backgroundColor,
    double borderRadius = 12.0,
    bool isDark = false,
  }) {
    return BoxDecoration(
      color:
          backgroundColor ??
          (isDark ? const Color(0x1AFFFFFF) : const Color(0x1A000000)),
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(
        color: isDark ? const Color(0x33FFFFFF) : const Color(0x33000000),
        width: 0.5,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 20,
          offset: const Offset(0, 10),
        ),
      ],
    );
  }

  static Widget buildGlassContainer({
    required Widget child,
    double borderRadius = 12.0,
    Color? backgroundColor,
    bool isDark = false,
    EdgeInsetsGeometry? padding,
    double? width,
    double? height,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          width: width,
          height: height,
          padding: padding,
          decoration: getGlassDecoration(
            backgroundColor: backgroundColor,
            borderRadius: borderRadius,
            isDark: isDark,
          ),
          child: child,
        ),
      ),
    );
  }

  static Widget buildLiquidEffect({
    required Widget child,
    bool isPressed = false,
    Duration duration = const Duration(milliseconds: 200),
  }) {
    return AnimatedScale(
      scale: isPressed ? 0.95 : 1.0,
      duration: duration,
      curve: Curves.easeInOut,
      child: child,
    );
  }
}
