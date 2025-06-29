import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math' as math;

class EnhancedLiquidGlassButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final double borderRadius;
  final Color? backgroundColor;
  final EdgeInsetsGeometry padding;
  final double? width;
  final double? height;
  final bool enableMorphing;
  final bool enablePulse;
  final double blurIntensity;
  final List<Color>? gradientColors;

  const EnhancedLiquidGlassButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.borderRadius = 16.0,
    this.backgroundColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    this.width,
    this.height,
    this.enableMorphing = true,
    this.enablePulse = false,
    this.blurIntensity = 12.0,
    this.gradientColors,
  });

  @override
  State<EnhancedLiquidGlassButton> createState() =>
      _EnhancedLiquidGlassButtonState();
}

class _EnhancedLiquidGlassButtonState extends State<EnhancedLiquidGlassButton>
    with TickerProviderStateMixin {
  bool _isPressed = false;
  bool _isHovered = false;

  late AnimationController _rippleController;
  late AnimationController _morphController;
  late AnimationController _shimmerController;
  late AnimationController _pulseController;
  late AnimationController _pressController;

  late Animation<double> _rippleAnimation;
  late Animation<double> _morphAnimation;
  late Animation<double> _shimmerAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();

    _rippleController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _morphController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    _shimmerController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _pressController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _rippleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _rippleController, curve: Curves.easeOutQuart),
    );

    _morphAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _morphController, curve: Curves.easeInOutSine),
    );

    _shimmerAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _shimmerController, curve: Curves.linear),
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _pressController, curve: Curves.easeInOut),
    );

    _rotationAnimation = Tween<double>(begin: 0.0, end: 0.02).animate(
      CurvedAnimation(parent: _pressController, curve: Curves.easeInOut),
    );

    if (widget.enableMorphing) {
      _morphController.repeat();
    }

    _shimmerController.repeat();

    if (widget.enablePulse) {
      _pulseController.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _rippleController.dispose();
    _morphController.dispose();
    _shimmerController.dispose();
    _pulseController.dispose();
    _pressController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    setState(() => _isPressed = true);
    _pressController.forward();
    _rippleController.forward(from: 0.0);
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
    _pressController.reverse();
  }

  void _handleTapCancel() {
    setState(() => _isPressed = false);
    _pressController.reverse();
  }

  void _handleHover(bool hovering) {
    setState(() => _isHovered = hovering);
  }

  BorderRadius _createMorphingBorder(double morphValue) {
    final baseRadius = widget.borderRadius;
    final variation = baseRadius * 0.2 * math.sin(morphValue * math.pi * 2);
    return BorderRadius.only(
      topLeft: Radius.circular(baseRadius + variation),
      topRight: Radius.circular(baseRadius - variation * 0.5),
      bottomLeft: Radius.circular(baseRadius - variation * 0.3),
      bottomRight: Radius.circular(baseRadius + variation * 0.7),
    );
  }

  List<Color> _getGradientColors(
    bool isDark,
    double shimmerValue,
    bool isPressed,
  ) {
    if (widget.gradientColors != null) {
      return widget.gradientColors!;
    }

    final shimmer = math.sin(shimmerValue * math.pi * 2) * 0.1;
    final pressedMultiplier = isPressed ? 1.3 : 1.0;

    if (isDark) {
      return [
        Colors.white.withOpacity((0.2 + shimmer) * pressedMultiplier),
        Colors.white.withOpacity((0.12 + shimmer * 0.5) * pressedMultiplier),
        Colors.white.withOpacity(0.08 * pressedMultiplier),
        Colors.transparent,
      ];
    } else {
      return [
        Colors.white.withOpacity((0.8 + shimmer) * pressedMultiplier),
        Colors.white.withOpacity((0.5 + shimmer * 0.5) * pressedMultiplier),
        Colors.white.withOpacity(0.3 * pressedMultiplier),
        Colors.transparent,
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      onTap: widget.onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        transform: Matrix4.identity()..scale(_isPressed ? 0.95 : 1.0),
        child: Container(
          width: widget.width,
          height: widget.height,
          padding: widget.padding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            boxShadow: [
              // Outer glow
              BoxShadow(
                color: isDark
                    ? Colors.white.withOpacity(0.1)
                    : Colors.black.withOpacity(0.08),
                blurRadius: _isPressed ? 8 : 12,
                offset: const Offset(0, 4),
                spreadRadius: _isPressed ? -2 : 0,
              ),
              // Inner shadow for depth
              BoxShadow(
                color: isDark
                    ? Colors.black.withOpacity(0.3)
                    : Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            child: Stack(
              children: [
                // Background with glass effect
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        widget.backgroundColor?.withOpacity(0.15) ??
                            (isDark
                                ? Colors.white.withOpacity(0.12)
                                : Colors.white.withOpacity(0.25)),
                        widget.backgroundColor?.withOpacity(0.08) ??
                            (isDark
                                ? Colors.white.withOpacity(0.05)
                                : Colors.white.withOpacity(0.15)),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.6, 1.0],
                    ),
                    border: Border.all(
                      color: isDark
                          ? Colors.white.withOpacity(0.2)
                          : Colors.white.withOpacity(0.4),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                  ),
                ),

                // Animated ripple effect
                AnimatedBuilder(
                  animation: _rippleAnimation,
                  builder: (context, child) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          widget.borderRadius,
                        ),
                        gradient: RadialGradient(
                          center: Alignment.center,
                          radius: _rippleAnimation.value * 2,
                          colors: [
                            Colors.white.withOpacity(
                              (1 - _rippleAnimation.value) * 0.3,
                            ),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    );
                  },
                ),

                // Glossy highlight
                Positioned(
                  top: 1,
                  left: 1,
                  right: 1,
                  height: widget.height != null ? widget.height! * 0.5 : 20,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(widget.borderRadius - 1),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white.withOpacity(isDark ? 0.15 : 0.3),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),

                // Content
                Center(child: widget.child),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
