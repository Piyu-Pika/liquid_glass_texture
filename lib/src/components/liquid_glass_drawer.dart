import 'package:flutter/material.dart';
import '../utils/liquid_glass_effects.dart';

class LiquidGlassDrawer extends StatelessWidget {
  final Widget? header;
  final List<Widget> children;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const LiquidGlassDrawer({
    super.key,
    this.header,
    required this.children,
    this.borderRadius = 24.0,
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.transparent, // Fully transparent
      child: LiquidGlassEffects.buildGlassContainer(
        borderRadius: borderRadius,
        backgroundColor: Colors.transparent, // No color, just blur
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [if (header != null) header!, ...children],
        ),
      ),
    );
  }
}
