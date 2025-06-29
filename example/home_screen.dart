import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    print('HomeScreen build called');
    final counter = ref.watch(counterPorvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          children: [
            Consumer(
              builder: (context, ref, child) {
                // This will rebuild only when the textProvider changes
                return Text(ref.watch(textProvider));
              },
              child: Text(ref.watch(textProvider)),
            ),
            Consumer(
              builder: (context, ref, child) {
                // This will rebuild only when the counterPorvider changes
                return Text('Counter: ${ref.watch(counterPorvider)}');
              },
              child: Text('Counter: $counter'),
            ),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Increment the counter when the button is pressed
                    ref.read(counterPorvider.notifier).increment();
                  },
                  child: const Text('Increment Counter'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Decrement the counter when the button is pressed
                    ref.read(counterPorvider.notifier).decrement();
                  },
                  child: const Text('Decrement Counter'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Reset the counter when the button is pressed
                    ref.read(counterPorvider.notifier).reset();
                  },
                  child: const Text('Reset Counter'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
