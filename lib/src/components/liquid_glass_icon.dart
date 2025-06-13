import 'package:flutter/material.dart';
import '../utils/liquid_glass_effects.dart';

class LiquidGlassIcon extends StatefulWidget {
  final IconData icon;
  final double size;
  final Color? color;
  final Color? backgroundColor;
  final VoidCallback? onTap;
  final double borderRadius;
  final bool isSelected;
  final bool enableGlow;

  const LiquidGlassIcon({
    super.key,
    required this.icon,
    this.size = 24.0,
    this.color,
    this.backgroundColor,
    this.onTap,
    this.borderRadius = 18.0,
    this.isSelected = false,
    this.enableGlow = true,
  });

  @override
  State<LiquidGlassIcon> createState() => _LiquidGlassIconState();
}

class _LiquidGlassIconState extends State<LiquidGlassIcon> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
      lowerBound: 0.95,
      upperBound: 1.0,
      value: 1.0,
    );
    _scaleAnim = _controller.drive(Tween(begin: 1.0, end: 0.95));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.reverse();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.forward();
    if (widget.onTap != null) widget.onTap!();
  }

  void _onTapCancel() {
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final iconColor = widget.color ?? (isDark ? Colors.white : Colors.black87);
    final glowColor = widget.isSelected && widget.enableGlow
        ? (widget.color ?? Theme.of(context).primaryColor).withOpacity(0.5)
        : Colors.transparent;

    Widget iconWidget = AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnim.value,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.25),
                  (widget.backgroundColor ?? Colors.transparent),
                  Colors.white.withOpacity(0.10),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                if (widget.isSelected && widget.enableGlow)
                  BoxShadow(
                    color: glowColor,
                    blurRadius: 16,
                    spreadRadius: 2,
                  ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
              ],
              borderRadius: BorderRadius.circular(widget.borderRadius),
            ),
            child: Icon(
              widget.icon,
              size: widget.size,
              color: iconColor,
            ),
          ),
        );
      },
    );

    iconWidget = LiquidGlassEffects.buildGlassContainer(
      child: iconWidget,
      borderRadius: widget.borderRadius,
      backgroundColor: widget.backgroundColor,
      isDark: isDark,
      padding: const EdgeInsets.all(12),
    );

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: iconWidget,
    );
  }
}
