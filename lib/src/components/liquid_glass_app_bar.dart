import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math' as math;

class EnhancedLiquidGlassAppBar extends StatefulWidget
    implements PreferredSizeWidget {
  final Widget? title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool automaticallyImplyLeading;
  final double elevation;
  final Color? backgroundColor;
  final bool enableFloating;
  final bool enableMorphing;
  final double blurIntensity;

  const EnhancedLiquidGlassAppBar({
    super.key,
    this.title,
    this.actions,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.elevation = 0,
    this.backgroundColor,
    this.enableFloating = true,
    this.enableMorphing = true,
    this.blurIntensity = 15.0,
  });

  @override
  State<EnhancedLiquidGlassAppBar> createState() =>
      _EnhancedLiquidGlassAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(100);
}

class _EnhancedLiquidGlassAppBarState extends State<EnhancedLiquidGlassAppBar>
    with TickerProviderStateMixin {
  late AnimationController _floatingController;
  late AnimationController _morphController;
  late AnimationController _shimmerController;

  late Animation<double> _floatingAnimation;
  late Animation<double> _morphAnimation;
  late Animation<double> _shimmerAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _floatingController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    _morphController = AnimationController(
      duration: const Duration(milliseconds: 4000),
      vsync: this,
    );

    _shimmerController = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );

    _floatingAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _floatingController, curve: Curves.easeInOutSine),
    );

    _morphAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _morphController, curve: Curves.easeInOutSine),
    );

    _shimmerAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _shimmerController, curve: Curves.linear),
    );

    _slideAnimation =
        Tween<Offset>(
          begin: const Offset(0, -1),
          end: const Offset(0, 0),
        ).animate(
          CurvedAnimation(
            parent: _floatingController,
            curve: Curves.elasticOut,
          ),
        );

    if (widget.enableFloating) {
      _floatingController.repeat();
    }

    if (widget.enableMorphing) {
      _morphController.repeat();
    }

    _shimmerController.repeat();

    // Entrance animation
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        _floatingController.forward();
      }
    });
  }

  @override
  void dispose() {
    _floatingController.dispose();
    _morphController.dispose();
    _shimmerController.dispose();
    super.dispose();
  }

  BorderRadius _createMorphingBorder(double morphValue) {
    const baseRadius = 20.0;
    final variation = baseRadius * 0.3 * math.sin(morphValue * math.pi * 2);
    return BorderRadius.only(
      topLeft: Radius.circular(baseRadius + variation),
      topRight: Radius.circular(baseRadius - variation * 0.5),
      bottomLeft: Radius.circular(baseRadius - variation * 0.7),
      bottomRight: Radius.circular(baseRadius + variation * 0.3),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SlideTransition(
      position: _slideAnimation,
      child: AnimatedBuilder(
        animation: Listenable.merge([
          _floatingAnimation,
          _morphAnimation,
          _shimmerAnimation,
        ]),
        builder: (context, child) {
          final floatingOffset = widget.enableFloating
              ? math.sin(_floatingAnimation.value * math.pi * 2) * 2.0
              : 0.0;

          return Container(
            margin: EdgeInsets.fromLTRB(16, 44 + floatingOffset, 16, 0),
            decoration: BoxDecoration(
              borderRadius: widget.enableMorphing
                  ? _createMorphingBorder(_morphAnimation.value)
                  : BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: isDark
                      ? Colors.black.withOpacity(0.4)
                      : Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: Offset(0, 8 + floatingOffset),
                  spreadRadius: 2,
                ),
                BoxShadow(
                  color: isDark
                      ? Colors.white.withOpacity(0.1)
                      : Colors.white.withOpacity(0.8),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                  spreadRadius: -1,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: widget.enableMorphing
                  ? _createMorphingBorder(_morphAnimation.value)
                  : BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: widget.blurIntensity,
                  sigmaY: widget.blurIntensity,
                ),
                child: Container(
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(
                        -1.0 + _shimmerAnimation.value * 2,
                        -1.0,
                      ),
                      end: Alignment(1.0 - _shimmerAnimation.value * 2, 1.0),
                      colors: isDark
                          ? [
                              Colors.white.withOpacity(
                                0.15 +
                                    math.sin(
                                          _shimmerAnimation.value * math.pi * 2,
                                        ) *
                                        0.05,
                              ),
                              Colors.white.withOpacity(0.08),
                              Colors.white.withOpacity(0.05),
                              Colors.transparent,
                            ]
                          : [
                              Colors.white.withOpacity(
                                0.7 +
                                    math.sin(
                                          _shimmerAnimation.value * math.pi * 2,
                                        ) *
                                        0.1,
                              ),
                              Colors.white.withOpacity(0.4),
                              Colors.white.withOpacity(0.2),
                              Colors.transparent,
                            ],
                      stops: const [0.0, 0.3, 0.6, 1.0],
                    ),
                    border: Border.all(
                      color: isDark
                          ? Colors.white.withOpacity(0.25)
                          : Colors.white.withOpacity(0.6),
                      width: 1.5,
                    ),
                    borderRadius: widget.enableMorphing
                        ? _createMorphingBorder(_morphAnimation.value)
                        : BorderRadius.circular(20),
                  ),
                  child: Stack(
                    children: [
                      // Shimmer overlay
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              begin: Alignment(
                                -1.5 + _shimmerAnimation.value * 3,
                                -0.5,
                              ),
                              end: Alignment(
                                1.5 - _shimmerAnimation.value * 3,
                                0.5,
                              ),
                              colors: [
                                Colors.transparent,
                                Colors.white.withOpacity(0.15),
                                Colors.transparent,
                              ],
                              stops: const [0.0, 0.5, 1.0],
                            ),
                          ),
                        ),
                      ),

                      // App bar content
                      AppBar(
                        title: widget.title,
                        actions: widget.actions,
                        leading: widget.leading,
                        automaticallyImplyLeading:
                            widget.automaticallyImplyLeading,
                        elevation: 0,
                        backgroundColor: Colors.transparent,
                        titleTextStyle: TextStyle(
                          color: isDark ? Colors.white : Colors.black87,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        iconTheme: IconThemeData(
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
