import 'package:flutter/material.dart';

// Practical Hard 8:
// Pattern printing: take user input N and dynamically generate and display a pyramid pattern (of numbers) using a GridView or Column.

void main() {
  runApp(const Hard8PyramidApp());
}

class Hard8PyramidApp extends StatelessWidget {
  const Hard8PyramidApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hard 8 - Number Pyramid Pattern',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const NumberPyramidScreen(),
    );
  }
}

class NumberPyramidScreen extends StatefulWidget {
  const NumberPyramidScreen({super.key});

  @override
  State<NumberPyramidScreen> createState() => _NumberPyramidScreenState();
}

class _NumberPyramidScreenState extends State<NumberPyramidScreen> {
  final TextEditingController _inputController = TextEditingController();
  int _n = 0;

  void _generatePyramid() {
    final val = int.tryParse(_inputController.text.trim());
    setState(() {
      _n = (val != null && val > 0) ? val : 0;
    });
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hard 8: Number Pyramid Pattern')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _inputController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Enter number N',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _generatePyramid,
                  child: const Text('Generate'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _n == 0
                  ? const Center(child: Text('Enter a valid positive integer N'))
                  : ListView.builder(
                      itemCount: _n,
                      itemBuilder: (context, index) {
                        final rowNumber = index + 1;
                        final numbers = List.generate(rowNumber, (i) => '${i + 1}').join(' ');
                        return Container(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          alignment: Alignment.center,
                          child: Text(
                            numbers,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 3,
                              color: Colors.deepPurple,
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
