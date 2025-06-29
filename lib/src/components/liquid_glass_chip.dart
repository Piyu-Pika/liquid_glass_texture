import 'package:flutter/material.dart';
import '../utils/liquid_glass_effects.dart';

class LiquidGlassChip extends StatelessWidget {
  final Widget label;
  final VoidCallback? onTap;
  final bool isSelected;
  final Color? backgroundColor;
  final Color? selectedColor;

  const LiquidGlassChip({
    super.key,
    required this.label,
    this.onTap,
    this.isSelected = false,
    this.backgroundColor,
    this.selectedColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: EnhancedLiquidGlassEffects.buildPremiumGlassContainer(
        child: label,
        borderRadius: 20,
        backgroundColor: isSelected
            ? (selectedColor ?? Theme.of(context).primaryColor.withOpacity(0.3))
            : backgroundColor,
        isDark: isDark,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }
}
