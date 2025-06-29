// pubspec.yaml dependencies to add:
// dependencies:
//   flutter_animate: ^4.2.0
//   shimmer: ^3.0.0
//   glassmorphism: ^3.0.0
//   rive: ^0.12.4
//   lottie: ^2.7.0
//   flutter_shaders: ^0.1.2
//   animated_background: ^2.0.0
//   particle_field: ^1.0.0

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shimmer/shimmer.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_background/animated_background.dart';
import 'package:particle_field/particle_field.dart';
import 'dart:ui';
import 'dart:math' as math;

/// Ultra-enhanced liquid glass effects with third-party integrations
class EnhancedLiquidGlassEffects {
  static const Duration _morphDuration = Duration(milliseconds: 6000);
  static const Duration _rippleDuration = Duration(milliseconds: 800);
  static const Duration _hoverDuration = Duration(milliseconds: 300);

  /// Creates a premium glass container with advanced third-party effects
  static Widget buildPremiumGlassContainer({
    required Widget child,
    double borderRadius = 20.0,
    Color? backgroundColor,
    bool isDark = false,
    EdgeInsetsGeometry? padding,
    double? width,
    double? height,
    bool enableMorphing = true,
    bool enableShimmer = true,
    bool enableRipple = true,
    bool enableHover = true,
    bool enableParticles = true,
    bool enableLottieBackground = false,
    String? lottieAsset,
    double blurIntensity = 20.0,
    double opacity = 0.15,
    List<BoxShadow>? customShadows,
    VoidCallback? onTap,
    GlassType glassType = GlassType.frosted,
  }) {
    return _PremiumGlassContainer(
      borderRadius: borderRadius,
      backgroundColor: backgroundColor,
      isDark: isDark,
      padding: padding,
      width: width,
      height: height,
      enableMorphing: enableMorphing,
      enableShimmer: enableShimmer,
      enableRipple: enableRipple,
      enableHover: enableHover,
      enableParticles: enableParticles,
      enableLottieBackground: enableLottieBackground,
      lottieAsset: lottieAsset,
      blurIntensity: blurIntensity,
      opacity: opacity,
      customShadows: customShadows,
      onTap: onTap,
      glassType: glassType,
      child: child,
    );
  }

