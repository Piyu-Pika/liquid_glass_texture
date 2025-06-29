import 'package:flutter/material.dart';
import 'package:glui/screens/home_screen.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'glui',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const HomeScreen(),
    );
  }
}
