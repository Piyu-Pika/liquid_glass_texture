import 'package:flutter/material.dart';
import '../utils/liquid_glass_colors.dart';

// Special FAB with liquid effects and colored background
class LiquidGlassFloatingActionButtonSpecial extends StatefulWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final double size;
  final Color? backgroundColor;

  const LiquidGlassFloatingActionButtonSpecial({
    Key? key,
    required this.onPressed,
    required this.child,
    this.size = 56.0,
    this.backgroundColor,
  }) : super(key: key);

  @override
  State<LiquidGlassFloatingActionButtonSpecial> createState() =>
      _LiquidGlassFloatingActionButtonSpecialState();
}

class _LiquidGlassFloatingActionButtonSpecialState
    extends State<LiquidGlassFloatingActionButtonSpecial>
    with TickerProviderStateMixin {
  bool _isPressed = false;
  late AnimationController _pulseController;
  late AnimationController _liquidController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _liquidAnimation;

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _liquidController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _liquidAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _liquidController, curve: Curves.linear));
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _liquidController.dispose();
    super.dispose();
  }

  void _handleTapDown() {
    setState(() => _isPressed = true);
    _pulseController.forward();
  }

  void _handleTapUp() {
    setState(() => _isPressed = false);
    _pulseController.reverse();
  }

  void _handleTapCancel() {
    setState(() => _isPressed = false);
    _pulseController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveBackgroundColor =
        widget.backgroundColor ?? LiquidGlassColors.primary;

    return GestureDetector(
      onTapDown: (_) => _handleTapDown(),
      onTapUp: (_) => _handleTapUp(),
      onTapCancel: _handleTapCancel,
      onTap: widget.onPressed,
      child: AnimatedBuilder(
        animation: Listenable.merge([_pulseAnimation, _liquidAnimation]),
        builder: (context, child) {
          return Transform.scale(
            scale: _isPressed ? 0.9 : 1.0,
            child: Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  // Main shadow
                  BoxShadow(
                    color: effectiveBackgroundColor.withOpacity(0.3),
                    blurRadius: _isPressed ? 8 : 16,
                    offset: const Offset(0, 4),
                    spreadRadius: _isPressed ? -2 : 2,
                  ),
                  // Glow effect
                  BoxShadow(
                    color: effectiveBackgroundColor.withOpacity(0.1),
                    blurRadius: 32,
                    offset: const Offset(0, 8),
                    spreadRadius: 4,
                  ),
                ],
              ),
              child: ClipOval(
                child: Stack(
                  children: [
                    // Background gradient
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          center: const Alignment(-0.3, -0.3),
                          radius: 1.2,
                          colors: [
                            effectiveBackgroundColor.withOpacity(0.8),
                            effectiveBackgroundColor.withOpacity(0.6),
                            effectiveBackgroundColor.withOpacity(0.4),
                          ],
                          stops: const [0.0, 0.7, 1.0],
                        ),
                      ),
                    ),

                    // Liquid animation layer
                    Transform.rotate(
                      angle: _liquidAnimation.value * 6.28,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: SweepGradient(
                            colors: [
                              Colors.transparent,
                              Colors.white.withOpacity(0.1),
                              Colors.transparent,
                              Colors.white.withOpacity(0.05),
                            ],
                            stops: const [0.0, 0.25, 0.5, 0.75],
                          ),
                        ),
                      ),
                    ),

                    // Glass overlay
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white.withOpacity(0.3),
                            Colors.white.withOpacity(0.1),
                            Colors.transparent,
                            Colors.black.withOpacity(0.1),
                          ],
                          stops: const [0.0, 0.3, 0.7, 1.0],
                        ),
                      ),
                    ),

                    // Border highlight
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withOpacity(0.4),
                          width: 1.5,
                        ),
                      ),
                    ),

                    // Glossy highlight
                    Positioned(
                      top: widget.size * 0.15,
                      left: widget.size * 0.15,
                      width: widget.size * 0.3,
                      height: widget.size * 0.2,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            widget.size * 0.15,
                          ),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.white.withOpacity(0.6),
                              Colors.white.withOpacity(0.2),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Content
                    Center(
                      child: Transform.scale(
                        scale: _pulseAnimation.value,
                        child: widget.child,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// Basic transparent FAB with simple glass effect
class LiquidGlassFloatingActionButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final double size;

  const LiquidGlassFloatingActionButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.size = 56.0,
  }) : super(key: key);

  @override
  State<LiquidGlassFloatingActionButton> createState() =>
      _LiquidGlassFloatingActionButtonState();
}

class _LiquidGlassFloatingActionButtonState
    extends State<LiquidGlassFloatingActionButton>
    with SingleTickerProviderStateMixin {
  bool _isPressed = false;
  late AnimationController _shimmerController;
  late Animation<double> _shimmerAnimation;

  @override
  void initState() {
    super.initState();

    _shimmerController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    _shimmerAnimation = Tween<double>(begin: -1.0, end: 1.0).animate(
      CurvedAnimation(parent: _shimmerController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onPressed,
      child: AnimatedScale(
        scale: _isPressed ? 0.92 : 1.0,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOut,
        child: Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              // Soft shadow
              BoxShadow(
                color: isDark
                    ? Colors.black.withOpacity(0.4)
                    : Colors.black.withOpacity(0.15),
                blurRadius: _isPressed ? 8 : 16,
                offset: Offset(0, _isPressed ? 2 : 6),
                spreadRadius: _isPressed ? -2 : 0,
              ),
              // Subtle glow
              BoxShadow(
                color: isDark
                    ? Colors.white.withOpacity(0.05)
                    : Colors.white.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 2),
                spreadRadius: 2,
              ),
            ],
          ),
          child: ClipOval(
            child: Stack(
              children: [
                // Glass background
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isDark
                        ? Colors.white.withOpacity(0.08)
                        : Colors.white.withOpacity(0.2),
                    border: Border.all(
                      color: isDark
                          ? Colors.white.withOpacity(0.15)
                          : Colors.white.withOpacity(0.3),
                      width: 1.0,
                    ),
                  ),
                ),

                // Subtle shimmer effect
                AnimatedBuilder(
                  animation: _shimmerAnimation,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(_shimmerAnimation.value * widget.size, 0),
                      child: Container(
                        width: widget.size * 0.3,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Colors.transparent,
                              Colors.white.withOpacity(0.1),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),

                // Glass highlight
                Positioned(
                  top: widget.size * 0.1,
                  left: widget.size * 0.1,
                  width: widget.size * 0.4,
                  height: widget.size * 0.3,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(widget.size * 0.2),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white.withOpacity(0.4),
                          Colors.white.withOpacity(0.1),
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
