import 'package:flutter/material.dart';
import '../utils/liquid_glass_effects.dart';
import '../utils/liquid_glass_colors.dart';

class LiquidGlassFloatingActionButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final double size;
  final Color? backgroundColor;

  const LiquidGlassFloatingActionButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.size = 56.0,
    this.backgroundColor,
  }) : super(key: key);

  @override
  State<LiquidGlassFloatingActionButton> createState() =>
      _LiquidGlassFloatingActionButtonState();
}

class _LiquidGlassFloatingActionButtonState
    extends State<LiquidGlassFloatingActionButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onPressed,
      child: LiquidGlassEffects.buildLiquidEffect(
        isPressed: _isPressed,
        child: LiquidGlassEffects.buildGlassContainer(
          child: widget.child,
          borderRadius: widget.size / 2,
          backgroundColor: widget.backgroundColor ?? LiquidGlassColors.primary,
          isDark: isDark,
          width: widget.size,
          height: widget.size,
        ),
      ),
    );
  }
}
