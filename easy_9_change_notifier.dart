import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Practical Easy 9:
// Create a simple CounterModel using ChangeNotifier and display its value using a Consumer widget.

void main() {
  runApp(const Easy9NotifierApp());
}

class CounterModel extends ChangeNotifier {
  int _count = 0;
  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }

  void decrement() {
    _count--;
    notifyListeners();
  }
}

class Easy9NotifierApp extends StatelessWidget {
  const Easy9NotifierApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CounterModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Easy 9 - ChangeNotifier & Consumer',
        theme: ThemeData(primarySwatch: Colors.deepOrange),
        home: const CounterNotifierScreen(),
      ),
    );
  }
}

class CounterNotifierScreen extends StatelessWidget {
  const CounterNotifierScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Easy 9: Consumer with ChangeNotifier')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Value using Consumer:',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10),
            Consumer<CounterModel>(
              builder: (context, counterModel, child) {
                return Text(
                  '${counterModel.count}',
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange,
                  ),
                );
              },
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => context.read<CounterModel>().decrement(),
                  child: const Text('Decrement'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () => context.read<CounterModel>().increment(),
                  child: const Text('Increment'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
