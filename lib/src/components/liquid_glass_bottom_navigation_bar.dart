import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math' as math;

/// A bottom navigation bar with glass-morphism effects and fluid animations.
///
/// This widget creates a modern, glass-like bottom navigation bar featuring:
/// - Smooth item transitions with elastic animations
/// - Liquid flow background effects
/// - Glossy highlights and shadows
/// - Customizable colors and elevation
/// - Optional haptic feedback
/// - Animated selection indicator
///
/// Example:
/// ```dart
/// LiquidGlassBottomNavigationBar(
///   items: [
///     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
///     BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
///   ],
///   currentIndex: 0,
///   onTap: (index) => setState(() => _currentIndex = index),
/// )
/// ```
class LiquidGlassBottomNavigationBar extends StatefulWidget {
  /// The list of items to display in the navigation bar.
  final List<BottomNavigationBarItem> items;
  
  /// The index of the currently selected item.
  final int currentIndex;
  
  /// Callback function when an item is tapped.
  final ValueChanged<int>? onTap;
  
  /// The background color of the navigation bar.
  /// If null, uses a glass effect with theme-appropriate colors.
  final Color? backgroundColor;
  
  /// The color of the selected item.
  /// If null, uses the primary color from the theme.
  final Color? selectedItemColor;
  
  /// The color of unselected items.
  /// If null, uses a muted version of the selected color.
  final Color? unselectedItemColor;
  
  /// The elevation of the navigation bar.
  /// Controls the intensity of the shadow effect.
  final double? elevation;
  
  /// Whether to show labels for the navigation items.
  final bool showLabels;
  
  /// Whether to enable haptic feedback when items are tapped.
  final bool enableHapticFeedback;
  
  /// The duration of animations when switching between items.
  final Duration animationDuration;

  /// Creates a new [LiquidGlassBottomNavigationBar].
  ///
  /// The [items] parameter is required and specifies the navigation items to display.
  /// The [currentIndex] parameter determines which item is currently selected.
  /// The [onTap] parameter provides a callback for item selection events.
  /// The [backgroundColor] parameter sets the background color of the bar.
  /// The [selectedItemColor] parameter sets the color of the selected item.
  /// The [unselectedItemColor] parameter sets the color of unselected items.
  /// The [elevation] parameter controls the shadow intensity.
  /// The [showLabels] parameter determines if item labels are visible.
  /// The [enableHapticFeedback] parameter controls haptic feedback on tap.
  /// The [animationDuration] parameter sets the duration of transition animations.
  const LiquidGlassBottomNavigationBar({
    Key? key,
    required this.items,
    required this.currentIndex,
    this.onTap,
    this.backgroundColor,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.elevation = 8.0,
    this.showLabels = true,
    this.enableHapticFeedback = true,
    this.animationDuration = const Duration(milliseconds: 300),
  }) : super(key: key);

  @override
  State<LiquidGlassBottomNavigationBar> createState() =>
      _LiquidGlassBottomNavigationBarState();
}

