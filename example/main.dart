import 'package:flutter/material.dart';
import 'package:liquid_glass_texture/liquid_glass_texture.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Liquid Glass UI Demo',
      theme: LiquidGlassTheme.darkTheme,
      // darkTheme: LiquidGlassTheme.darkTheme,
      home: const DemoPage(),
    );
  }
}

class DemoPage extends StatefulWidget {
  const DemoPage({Key? key}) : super(key: key);

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> with TickerProviderStateMixin {
  // int _currentIndex = 0;
  int _selectedIndex = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: LiquidGlassBottomNavigationBar(
      //   currentIndex: _selectedIndex,
      //   onTap: (index) => setState(() => _selectedIndex = index),

      //   items: [
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      //     BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.favorite),
      //       label: 'Favorites',
      //     ),
      //     BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      //   ],
      // ),
      drawer: LiquidGlassDrawer(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.transparent),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/avatar.png'),
                ),
                const SizedBox(height: 10),
                const Text(
                  'User Name',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                const Text(''),

                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text('Home'),
                  onTap: () => Navigator.of(context).pop(),
                ),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('Settings'),
                  onTap: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: Image.asset(
                'assets/image.png',
                fit: BoxFit.cover,
                color: Colors.black.withOpacity(0.5),
                colorBlendMode: BlendMode.darken,
              ),
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  EnhancedLiquidGlassAppBar(
                    automaticallyImplyLeading: false,
                    title: const Text('App Bar'),

                    // leading: Icon(Icons.menu),
                    actions: [Icon(Icons.search)],
                    enableMorphing: false,
                  ),
                  // App Bar Demo
                  LiquidGlassContainer(
                    child: const ListTile(
                      leading: IconButton(
                        icon: Icon(Icons.menu),
                        onPressed: Drawer.new, // No action for demo
                      ),
                      title: Text('Liquid Glass UI'),
                      trailing: Icon(Icons.settings),
                    ),
                    padding: const EdgeInsets.all(8),
                  ),

                  const SizedBox(height: 20),

                  // Buttons Demo
                  const Text(
                    'Buttons',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),

                  Row(
                    children: [
                      Expanded(
                        child: EnhancedLiquidGlassButton(
                          onPressed: () {
                            LiquidGlassSnackBar.show(
                              context: context,
                              message: 'Button pressed!',
                            );
                          },
                          child: const Text('Primary Button'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      LiquidGlassFloatingActionButton(
                        onPressed: () {},
                        child: const Icon(Icons.add),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Icons Demo
                  const Text(
                    'Icons',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      LiquidGlassIcon(icon: Icons.home, onTap: () {}),
                      LiquidGlassIcon(
                        icon: Icons.favorite,
                        color: Colors.red,
                        onTap: () {},
                      ),
                      LiquidGlassIcon(
                        icon: Icons.star,
                        color: Colors.amber,
                        onTap: () {},
                      ),
                      LiquidGlassIcon(icon: Icons.person, onTap: () {}),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Tabs Demo
                  const Text(
                    'Tabs',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),

                  LiquidGlassTabBar(
                    controller: _tabController,
                    tabs: const [
                      Tab(text: 'Home'),
                      Tab(text: 'Search'),
                      Tab(text: 'Profile'),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Chips Demo
                  const Text(
                    'Chips',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),

                  Wrap(
                    spacing: 10,
                    children: [
                      LiquidGlassChip(
                        label: const Text('Selected'),
                        isSelected: true,
                        onTap: () {},
                      ),
                      LiquidGlassChip(
                        label: const Text('Unselected'),
                        onTap: () {},
                      ),
                      LiquidGlassChip(
                        label: const Text('Another'),
                        onTap: () {},
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Cards Demo
                  const Text(
                    'Cards',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),

                  LiquidGlassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            LiquidGlassIcon(icon: Icons.dashboard, size: 20),
                            const SizedBox(width: 12),
                            const Text(
                              'Glass Card',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'This is a beautiful liquid glass card with blur effects and transparency.',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    onTap: () {
                      LiquidGlassDialog.show(
                        context: context,
                        title: 'Dialog Demo',
                        content: const Text(
                          'This is a liquid glass dialog with blur effects.',
                        ),
                        actions: [
                          EnhancedLiquidGlassButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('Close'),
                          ),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: 20),

                  // Additional Demo Cards
                  LiquidGlassCard(
                    child: Row(
                      children: [
                        LiquidGlassIcon(
                          icon: Icons.music_note,
                          color: Colors.purple,
                          borderRadius: 20,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Now Playing',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Liquid Glass Symphony',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            LiquidGlassIcon(
                              icon: Icons.skip_previous,
                              size: 20,
                              onTap: () {},
                            ),
                            const SizedBox(width: 8),
                            LiquidGlassIcon(
                              icon: Icons.play_arrow,
                              size: 20,
                              color: Colors.green,
                              onTap: () {},
                            ),
                            const SizedBox(width: 8),
                            LiquidGlassIcon(
                              icon: Icons.skip_next,
                              size: 20,
                              onTap: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Weather Card Demo
                  LiquidGlassCard(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Delhi, India',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'Partly Cloudy',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                LiquidGlassIcon(
                                  icon: Icons.wb_sunny,
                                  color: Colors.orange,
                                ),
                                const SizedBox(width: 12),
                                const Text(
                                  '28°C',
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildWeatherInfo('Humidity', '65%', Icons.opacity),
                            _buildWeatherInfo('Wind', '12 km/h', Icons.air),
                            _buildWeatherInfo(
                              'UV Index',
                              '6',
                              Icons.wb_sunny_outlined,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 100), // Space for bottom nav
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherInfo(String label, String value, IconData icon) {
    return Column(
      children: [
        LiquidGlassIcon(icon: icon, size: 18),
        const SizedBox(height: 8),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
      ],
    );
  }
}

class LiquidGlassDrawer extends StatelessWidget {
  final Widget? header;
  final List<Widget> children;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const LiquidGlassDrawer({
    Key? key,
    this.header,
    required this.children,
    this.borderRadius = 24.0,
    this.padding,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.transparent, // Fully transparent
      child: EnhancedLiquidGlassEffects.buildPremiumGlassContainer(
        borderRadius: borderRadius,
        backgroundColor: Colors.transparent, // No color, just blur
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        // margin parameter removed as it is not defined
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [if (header != null) header!, ...children],
        ),
      ),
    );
  }
}
