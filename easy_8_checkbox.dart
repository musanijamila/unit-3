import 'package:flutter/material.dart';

// Practical Easy 8:
// Toggle a checkbox using setState() and display 'Checked'/'Unchecked' text based on its state.

void main() {
  runApp(const Easy8CheckboxApp());
}

class Easy8CheckboxApp extends StatelessWidget {
  const Easy8CheckboxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Easy 8 - Toggle Checkbox',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: const CheckboxToggleScreen(),
    );
  }
}

class CheckboxToggleScreen extends StatefulWidget {
  const CheckboxToggleScreen({super.key});

  @override
  State<CheckboxToggleScreen> createState() => _CheckboxToggleScreenState();
}

class _CheckboxToggleScreenState extends State<CheckboxToggleScreen> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Easy 8: Checkbox Toggle')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        _isChecked = value ?? false;
                      });
                    },
                  ),
                  const Text('Accept Terms & Conditions', style: TextStyle(fontSize: 18)),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: _isChecked ? Colors.green.shade100 : Colors.red.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _isChecked ? 'Checked' : 'Unchecked',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: _isChecked ? Colors.green.shade900 : Colors.red.shade900,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
