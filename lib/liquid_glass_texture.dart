/// A comprehensive Flutter package providing beautiful liquid glass texture effects.
///
/// This package offers a complete suite of glass-morphism UI components including
/// buttons, cards, navigation bars, dialogs, and more with customizable blur,
/// transparency, and modern styling for Flutter applications.
///
/// ## Components Available:
///
/// ### Interactive Components
/// - [LiquidGlassButton] - Glass effect buttons with various styles
/// - [LiquidGlassFloatingActionButton] - FAB with glass morphism
/// - [LiquidGlassChip] - Selection chips with glass effect
///
/// ### Navigation Components
/// - [LiquidGlassBottomNavigationBar] - Bottom navigation with glass effect
/// - [LiquidGlassTabBar] - Tab bar with glass morphism
/// - [LiquidGlassAppBar] - App bar with glass background
///
/// ### Container Components
/// - [LiquidGlassCard] - Cards with glass morphism effect
/// - [LiquidGlassContainer] - Generic glass container
/// - [LiquidGlassDialog] - Dialogs with glass background
/// - [LiquidGlassSnackbar] - Snackbars with glass effect
///
/// ### Visual Components
/// - [LiquidGlassIcon] - Icons with glass morphism background
///
/// ### Theming & Utilities
/// - [LiquidGlassTheme] - Theme configuration for glass components
/// - [LiquidGlassColors] - Predefined color schemes for glass effects
/// - [LiquidGlassEffects] - Utility functions for glass effects
///
/// ## Example Usage:
///
/// ```dart
/// import 'package:liquid_glass_texture/liquid_glass_texture.dart';
///
/// // Basic glass button
/// LiquidGlassButton(
///   onPressed: () => print('Pressed!'),
///   child: Text('Glass Button'),
/// )
///
/// // Glass card with content
/// LiquidGlassCard(
///   child: Padding(
///     padding: EdgeInsets.all(16),
///     child: Text('Glass Card Content'),
///   ),
/// )
///
/// // Apply glass theme to entire app
/// MaterialApp(
///   theme: LiquidGlassTheme.lightTheme(),
///   home: MyHomePage(),
/// )
/// ```

library;

export 'src/components/liquid_glass_button.dart';
export 'src/components/liquid_glass_floating_action_button.dart';
export 'src/components/liquid_glass_bottom_navigation_bar.dart';
export 'src/components/liquid_glass_tab_bar.dart';
export 'src/components/liquid_glass_chip.dart';
export 'src/components/liquid_glass_snackbar.dart';
export 'src/components/liquid_glass_dialog.dart';
export 'src/components/liquid_glass_app_bar.dart';
export 'src/components/liquid_glass_card.dart';
export 'src/components/liquid_glass_icon.dart';
export 'src/components/liquid_glass_container.dart';
export 'src/themes/liquid_glass_theme.dart';
export 'src/utils/liquid_glass_colors.dart';
export 'src/utils/liquid_glass_effects.dart';
