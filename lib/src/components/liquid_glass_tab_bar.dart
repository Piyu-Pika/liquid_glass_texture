import 'package:flutter/material.dart';
import '../utils/liquid_glass_effects.dart';
import 'liquid_glass_icon.dart';

class LiquidGlassTabBar extends StatelessWidget {
  final List<Tab> tabs;
  final TabController? controller;
  final ValueChanged<int>? onTap;

  const LiquidGlassTabBar({
    super.key,
    required this.tabs,
    this.controller,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      top: false,
      child: Container(
        margin: const EdgeInsets.all(16),
        child: LiquidGlassEffects.buildGlassContainer(
          child: TabBar(
            controller: controller,
            onTap: onTap,
            tabs: tabs.map((tab) {
              if (tab.icon != null) {
                return Tab(
                  icon: LiquidGlassIcon(
                    icon: (tab.icon as Icon).icon!,
                    size: 22,
                    color: tab.iconMargin != null ? Theme.of(context).primaryColor : Colors.grey[600],
                    isSelected: tab.iconMargin != null,
                  ),
                  text: tab.text,
                );
              }
              return tab;
            }).toList(),
            indicator: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.18),
              borderRadius: BorderRadius.circular(8),
            ),
            labelColor: Theme.of(context).primaryColor,
            unselectedLabelColor: Colors.grey[600],
            dividerColor: Colors.transparent,
            labelStyle: const TextStyle(fontWeight: FontWeight.w700),
            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
          ),
          borderRadius: 16,
          isDark: isDark,
          padding: const EdgeInsets.all(4),
        ),
      ),
    );
  }
}
