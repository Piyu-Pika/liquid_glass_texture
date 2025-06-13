import 'package:flutter/material.dart';
import '../utils/liquid_glass_effects.dart';

class LiquidGlassAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool automaticallyImplyLeading;
  final double elevation;
  final Color? backgroundColor;

  const LiquidGlassAppBar({
    super.key,
    this.title,
    this.actions,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.elevation = 0,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 44, 16, 0),
      child: LiquidGlassEffects.buildGlassContainer(
        child: AppBar(
          title: title,
          actions: actions,
          leading: leading,
          automaticallyImplyLeading: automaticallyImplyLeading,
          elevation: elevation,
          backgroundColor: Colors.transparent,
        ),
        borderRadius: 16,
        isDark: isDark,
        height: 56,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