  /// Creates glassmorphism container using third-party package
  static Widget buildGlassmorphismContainer({
    required Widget child,
    double width = 350,
    double height = 250,
    double borderRadius = 20.0,
    double blur = 20.0,
    double opacity = 0.2,
    Color? color,
    bool isDark = false,
    EdgeInsetsGeometry? margin,
    Border? border,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child:
          GlassmorphicContainer(
                width: width,
                height: height,
                borderRadius: borderRadius,
                blur: blur,
                alignment: Alignment.bottomCenter,
                border: 2,
                linearGradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isDark
                      ? [
                          Colors.white.withOpacity(0.1),
                          Colors.white.withOpacity(0.05),
                        ]
                      : [
                          Colors.white.withOpacity(0.25),
                          Colors.white.withOpacity(0.1),
                        ],
                  stops: const [0.1, 1.0],
                ),
                borderGradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.5),
                    Colors.white.withOpacity(0.2),
                  ],
                ),
                margin: margin,
                child: child,
              )
              .animate(onPlay: (controller) => controller.repeat())
              .shimmer(duration: 3000.ms, color: Colors.white.withOpacity(0.3))
              .then()
              .shake(duration: 100.ms, hz: 4)
              .scale(begin: const Offset(1, 1), end: const Offset(1.02, 1.02))
              .then()
              .scale(begin: const Offset(1.02, 1.02), end: const Offset(1, 1)),
    );
  }

  /// Creates animated shimmer text effect
  static Widget buildShimmerText({
    required String text,
    TextStyle? style,
    bool isDark = false,
    Duration period = const Duration(milliseconds: 1500),
  }) {
    return Shimmer.fromColors(
      baseColor: isDark ? Colors.white70 : Colors.grey.shade800,
      highlightColor: isDark ? Colors.white : Colors.grey.shade300,
      period: period,
      child: Text(text, style: style),
    );
  }

  /// Creates particle field background
  static Widget buildParticleBackground({
    required Widget child,
    Color particleColor = Colors.white,
    int particleCount = 50,
    double particleSize = 2.0,
    bool isDark = false,
  }) {
    return Stack(
      children: [
        // ParticleField(

        //   onTick: (controller, elapsed, size) {
        //     // Add your particle tick logic here
        //   },
        // ),
        child,
      ],
    );
  }

  /// Creates floating animated background
  static Widget buildFloatingBackground({
    required Widget child,
    bool isDark = false,
  }) {
    return AnimatedBackground(
      behaviour: RandomParticleBehaviour(
        options: const ParticleOptions(
          baseColor: Colors.blue,
          spawnOpacity: 0.0,
          opacityChangeRate: 0.25,
          minOpacity: 0.1,
          maxOpacity: 0.4,
          spawnMinSpeed: 30.0,
          spawnMaxSpeed: 70.0,
          spawnMinRadius: 2.0,
          spawnMaxRadius: 5.0,
          particleCount: 40,
        ),
      ),
      vsync: _getTickerProvider(),
      child: child,
    );
  }

  /// Creates advanced morphing border with flutter_animate
  static Widget buildMorphingBorder({
    required Widget child,
    double baseRadius = 20.0,
    Color borderColor = Colors.white,
    double borderWidth = 1.0,
    Duration duration = const Duration(seconds: 4),
  }) {
    return child
        .animate(onPlay: (controller) => controller.repeat())
        .custom(
          duration: duration,
          curve: Curves.easeInOutSine,
          builder: (context, value, child) {
            final wave1 = math.sin(value * math.pi * 2) * 0.3;
            final wave2 = math.sin(value * math.pi * 2 + math.pi * 0.5) * 0.25;
            final wave3 = math.sin(value * math.pi * 2 + math.pi) * 0.2;
            final wave4 = math.sin(value * math.pi * 2 + math.pi * 1.5) * 0.22;

            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(baseRadius * (1 + wave1)),
                  topRight: Radius.circular(baseRadius * (1 + wave2)),
                  bottomRight: Radius.circular(baseRadius * (1 + wave3)),
                  bottomLeft: Radius.circular(baseRadius * (1 + wave4)),
                ),
                border: Border.all(color: borderColor, width: borderWidth),
              ),
              child: child,
            );
          },
        );
  }

  /// Creates Lottie-powered liquid background
  static Widget buildLottieGlassBackground({
    required Widget child,
    String? lottieAsset,
    BoxFit fit = BoxFit.cover,
    double opacity = 0.3,
  }) {
    if (lottieAsset == null) return child;

    return Stack(
      children: [
        Positioned.fill(
          child: Opacity(
            opacity: opacity,
            child: Lottie.asset(lottieAsset, fit: fit, repeat: true),
          ),
        ),
        child,
      ],
    );
  }

  // Helper methods
  static Image _createParticleImage(Color color, double size) {
    // This would create a simple particle image programmatically
    // In a real implementation, you'd create this using Canvas or load from assets
    return Image.asset('assets/particle.png'); // Placeholder
  }

  static TickerProvider _getTickerProvider() {
    // This should be provided by the calling widget
    // In practice, you'd pass this as a parameter
    throw UnimplementedError('TickerProvider must be provided');
  }
}

enum GlassType { frosted, crystal, liquid, neon }

/// Premium glass container with advanced third-party effects
class _PremiumGlassContainer extends StatefulWidget {
  final Widget child;
  final double borderRadius;
  final Color? backgroundColor;
  final bool isDark;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;
  final bool enableMorphing;
  final bool enableShimmer;
  final bool enableRipple;
  final bool enableHover;
  final bool enableParticles;
  final bool enableLottieBackground;
  final String? lottieAsset;
  final double blurIntensity;
  final double opacity;
  final List<BoxShadow>? customShadows;
  final VoidCallback? onTap;
  final GlassType glassType;

