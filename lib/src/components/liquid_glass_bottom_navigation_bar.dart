import 'package:flutter/material.dart';
import '../utils/liquid_glass_effects.dart';
import 'liquid_glass_icon.dart';

class LiquidGlassBottomNavigationBar extends StatelessWidget {
  final List<BottomNavigationBarItem> items;
  final int currentIndex;
  final ValueChanged<int>? onTap;
  final Color? backgroundColor;
  final double height;

  const LiquidGlassBottomNavigationBar({
    Key? key,
    required this.items,
    required this.currentIndex,
    this.onTap,
    this.backgroundColor,
    this.height = 70.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      top: false,
      child: Container(
        margin: const EdgeInsets.all(16),
        child: LiquidGlassEffects.buildGlassContainer(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              final isSelected = index == currentIndex;

              return GestureDetector(
                onTap: () => onTap?.call(index),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 18,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      LiquidGlassIcon(
                        icon: (item.icon as Icon).icon!,
                        size: 28,
                        color: isSelected
                            ? Theme.of(context).primaryColor
                            : Colors.grey[500],
                        backgroundColor: isSelected
                            ? Theme.of(context).primaryColor.withOpacity(0.10)
                            : Colors.transparent,
                        isSelected: isSelected,
                        enableGlow: true,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.label ?? '',
                        style: TextStyle(
                          fontSize: 13,
                          color: isSelected
                              ? Theme.of(context).primaryColor
                              : Colors.grey[600],
                          fontWeight: isSelected
                              ? FontWeight.w700
                              : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          borderRadius: 24,
          backgroundColor: backgroundColor,
          isDark: isDark,
          height: height,
        ),
      ),
    );
  }
}
