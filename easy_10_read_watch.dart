import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Practical Easy 10:
// Create a small Provider example with two separate buttons showing the difference between context.read() and context.watch().

void main() {
  runApp(const Easy10ReadWatchApp());
}

class CounterModel extends ChangeNotifier {
  int _counter = 0;
  int get counter => _counter;

  void increment() {
    _counter++;
    notifyListeners();
  }
}

class Easy10ReadWatchApp extends StatelessWidget {
  const Easy10ReadWatchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CounterModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Easy 10 - read() vs watch()',
        theme: ThemeData(primarySwatch: Colors.cyan),
        home: const ReadWatchScreen(),
      ),
    );
  }
}

class ReadWatchScreen extends StatelessWidget {
  const ReadWatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Easy 10: context.read() vs context.watch()')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const DisplayWatchWidget(),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // context.read() is used inside callbacks (onPressed) to read & execute methods without rebuilding this button widget
                context.read<CounterModel>().increment();
              },
              child: const Text('Increment using context.read()'),
            ),
            const SizedBox(height: 20),
            const Card(
              color: Colors.cyanAccent,
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'Explanation:\n'
                  '• context.watch<T>() listens to changes and triggers rebuild whenever value changes.\n'
                  '• context.read<T>() reads T once without subscribing to updates, ideal inside event handlers (like onPressed).',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DisplayWatchWidget extends StatelessWidget {
  const DisplayWatchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // context.watch listens to model changes and rebuilds this widget automatically
    final count = context.watch<CounterModel>().counter;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.cyan.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const Text('Watched Count (rebuilds automatically):', style: TextStyle(fontSize: 16)),
          Text(
            '$count',
            style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.cyan),
          ),
        ],
      ),
    );
  }
}
