import 'package:flutter/material.dart';

class LiquidGlassButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final double borderRadius;
  final Color? backgroundColor;
  final EdgeInsetsGeometry padding;
  final double? width;
  final double? height;

  const LiquidGlassButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.borderRadius = 12.0,
    this.backgroundColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    this.width,
    this.height,
  });

  @override
  State<LiquidGlassButton> createState() => _LiquidGlassButtonState();
}

class _LiquidGlassButtonState extends State<LiquidGlassButton>
    with TickerProviderStateMixin {
  bool _isPressed = false;
  late AnimationController _rippleController;
  late Animation<double> _rippleAnimation;

  @override
  void initState() {
    super.initState();
    _rippleController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _rippleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _rippleController, curve: Curves.easeOutQuart),
    );
  }

  @override
  void dispose() {
    _rippleController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    setState(() => _isPressed = true);
    _rippleController.forward(from: 0.0);
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
  }

  void _handleTapCancel() {
    setState(() => _isPressed = false);
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
