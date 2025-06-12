import 'package:flutter/material.dart';
import '../utils/liquid_glass_effects.dart';

class LiquidGlassButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final double borderRadius;
  final Color? backgroundColor;
  final EdgeInsetsGeometry padding;
  final double? width;
  final double? height;

  const LiquidGlassButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.borderRadius = 12.0,
    this.backgroundColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    this.width,
    this.height,
  }) : super(key: key);

  @override
  State<LiquidGlassButton> createState() => _LiquidGlassButtonState();
}

class _LiquidGlassButtonState extends State<LiquidGlassButton> {
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
          borderRadius: widget.borderRadius,
          backgroundColor: widget.backgroundColor,
          isDark: isDark,
          padding: widget.padding,
          width: widget.width,
          height: widget.height,
        ),
      ),
    );
  }
}
