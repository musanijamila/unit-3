import 'package:flutter/material.dart';

// Practical Moderate 10:
// Create a Flutter screen that prints a '*' pattern - entering a number in a TextField should display that many rows of stars (using setState()).

void main() {
  runApp(const Mod10StarPatternApp());
}

class Mod10StarPatternApp extends StatelessWidget {
  const Mod10StarPatternApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Moderate 10 - Star Pattern',
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      home: const StarPatternScreen(),
    );
  }
}

class StarPatternScreen extends StatefulWidget {
  const StarPatternScreen({super.key});

  @override
  State<StarPatternScreen> createState() => _StarPatternScreenState();
}

class _StarPatternScreenState extends State<StarPatternScreen> {
  final TextEditingController _numberController = TextEditingController();
  int _rows = 0;

  void _generatePattern() {
    final val = int.tryParse(_numberController.text.trim());
    setState(() {
      _rows = (val != null && val > 0) ? val : 0;
    });
  }

  @override
  void dispose() {
    _numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Moderate 10: Print Star Pattern')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _numberController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Enter number of rows N',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _generatePattern,
                  child: const Text('Generate'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _rows == 0
                  ? const Center(child: Text('Enter a positive number to print pattern.'))
                  : ListView.builder(
                      itemCount: _rows,
                      itemBuilder: (context, index) {
                        final starCount = index + 1;
                        final stars = '*' * starCount;
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                          child: Text(
                            stars,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 4,
                              color: Colors.deepOrange,
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
