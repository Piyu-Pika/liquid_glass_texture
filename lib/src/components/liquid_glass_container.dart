import 'package:flutter/material.dart';
import '../utils/liquid_glass_effects.dart';

class LiquidGlassContainer extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final Color? backgroundColor;
  final bool isDark;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;

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

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: margin,
      child: LiquidGlassEffects.buildGlassContainer(
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
