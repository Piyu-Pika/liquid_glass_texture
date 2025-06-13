// lib/src/utils/liquid_glass_effects.dart
import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math' as math;

class LiquidGlassEffects {
  static BoxDecoration getGlassDecoration({
    Color? backgroundColor,
    double borderRadius = 12.0,
    bool isDark = false,
  }) {
    return BoxDecoration(
      color: (backgroundColor ?? (isDark ? const Color(0x22FFFFFF) : const Color(0x22FFFFFF))).withOpacity(0.22),
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(
        color: Colors.white.withOpacity(0.35),
        width: 1.2,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          blurRadius: 40,
          offset: const Offset(0, 12),
        ),
      ],
      // Add a subtle gradient for gloss
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white.withOpacity(0.30),
          Colors.white.withOpacity(0.10),
          Colors.transparent,
        ],
        stops: const [0.0, 0.4, 1.0],
      ),
    );
  }

  static Widget buildGlassContainer({
    required Widget child,
    double borderRadius = 12.0,
    Color? backgroundColor,
    bool isDark = false,
    EdgeInsetsGeometry? padding,
    double? width,
    double? height,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Stack(
        children: [
          // Liquid flow animation background
          Positioned.fill(
            child: LiquidFlowAnimation(
              isDark: isDark,
            ),
          ),
          // Blur effect (stronger for more glassy look)
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 28, sigmaY: 28),
            child: Container(
              width: width,
              height: height,
              padding: padding,
              decoration: getGlassDecoration(
                backgroundColor: backgroundColor,
                borderRadius: borderRadius,
                isDark: isDark,
              ),
              child: Stack(
                children: [
                  // Glossy highlight overlay
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(borderRadius),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.white.withOpacity(0.28),
                            Colors.white.withOpacity(0.06),
                            Colors.transparent,
                          ],
                          stops: const [0.0, 0.5, 1.0],
                        ),
                      ),
                    ),
                  ),
                  // Main child
                  child,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildLiquidEffect({
    required Widget child,
    bool isPressed = false,
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return AnimatedScale(
      scale: isPressed ? 0.97 : 1.0,
      duration: duration,
      curve: Curves.easeInOutCubic,
      child: child,
    );
  }
}

class LiquidFlowAnimation extends StatefulWidget {
  final bool isDark;

  const LiquidFlowAnimation({
    Key? key,
    required this.isDark,
  }) : super(key: key);

  @override
  State<LiquidFlowAnimation> createState() => _LiquidFlowAnimationState();
}

class _LiquidFlowAnimationState extends State<LiquidFlowAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Offset> _points = [];
  final int _numPoints = 5;
  final double _maxOffset = 20.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    // Initialize random points
    for (int i = 0; i < _numPoints; i++) {
      _points.add(Offset(
        math.Random().nextDouble() * _maxOffset,
        math.Random().nextDouble() * _maxOffset,
      ));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: LiquidFlowPainter(
            points: _points,
            progress: _controller.value,
            isDark: widget.isDark,
          ),
          size: Size.infinite,
        );
      },
    );
  }
}

class LiquidFlowPainter extends CustomPainter {
  final List<Offset> points;
  final double progress;
  final bool isDark;

  LiquidFlowPainter({
    required this.points,
    required this.progress,
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isDark
          ? Colors.white.withOpacity(0.03)
          : Colors.black.withOpacity(0.03)
      ..style = PaintingStyle.fill;

    final path = Path();
    final center = Offset(size.width / 2, size.height / 2);

    for (int i = 0; i < points.length; i++) {
      final point = points[i];
      final angle = (i / points.length) * 2 * math.pi + progress * 2 * math.pi;
      final x = center.dx + math.cos(angle) * point.dx;
      final y = center.dy + math.sin(angle) * point.dy;

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(LiquidFlowPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
