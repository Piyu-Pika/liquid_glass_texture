import 'package:flutter/material.dart';
import '../utils/liquid_glass_effects.dart';

class LiquidGlassIcon extends StatelessWidget {
  final IconData icon;
  final double size;
  final Color? color;
  final Color? backgroundColor;
  final VoidCallback? onTap;
  final double borderRadius;

  const LiquidGlassIcon({
    Key? key,
    required this.icon,
    this.size = 24.0,
    this.color,
    this.backgroundColor,
    this.onTap,
    this.borderRadius = 12.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Widget iconWidget = LiquidGlassEffects.buildGlassContainer(
      child: Icon(
        icon,
        size: size,
        color: color ?? (isDark ? Colors.white : Colors.black),
      ),
      borderRadius: borderRadius,
      backgroundColor: backgroundColor,
      isDark: isDark,
      padding: const EdgeInsets.all(12),
    );

    if (onTap != null) {
      return GestureDetector(onTap: onTap, child: iconWidget);
    }

    return iconWidget;
  }
}
