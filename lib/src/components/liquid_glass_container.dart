import 'package:flutter/material.dart';
import '../utils/liquid_glass_effects.dart';

/// A container widget with a liquid glass effect inspired by iOS 26.
///
/// This widget applies a glassmorphism effect with optional blur, color, and dark mode support.
class LiquidGlassContainer extends StatelessWidget {
  /// The child widget to display inside the glass container.
  final Widget child;

  /// The border radius of the glass container.
  final double borderRadius;

  /// The background color of the glass effect.
  final Color? backgroundColor;

  /// Whether to force dark mode for the glass effect.
  final bool isDark;

  /// The padding inside the glass container.
  final EdgeInsetsGeometry? padding;

  /// The width of the glass container.
  final double? width;

  /// The height of the glass container.
  final double? height;

  /// The margin around the glass container.
  final EdgeInsetsGeometry? margin;

  /// Creates a [LiquidGlassContainer] widget.
  const LiquidGlassContainer({
    super.key,
    required this.child,
    this.borderRadius = 12.0,
    this.backgroundColor,
    this.isDark = false,
    this.padding,
    this.width,
    this.height,
    this.margin,
  });

  /// Builds the widget tree for the glass container.
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: margin,
      child: EnhancedLiquidGlassEffects.buildPremiumGlassContainer(
        child: child,
        borderRadius: borderRadius,
        backgroundColor: backgroundColor,
        isDark: isDark || isDarkMode,
        padding: padding,
        width: width,
        height: height,
      ),
    );
  }
}