  const _PremiumGlassContainer({
    required this.child,
    this.borderRadius = 20.0,
    this.backgroundColor,
    this.isDark = false,
    this.padding,
    this.width,
    this.height,
    this.enableMorphing = true,
    this.enableShimmer = true,
    this.enableRipple = true,
    this.enableHover = true,
    this.enableParticles = true,
    this.enableLottieBackground = false,
    this.lottieAsset,
    this.blurIntensity = 20.0,
    this.opacity = 0.15,
    this.customShadows,
    this.onTap,
    this.glassType = GlassType.frosted,
  });

  @override
  State<_PremiumGlassContainer> createState() => _PremiumGlassContainerState();
}

class _PremiumGlassContainerState extends State<_PremiumGlassContainer>
    with TickerProviderStateMixin {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    Widget glassContainer = _buildGlassContainer();

    // Add Lottie background if enabled
    if (widget.enableLottieBackground && widget.lottieAsset != null) {
      glassContainer = EnhancedLiquidGlassEffects.buildLottieGlassBackground(
        lottieAsset: widget.lottieAsset,
        child: glassContainer,
      );
    }

    // Add particle effects if enabled
    if (widget.enableParticles) {
      glassContainer = EnhancedLiquidGlassEffects.buildParticleBackground(
        particleColor: widget.isDark ? Colors.white : Colors.blue,
        particleCount: 30,
        child: glassContainer,
      );
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) {
          setState(() => _isPressed = false);
          widget.onTap?.call();
        },
        onTapCancel: () => setState(() => _isPressed = false),
        child: glassContainer,
      ),
    );
  }

  Widget _buildGlassContainer() {
    return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          width: widget.width,
          height: widget.height,
          transform: Matrix4.identity()..scale(_isPressed ? 0.96 : 1.0),
          child: _buildGlassContent(),
        )
        .animate(
          onPlay: (controller) {
            if (_isHovered) {
              controller.forward();
            } else {
              controller.reverse();
            }
          },
        )
        .scale(
          duration: 300.ms,
          curve: Curves.easeOutCubic,
          begin: const Offset(1.0, 1.0),
          end: const Offset(1.05, 1.05),
        )
        .shimmer(duration: 2000.ms, color: Colors.white.withOpacity(0.3))
        .then()
        .shake(duration: 100.ms, hz: 2)
        .animate(
          onPlay: (controller) {
            if (widget.enableMorphing) {
              controller.repeat();
            }
          },
        )
        .custom(
          duration: EnhancedLiquidGlassEffects._morphDuration,
          curve: Curves.easeInOutSine,
          builder: (context, value, child) {
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..rotateX(math.sin(value * math.pi * 2) * 0.02)
                ..rotateY(math.cos(value * math.pi * 1.7) * 0.015),
              child: child,
            );
          },
        );
  }

  Widget _buildGlassContent() {
    final borderRadius = _calculateBorderRadius();

    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        boxShadow: _buildShadows(),
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: widget.blurIntensity,
            sigmaY: widget.blurIntensity,
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: _buildGradient(),
              border: _buildBorder(),
              borderRadius: borderRadius,
            ),
            child: Stack(
              children: [
                // Animated gradient overlay
                if (widget.glassType == GlassType.neon)
                  Positioned.fill(
                    child:
                        Container(
                              decoration: BoxDecoration(
                                borderRadius: borderRadius,
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.cyan.withOpacity(0.1),
                                    Colors.purple.withOpacity(0.1),
                                    Colors.pink.withOpacity(0.1),
                                  ],
                                ),
                              ),
                            )
                            .animate(
                              onPlay: (controller) => controller.repeat(),
                            )
                            .custom(
                              duration: 3000.ms,
                              builder: (context, value, child) {
                                return Transform.rotate(
                                  angle: value * math.pi * 2,
                                  child: child,
                                );
                              },
                            ),
                  ),

                // Shimmer overlay
                if (widget.enableShimmer)
                  Positioned.fill(
                    child: Shimmer.fromColors(
                      baseColor: Colors.transparent,
                      highlightColor: Colors.white.withOpacity(0.3),
                      period: const Duration(milliseconds: 2000),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: borderRadius,
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.white.withOpacity(0.1),
                              Colors.transparent,
                              Colors.white.withOpacity(0.1),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                // Content
                Padding(
                  padding: widget.padding ?? const EdgeInsets.all(16.0),
                  child: widget.child,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BorderRadius _calculateBorderRadius() {
    if (!widget.enableMorphing) {
      return BorderRadius.circular(widget.borderRadius);
    }

    // Use time-based morphing for smooth animation
    final time = DateTime.now().millisecondsSinceEpoch / 1000.0;
    final wave1 = math.sin(time * 0.8) * 0.2;
    final wave2 = math.sin(time * 0.8 + math.pi * 0.5) * 0.15;
    final wave3 = math.sin(time * 0.8 + math.pi) * 0.1;
    final wave4 = math.sin(time * 0.8 + math.pi * 1.5) * 0.12;

    return BorderRadius.only(
      topLeft: Radius.circular(widget.borderRadius * (1 + wave1)),
      topRight: Radius.circular(widget.borderRadius * (1 + wave2)),
      bottomRight: Radius.circular(widget.borderRadius * (1 + wave3)),
      bottomLeft: Radius.circular(widget.borderRadius * (1 + wave4)),
    );
  }

  List<BoxShadow> _buildShadows() {
    if (widget.customShadows != null) return widget.customShadows!;

    final baseOpacity = widget.isDark ? 0.4 : 0.15;
    final hoverMultiplier = _isHovered ? 2.0 : 1.0;
    final pressedMultiplier = _isPressed ? 0.5 : 1.0;

    return [
      BoxShadow(
        color: (widget.isDark ? Colors.black : Colors.grey.shade600)
            .withOpacity(baseOpacity * hoverMultiplier * pressedMultiplier),
        blurRadius: 25.0 * hoverMultiplier,
        offset: Offset(0, 8.0 * hoverMultiplier * pressedMultiplier),
        spreadRadius: _isPressed ? -2 : 3,
      ),
      if (_isHovered)
        BoxShadow(
          color:
              (widget.glassType == GlassType.neon
                      ? Colors.cyan
                      : Colors.blue.shade300)
                  .withOpacity(0.3),
          blurRadius: 30.0,
          spreadRadius: 5,
        ),
    ];
  }

  Gradient _buildGradient() {
    switch (widget.glassType) {
      case GlassType.crystal:
        return LinearGradient(
          colors: widget.isDark
              ? [Colors.white.withOpacity(0.2), Colors.white.withOpacity(0.05)]
              : [Colors.white.withOpacity(0.4), Colors.white.withOpacity(0.1)],
        );
      case GlassType.liquid:
        return LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue.withOpacity(0.2),
            Colors.purple.withOpacity(0.1),
            Colors.transparent,
          ],
        );
      case GlassType.neon:
        return LinearGradient(
          colors: [
            Colors.cyan.withOpacity(0.2),
            Colors.purple.withOpacity(0.15),
            Colors.pink.withOpacity(0.1),
          ],
        );
      case GlassType.frosted:
      default:
        return LinearGradient(
          colors: widget.isDark
              ? [Colors.white.withOpacity(0.1), Colors.white.withOpacity(0.05)]
              : [Colors.white.withOpacity(0.25), Colors.white.withOpacity(0.1)],
        );
    }
  }

  Border _buildBorder() {
    final opacity = _isHovered ? 0.6 : 0.3;
    final width = _isHovered ? 1.5 : 1.0;

    return Border.all(color: Colors.white.withOpacity(opacity), width: width);
  }
}

// Usage Examples:
class ExampleUsage extends StatelessWidget {
  const ExampleUsage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Premium Glass Container
            EnhancedLiquidGlassEffects.buildPremiumGlassContainer(
              width: 300,
              height: 200,
              isDark: true,
              glassType: GlassType.neon,
              enableParticles: true,
              child: EnhancedLiquidGlassEffects.buildShimmerText(
                text: 'Premium Glass Effect',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                isDark: true,
              ),
            ),

            const SizedBox(height: 40),

            // Glassmorphism Container
            EnhancedLiquidGlassEffects.buildGlassmorphismContainer(
              child: const Center(
                child: Text(
                  'Glassmorphism Effect',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
