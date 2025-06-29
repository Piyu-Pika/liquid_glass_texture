import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:ui';
import '../utils/liquid_glass_effects.dart';
import 'liquid_glass_icon.dart';

class LiquidGlassTabBar extends StatefulWidget {
  final List<Tab> tabs;
  final TabController? controller;
  final ValueChanged<int>? onTap;
  final Color? selectedColor;
  final Color? unselectedColor;
  final double height;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final bool enableMorphing;
  final bool enableGlow;

  const LiquidGlassTabBar({
    super.key,
    required this.tabs,
    this.controller,
    this.onTap,
    this.selectedColor,
    this.unselectedColor,
    this.height = 56.0,
    this.padding,
    this.borderRadius = 16.0,
    this.enableMorphing = true,
    this.enableGlow = true,
  });

  @override
  State<LiquidGlassTabBar> createState() => _LiquidGlassTabBarState();
}

class _LiquidGlassTabBarState extends State<LiquidGlassTabBar>
    with TickerProviderStateMixin {
  late AnimationController _morphController;
  late AnimationController _selectionController;
  late AnimationController _glowController;

  late Animation<double> _morphAnimation;
  late Animation<double> _selectionAnimation;
  late Animation<double> _glowAnimation;

  int _selectedIndex = 0;
  int _previousIndex = 0;
  double _indicatorOffset = 0.0;
  double _indicatorWidth = 0.0;

  @override
  void initState() {
    super.initState();

    _morphController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    _selectionController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _glowController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _morphAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _morphController, curve: Curves.easeInOutSine),
    );

    _selectionAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _selectionController, curve: Curves.elasticOut),
    );

    _glowAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOutSine),
    );

    if (widget.enableMorphing) {
      _morphController.repeat();
    }

    if (widget.enableGlow) {
      _glowController.repeat(reverse: true);
    }

    // Listen to tab controller changes
    widget.controller?.addListener(_handleTabChange);

    // Initialize selection animation
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _selectionController.forward();
    });
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleTabChange);
    _morphController.dispose();
    _selectionController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  void _handleTabChange() {
    if (widget.controller != null) {
      final newIndex = widget.controller!.index;
      if (newIndex != _selectedIndex) {
        setState(() {
          _previousIndex = _selectedIndex;
          _selectedIndex = newIndex;
        });
        _selectionController.forward(from: 0.0);
      }
    }
  }

  void _handleTabTap(int index) {
    setState(() {
      _previousIndex = _selectedIndex;
      _selectedIndex = index;
    });
    _selectionController.forward(from: 0.0);
    widget.onTap?.call(index);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);

    return SafeArea(
      top: false,
      child: Container(
        margin: const EdgeInsets.all(16),
        height: widget.height,
        child: EnhancedLiquidGlassEffects.buildPremiumGlassContainer(
          isDark: isDark,
          borderRadius: widget.borderRadius,
          padding: widget.padding ?? const EdgeInsets.all(4),
          enableMorphing: widget.enableMorphing,
          enableShimmer: true,
          enableHover: true,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final tabWidth = (constraints.maxWidth - 8) / widget.tabs.length;

              return AnimatedBuilder(
                animation: Listenable.merge([
                  _morphAnimation,
                  _selectionAnimation,
                  _glowAnimation,
                ]),
                builder: (context, child) {
                  return Stack(
                    children: [
                      // Liquid selection indicator
                      _buildLiquidIndicator(
                        tabWidth: tabWidth,
                        isDark: isDark,
                        theme: theme,
                      ),

                      // Tab buttons
                      Row(
                        children: widget.tabs.asMap().entries.map((entry) {
                          final index = entry.key;
                          final tab = entry.value;
                          final isSelected = index == _selectedIndex;

                          return Expanded(
                            child: _buildTabButton(
                              tab: tab,
                              index: index,
                              isSelected: isSelected,
                              tabWidth: tabWidth,
                              isDark: isDark,
                              theme: theme,
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildLiquidIndicator({
    required double tabWidth,
    required bool isDark,
    required ThemeData theme,
  }) {
    // Liquid morphing calculations
    final morphValue = _morphAnimation.value;
    final selectionValue = _selectionAnimation.value;
    final glowValue = _glowAnimation.value;

    // Smooth transition between tabs
    final targetOffset = _selectedIndex * tabWidth;
    final currentOffset = _previousIndex * tabWidth;
    final animatedOffset =
        currentOffset + (targetOffset - currentOffset) * selectionValue;

    // Morphing width effect during transition
    final baseWidth = tabWidth - 8;
    final morphingWidth =
        baseWidth * (1.0 + (math.sin(selectionValue * math.pi) * 0.2));

    // Liquid deformation
    final bendIntensity = math.sin(morphValue * math.pi * 2) * 0.1;
    final stretchX = 1.0 + (math.sin(selectionValue * math.pi) * 0.05);
    final stretchY = 1.0 + (math.cos(selectionValue * math.pi * 2) * 0.03);

    return Positioned(
      left: animatedOffset + 4,
      top: 4,
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..scale(stretchX, stretchY)
          ..rotateZ(bendIntensity * 0.02),
        child: Container(
          width: morphingWidth,
          height: widget.height - 16,
          decoration: BoxDecoration(
            borderRadius: _createLiquidBorderRadius(morphValue),
            gradient: _createLiquidGradient(
              isDark: isDark,
              theme: theme,
              morphValue: morphValue,
              glowValue: glowValue,
            ),
            boxShadow: _createLiquidShadows(
              isDark: isDark,
              theme: theme,
              glowValue: glowValue,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: _createLiquidBorderRadius(morphValue),
                border: Border.all(
                  color: Colors.white.withOpacity(0.3 + (glowValue * 0.2)),
                  width: 1.0 + (glowValue * 0.5),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.15 + (glowValue * 0.1)),
                    Colors.white.withOpacity(0.05 + (glowValue * 0.05)),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  BorderRadius _createLiquidBorderRadius(double morphValue) {
    final baseRadius = 12.0;
    final wave1 = math.sin(morphValue * math.pi * 2) * 2.0;
    final wave2 = math.sin(morphValue * math.pi * 2 + math.pi * 0.5) * 1.5;
    final wave3 = math.sin(morphValue * math.pi * 2 + math.pi) * 1.0;
    final wave4 = math.sin(morphValue * math.pi * 2 + math.pi * 1.5) * 1.2;

    return BorderRadius.only(
      topLeft: Radius.circular(baseRadius + wave1),
      topRight: Radius.circular(baseRadius + wave2),
      bottomRight: Radius.circular(baseRadius + wave3),
      bottomLeft: Radius.circular(baseRadius + wave4),
    );
  }

  Gradient _createLiquidGradient({
    required bool isDark,
    required ThemeData theme,
    required double morphValue,
    required double glowValue,
  }) {
    final primaryColor = widget.selectedColor ?? theme.primaryColor;
    final intensity = 0.2 + (glowValue * 0.15);

    // Flowing gradient direction
    final offsetX = math.sin(morphValue * math.pi * 2) * 0.3;
    final offsetY = math.cos(morphValue * math.pi * 1.5) * 0.2;

    return LinearGradient(
      begin: Alignment(-0.8 + offsetX, -0.8 + offsetY),
      end: Alignment(0.8 - offsetX, 0.8 - offsetY),
      colors: [
        primaryColor.withOpacity(intensity),
        primaryColor.withOpacity(intensity * 0.7),
        primaryColor.withOpacity(intensity * 0.4),
        Colors.transparent,
      ],
      stops: const [0.0, 0.3, 0.7, 1.0],
    );
  }

  List<BoxShadow> _createLiquidShadows({
    required bool isDark,
    required ThemeData theme,
    required double glowValue,
  }) {
    final primaryColor = widget.selectedColor ?? theme.primaryColor;
    final glowIntensity = 0.3 + (glowValue * 0.4);

    return [
      // Elevated shadow
      BoxShadow(
        color: (isDark ? Colors.black : Colors.grey.shade400).withOpacity(0.3),
        blurRadius: 8 + (glowValue * 4),
        offset: Offset(0, 2 + (glowValue * 2)),
        spreadRadius: -1,
      ),
      // Glow effect
      BoxShadow(
        color: primaryColor.withOpacity(glowIntensity * 0.6),
        blurRadius: 12 + (glowValue * 8),
        offset: const Offset(0, 0),
        spreadRadius: 0,
      ),
      // Inner highlight
      BoxShadow(
        color: Colors.white.withOpacity(0.1 + (glowValue * 0.1)),
        blurRadius: 4,
        offset: const Offset(0, -1),
        spreadRadius: -2,
      ),
    ];
  }

  Widget _buildTabButton({
    required Tab tab,
    required int index,
    required bool isSelected,
    required double tabWidth,
    required bool isDark,
    required ThemeData theme,
  }) {
    final selectedColor = widget.selectedColor ?? theme.primaryColor;
    final unselectedColor =
        widget.unselectedColor ??
        (isDark ? Colors.grey[400] : Colors.grey[600]);

    return GestureDetector(
      onTap: () => _handleTabTap(index),
      child: Container(
        height: widget.height - 8,
        margin: const EdgeInsets.all(4),
        child: Center(
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 300),
            style: TextStyle(
              color: isSelected ? selectedColor : unselectedColor,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              fontSize: 14,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (tab.icon != null) ...[
                  Flexible(
                    child: _buildTabIcon(
                      tab,
                      isSelected,
                      selectedColor,
                      unselectedColor,
                    ),
                  ),
                  if (tab.text != null) const SizedBox(height: 2),
                ],
                if (tab.text != null)
                  Flexible(
                    child: Text(
                      tab.text!,
                      style: TextStyle(
                        color: isSelected ? selectedColor : unselectedColor,
                        fontWeight: isSelected
                            ? FontWeight.w700
                            : FontWeight.w500,
                        fontSize: 11,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabIcon(
    Tab tab,
    bool isSelected,
    Color? selectedColor,
    Color? unselectedColor,
  ) {
    if (tab.icon is Widget &&
        tab.icon.runtimeType.toString().contains('LiquidGlassIcon')) {
      return tab.icon!;
    } else if (tab.icon is Icon) {
      return LiquidGlassIcon(
        icon: (tab.icon as Icon).icon!,
        size: 20,
        color: isSelected ? selectedColor : unselectedColor,
        isSelected: isSelected,
      );
    } else {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        child: IconTheme(
          data: IconThemeData(
            color: isSelected ? selectedColor : unselectedColor,
            size: 20,
          ),
          child: tab.icon!,
        ),
      );
    }
  }
}
