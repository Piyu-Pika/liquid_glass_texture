import 'package:flutter/material.dart';
import '../utils/liquid_glass_effects.dart';

class LiquidGlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final double borderRadius;
  final VoidCallback? onTap;

  const LiquidGlassCard({
    super.key,
    required this.child,
    this.margin,
    this.padding,
    this.backgroundColor,
    this.borderRadius = 16.0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Widget card = Container(
      margin: margin,
      child: LiquidGlassEffects.buildGlassContainer(
        child: child,
        borderRadius: borderRadius,
        backgroundColor: backgroundColor,
        isDark: isDark,
        padding: padding ?? const EdgeInsets.all(16),
      ),
    );

    if (onTap != null) {
      return GestureDetector(onTap: onTap, child: card);
    }

    return card;
  }
}
