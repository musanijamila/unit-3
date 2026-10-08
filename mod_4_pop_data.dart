import 'package:flutter/material.dart';

// Practical Moderate 4:
// Send data back from DetailScreen to HomeScreen using Navigator.pop(context, data) and display it in a SnackBar.

void main() {
  runApp(const Mod4PopDataApp());
}

class Mod4PopDataApp extends StatelessWidget {
  const Mod4PopDataApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Moderate 4 - Return Data via Navigator.pop',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _returnedData;

  Future<void> _navigateAndGetResult() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const InputSelectionScreen()),
    );

    if (result != null && mounted) {
      setState(() {
        _returnedData = result.toString();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Returned Data: $result'),
          backgroundColor: Colors.teal,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Moderate 4: Pop Data Back')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _returnedData == null
                  ? 'No feedback returned yet.'
                  : 'Last Selection: $_returnedData',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _navigateAndGetResult,
              child: const Text('Select Option in DetailScreen'),
            ),
          ],
        ),
      ),
    );
  }
}

class InputSelectionScreen extends StatelessWidget {
  const InputSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> options = ['Feedback: Excellent', 'Feedback: Good', 'Feedback: Average', 'Feedback: Needs Improvement'];

    return Scaffold(
      appBar: AppBar(title: const Text('Select Feedback')),
      body: ListView.builder(
        itemCount: options.length,
        itemBuilder: (context, index) {
          final option = options[index];
          return ListTile(
            title: Text(option),
            trailing: const Icon(Icons.send),
            onTap: () {
              Navigator.pop(context, option);
            },
          );
        },
      ),
    );
  }
}
