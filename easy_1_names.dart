import 'package:flutter/material.dart';

// Practical Easy 1:
// Create a List<String> of 10 fixed names and display them on screen using ListView.builder.

void main() {
  runApp(const Easy1NamesApp());
}

class Easy1NamesApp extends StatelessWidget {
  const Easy1NamesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Easy 1 - Fixed Names List',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const FixedNamesScreen(),
    );
  }
}

class FixedNamesScreen extends StatelessWidget {
  const FixedNamesScreen({super.key});

  final List<String> names = const [
    'Aarav Sharma',
    'Vivaan Patel',
    'Aditya Verma',
    'Vihaan Gupta',
    'Arjun Mehta',
    'Sai Joshi',
    'Reyansh Kapoor',
    'Ayaan Singh',
    'Krishna Nair',
    'Ishaan Bhatia',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Easy 1: 10 Fixed Names'),
      ),
      body: ListView.builder(
        itemCount: names.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              leading: CircleAvatar(
                child: Text('${index + 1}'),
              ),
              title: Text(
                names[index],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
      ),
    );
  }
}
