import 'package:flutter/material.dart';
import '../utils/liquid_glass_effects.dart';

class LiquidGlassTabBar extends StatelessWidget {
  final List<Tab> tabs;
  final TabController? controller;
  final ValueChanged<int>? onTap;

  const LiquidGlassTabBar({
    Key? key,
    required this.tabs,
    this.controller,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.all(16),
      child: LiquidGlassEffects.buildGlassContainer(
        child: TabBar(
          controller: controller,
          onTap: onTap,
          tabs: tabs,
          indicator: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          labelColor: Theme.of(context).primaryColor,
          unselectedLabelColor: Colors.grey,
          dividerColor: Colors.transparent,
        ),
        borderRadius: 16,
        isDark: isDark,
        padding: const EdgeInsets.all(4),
      ),
    );
  }
}