class _LiquidGlassBottomNavigationBarState
    extends State<LiquidGlassBottomNavigationBar>
    with TickerProviderStateMixin {
  late AnimationController _indicatorController;
  late Animation<double> _indicatorAnimation;
  late AnimationController _glowController;
  late Animation<double> _glowAnimation;
  late AnimationController _bounceController;
  late Animation<double> _bounceAnimation;
  late List<AnimationController> _itemControllers;
  late List<Animation<double>> _itemAnimations;

  @override
  void initState() {
    super.initState();
    
    _indicatorController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _indicatorAnimation = CurvedAnimation(
      parent: _indicatorController,
      curve: Curves.elasticOut,
    );

    _glowController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _glowAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );

    _bounceController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _bounceAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _bounceController, curve: Curves.elasticOut),
    );

    // Individual item animations
    _itemControllers = List.generate(
      widget.items.length,
      (index) => AnimationController(
        duration: Duration(milliseconds: 150 + (index * 50)),
        vsync: this,
      ),
    );
    
    _itemAnimations = _itemControllers.map((controller) =>
      Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.elasticOut),
      ),
    ).toList();

    _indicatorController.forward();
    
    // Stagger item animations
    for (int i = 0; i < _itemControllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 100), () {
        if (mounted) _itemControllers[i].forward();
      });
    }
  }

  @override
  void didUpdateWidget(LiquidGlassBottomNavigationBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      _indicatorController.reset();
      _indicatorController.forward();
      _bounceController.forward().then((_) => _bounceController.reverse());
      
      if (widget.enableHapticFeedback) {
        // HapticFeedback.lightImpact(); // Uncomment if you want haptic feedback
      }
    }
  }

  @override
  void dispose() {
    _indicatorController.dispose();
    _glowController.dispose();
    _bounceController.dispose();
    for (var controller in _itemControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final bottomPadding = mediaQuery.padding.bottom;

    // Improved responsive sizing with better overflow handling
    final dimensions = _calculateDimensions(screenWidth, widget.items.length);
    
    final selectedColor = widget.selectedItemColor ?? theme.primaryColor;
    final unselectedColor =
        widget.unselectedItemColor ??
        (isDark ? Colors.grey[400] : Colors.grey[600]);

    return Container(
      margin: EdgeInsets.only(
        left: dimensions.horizontalMargin,
        right: dimensions.horizontalMargin,
        bottom: math.max(bottomPadding > 0 ? 8 : 16, 8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(dimensions.borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
          child: Container(
            height: dimensions.navHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(dimensions.borderRadius),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: _getGradientColors(isDark),
                stops: const [0.0, 0.5, 1.0],
              ),
              border: Border.all(
                color: isDark
                    ? Colors.white.withOpacity(0.12)
                    : Colors.white.withOpacity(0.35),
                width: 1.2,
              ),
              boxShadow: _getBoxShadows(isDark),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Animated liquid background indicator
                AnimatedBuilder(
                  animation: _indicatorAnimation,
                  builder: (context, child) {
                    return Positioned(
                      left: _getIndicatorPosition(dimensions),
                      top: 6,
                      child: AnimatedContainer(
                        duration: widget.animationDuration,
                        curve: Curves.elasticOut,
                        width: dimensions.itemWidth,
                        height: dimensions.navHeight - 12,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(dimensions.borderRadius - 8),
                          gradient: RadialGradient(
                            center: Alignment.center,
                            radius: 1.5,
                            colors: [
                              selectedColor.withOpacity(0.2),
                              selectedColor.withOpacity(0.12),
                              selectedColor.withOpacity(0.06),
                              Colors.transparent,
                            ],
                            stops: const [0.0, 0.4, 0.7, 1.0],
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(dimensions.borderRadius - 8),
                            border: Border.all(
                              color: selectedColor.withOpacity(0.3),
                              width: 0.5,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),

                // Enhanced glossy highlight with animation
                AnimatedBuilder(
                  animation: _glowAnimation,
                  builder: (context, child) {
                    return Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      height: dimensions.navHeight * 0.5,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(dimensions.borderRadius),
                          ),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.white.withOpacity(
                                (isDark ? 0.1 : 0.25) * _glowAnimation.value,
                              ),
                              Colors.white.withOpacity(
                                (isDark ? 0.05 : 0.15) * _glowAnimation.value,
                              ),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),

                // Navigation items with proper spacing
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: dimensions.itemPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: widget.items.asMap().entries.map((entry) {
                      final index = entry.key;
                      final item = entry.value;
                      final isSelected = index == widget.currentIndex;

                      return AnimatedBuilder(
                        animation: _itemAnimations[index],
                        builder: (context, child) {
                          return Transform.translate(
                            offset: Offset(0, 20 * (1 - _itemAnimations[index].value)),
                            child: Opacity(
                              opacity: _itemAnimations[index].value,
                              child: _buildNavItem(
                                item: item,
                                index: index,
                                isSelected: isSelected,
                                selectedColor: selectedColor!,
                                unselectedColor: unselectedColor!,
                                dimensions: dimensions,
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),

                // Floating particles effect for selected item
                if (widget.currentIndex >= 0 && widget.currentIndex < widget.items.length)
                  Positioned(
                    left: _getIndicatorPosition(dimensions) + dimensions.itemWidth / 2 - 20,
                    top: 15,
                    child: AnimatedBuilder(
                      animation: _glowAnimation,
                      builder: (context, child) {
                        return CustomPaint(
                          size: const Size(40, 40),
                          painter: ParticlePainter(
                            progress: _glowAnimation.value,
                            color: selectedColor,
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required BottomNavigationBarItem item,
    required int index,
    required bool isSelected,
    required Color selectedColor,
    required Color unselectedColor,
    required NavigationDimensions dimensions,
  }) {
    return GestureDetector(
      onTap: () => widget.onTap?.call(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedBuilder(
        animation: isSelected ? _bounceAnimation : 
                   const AlwaysStoppedAnimation(1.0),
        builder: (context, child) {
          return Transform.scale(
            scale: isSelected ? _bounceAnimation.value : 1.0,
            child: Container(
              width: dimensions.itemWidth,
              height: dimensions.navHeight - 12,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Enhanced glow effect
                  if (isSelected)
                    AnimatedBuilder(
                      animation: _glowAnimation,
                      builder: (context, child) {
                        return Container(
                          width: dimensions.iconSize + 20,
                          height: dimensions.iconSize + 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: selectedColor.withOpacity(
                                  0.4 * _glowAnimation.value,
                                ),
                                blurRadius: 16,
                                spreadRadius: 4,
                              ),
                              BoxShadow(
                                color: selectedColor.withOpacity(
                                  0.2 * _glowAnimation.value,
                                ),
                                blurRadius: 8,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                        );
                      },
                    ),

                  // Content with improved layout
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Icon with enhanced animation
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeInOutCubic,
                        padding: EdgeInsets.all(isSelected ? 12 : 8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isSelected
                              ? selectedColor.withOpacity(0.15)
                              : Colors.transparent,
                          border: isSelected
                              ? Border.all(
                                  color: selectedColor.withOpacity(0.3),
                                  width: 1,
                                )
                              : null,
                        ),
                        child: Icon(
                          (item.icon as Icon).icon,
                          size: dimensions.iconSize,
                          color: isSelected ? selectedColor : unselectedColor,
                        ),
                      ),

                      // Label with better spacing and overflow handling
                      if (widget.showLabels && item.label != null && item.label!.isNotEmpty) ...[
                        SizedBox(height: dimensions.labelSpacing),
                        AnimatedOpacity(
                          opacity: isSelected ? 1.0 : 0.7,
                          duration: const Duration(milliseconds: 200),
                          child: Container(
                            width: dimensions.itemWidth - 8,
                            child: Text(
                              item.label!,
                              style: TextStyle(
                                fontSize: dimensions.fontSize,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.w500,
                                color: isSelected ? selectedColor : unselectedColor,
                                letterSpacing: 0.3,
                                height: 1.0,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  NavigationDimensions _calculateDimensions(double screenWidth, int itemCount) {
    // Improved responsive calculations to prevent overflow
    final baseMargin = math.max(12.0, screenWidth * 0.04);
    final availableWidth = screenWidth - (baseMargin * 2);
    final minItemWidth = 60.0;
    final maxItemWidth = 120.0;
    
    double itemWidth = availableWidth / itemCount;
    itemWidth = math.max(minItemWidth, math.min(maxItemWidth, itemWidth));
    
    // Adjust margins if items would be too wide
    final totalItemsWidth = itemWidth * itemCount;
    final adjustedMargin = math.max(8.0, (screenWidth - totalItemsWidth) / 2 - 16);
    
    return NavigationDimensions(
      screenWidth: screenWidth,
      navHeight: _calculateNavHeight(screenWidth),
      iconSize: _calculateIconSize(screenWidth),
      fontSize: _calculateFontSize(screenWidth),
      horizontalMargin: adjustedMargin,
      itemWidth: itemWidth,
      itemPadding: 8.0,
      borderRadius: 28.0,
      labelSpacing: 4.0,
    );
  }

  double _calculateNavHeight(double screenWidth) {
    if (screenWidth < 360) return widget.showLabels ? 72 : 60;
    if (screenWidth < 400) return widget.showLabels ? 76 : 64;
    if (screenWidth < 500) return widget.showLabels ? 80 : 68;
    return widget.showLabels ? 84 : 72;
  }

  double _calculateIconSize(double screenWidth) {
    if (screenWidth < 360) return 20;
    if (screenWidth < 400) return 22;
    if (screenWidth < 500) return 24;
    return 26;
  }

  double _calculateFontSize(double screenWidth) {
    if (screenWidth < 360) return 9;
    if (screenWidth < 400) return 10;
    if (screenWidth < 500) return 11;
    return 12;
  }

  double _getIndicatorPosition(NavigationDimensions dimensions) {
    return dimensions.itemPadding + (widget.currentIndex * dimensions.itemWidth);
  }

  List<Color> _getGradientColors(bool isDark) {
    if (isDark) {
      return [
        Colors.white.withOpacity(0.1),
        Colors.white.withOpacity(0.05),
        Colors.white.withOpacity(0.02),
      ];
    } else {
      return [
        Colors.white.withOpacity(0.3),
        Colors.white.withOpacity(0.2),
        Colors.white.withOpacity(0.1),
      ];
    }
  }

  List<BoxShadow> _getBoxShadows(bool isDark) {
    return [
      BoxShadow(
        color: isDark
            ? Colors.black.withOpacity(0.4)
            : Colors.black.withOpacity(0.12),
        blurRadius: widget.elevation! * 2.5,
        offset: const Offset(0, 6),
        spreadRadius: 0,
      ),
      BoxShadow(
        color: isDark
            ? Colors.white.withOpacity(0.03)
            : Colors.white.withOpacity(0.6),
        blurRadius: 2,
        offset: const Offset(0, 1),
        spreadRadius: 0,
      ),
      BoxShadow(
        color: isDark
            ? Colors.black.withOpacity(0.2)
            : Colors.black.withOpacity(0.06),
        blurRadius: widget.elevation!,
        offset: const Offset(0, 2),
        spreadRadius: -1,
      ),
    ];
  }
}

class NavigationDimensions {
  final double screenWidth;
  final double navHeight;
  final double iconSize;
  final double fontSize;
  final double horizontalMargin;
  final double itemWidth;
  final double itemPadding;
  final double borderRadius;
  final double labelSpacing;

  NavigationDimensions({
    required this.screenWidth,
    required this.navHeight,
    required this.iconSize,
    required this.fontSize,
    required this.horizontalMargin,
    required this.itemWidth,
    required this.itemPadding,
    required this.borderRadius,
    required this.labelSpacing,
  });
}

class ParticlePainter extends CustomPainter {
  final double progress;
  final Color color;

  ParticlePainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.6 * progress)
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);
    
    // Draw floating particles
    for (int i = 0; i < 6; i++) {
      final angle = (i * math.pi * 2 / 6) + (progress * math.pi * 2);
      final radius = 15 + (5 * math.sin(progress * math.pi * 2));
      final particleSize = 2 + (1 * math.sin(progress * math.pi * 2 + i));
      
      final offset = Offset(
        center.dx + math.cos(angle) * radius,
        center.dy + math.sin(angle) * radius,
      );
      
      canvas.drawCircle(offset, particleSize, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}