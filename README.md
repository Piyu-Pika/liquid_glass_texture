# Liquid Glass Texture

A Flutter package providing beautiful liquid glass UI components inspired by iOS 2026 design language. Features glassmorphism effects, blur backgrounds, and smooth animations.

## Features

- 🌟 **Glassmorphism Design**: Beautiful glass-like components with blur effects
- 🎨 **iOS 2026 Inspired**: Modern design language with liquid glass aesthetics  
- 🌙 **Dark Mode Support**: Automatic adaptation to light and dark themes
- ⚡ **Smooth Animations**: Fluid transitions and interactive feedback
- 🔧 **Customizable**: Easy to customize colors, sizes, and effects
- 📱 **Complete Component Set**: All essential UI components included

## Components Included

- **LiquidGlassButton** - Glass-styled buttons with press animations
- **LiquidGlassFloatingActionButton** - Floating action buttons with glass effects
- **LiquidGlassBottomNavigationBar** - Glass bottom navigation with smooth selection
- **LiquidGlassTabBar** - Tab bars with liquid glass styling
- **LiquidGlassChip** - Chip components with glass morphism
- **LiquidGlassSnackBar** - Elegant snackbars with blur effects
- **LiquidGlassDialog** - Modal dialogs with glass styling
- **LiquidGlassAppBar** - App bars with liquid glass effects
- **LiquidGlassCard** - Cards with glassmorphism design
- **LiquidGlassIcon** - Icons with glass container styling
- **LiquidGlassContainer** - Base container with glass effects

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  liquid_glass_ui: ^1.0.0
```

Then run:

```bash
flutter pub get
```

## Usage

### Basic Setup

Import the package and apply the theme:

```dart
import 'package:flutter/material.dart';
import 'package:liquid_glass_texture/liquid_glass_texture.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: LiquidGlassTheme.lightTheme,
      darkTheme: LiquidGlassTheme.darkTheme,
      home: MyHomePage(),
    );
  }
}
```

### Using Components

#### Buttons

```dart
LiquidGlassButton(
  onPressed: () {
    // Handle button press
  },
  child: Text('Glass Button'),
)
```

#### Floating Action Button

```dart
LiquidGlassFloatingActionButton(
  onPressed: () {
    // Handle FAB press
  },
  child: Icon(Icons.add),
)
```

#### Bottom Navigation Bar

```dart
LiquidGlassBottomNavigationBar(
  currentIndex: _currentIndex,
  onTap: (index) {
    setState(() {
      _currentIndex = index;
    });
  },
  items: [
    BottomNavigationBarItem(
      icon: Icons.home,
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icons.search,
      label: 'Search',
    ),
    // Add more items...
  ],
)
```

#### Cards

```dart
LiquidGlassCard(
  child: Column(
    children: [
      Text('Glass Card'),
      Text('Beautiful glassmorphism effect'),
    ],
  ),
  onTap: () {
    // Handle card tap
  },
)
```

#### Dialogs

```dart
LiquidGlassDialog.show(
  context: context,
  title: 'Glass Dialog',
  content: Text('This is a beautiful glass dialog'),
  actions: [
    LiquidGlassButton(
      onPressed: () => Navigator.pop(context),
      child: Text('Close'),
    ),
  ],
)
```

#### Snackbars

```dart
LiquidGlassSnackBar.show(
  context: context,
  message: 'Glass snackbar message',
)
```

#### Icons

```dart
LiquidGlassIcon(
  icon: Icons.favorite,
  color: Colors.red,
  onTap: () {
    // Handle icon tap
  },
)
```

## Customization

### Colors

You can customize the glass effects using `LiquidGlassColors`:

```dart
LiquidGlassContainer(
  backgroundColor: LiquidGlassColors.primary.withOpacity(0.2),
  child: YourWidget(),
)
```

### Effects

Access glass effects utilities:

```dart
Container(
  decoration: LiquidGlassEffects.getGlassDecoration(
    borderRadius: 20.0,
    isDark: true,
  ),
  child: YourWidget(),
)
```

## Example

Check out the `/example` folder for a complete demo application showing all components in action.

## Requirements

- Flutter >= 3.0.0
- Dart >= 3.0.0

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Support

If you find this package helpful, please give it a ⭐ on GitHub and consider supporting the development.
