import 'package:flutter/material.dart';

// Practical Hard 1:
// Create a Multi-step Form Wizard (Step 1: Personal Info, Step 2: Address, Step 3: Review) with Navigator allowing forward/backward movement, validating each step.

void main() {
  runApp(const Hard1StepWizardApp());
}

class Hard1StepWizardApp extends StatelessWidget {
  const Hard1StepWizardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hard 1 - Multi-step Form Wizard',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Step1PersonalInfoScreen(),
    );
  }
}

class WizardData {
  static String name = '';
  static String email = '';
  static String city = '';
  static String pincode = '';
}

// Step 1 Screen
class Step1PersonalInfoScreen extends StatefulWidget {
  const Step1PersonalInfoScreen({super.key});

  @override
  State<Step1PersonalInfoScreen> createState() => _Step1PersonalInfoScreenState();
}

class _Step1PersonalInfoScreenState extends State<Step1PersonalInfoScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Step 1: Personal Info')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const LinearProgressIndicator(value: 0.33),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: WizardData.name,
                decoration: const InputDecoration(labelText: 'Name', border: OutlineInputBorder()),
                validator: (val) => val == null || val.trim().isEmpty ? 'Enter name' : null,
                onSaved: (val) => WizardData.name = val ?? '',
              ),
              const SizedBox(height: 15),
              TextFormField(
                initialValue: WizardData.email,
                decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
                validator: (val) => val == null || !val.contains('@') ? 'Enter valid email' : null,
                onSaved: (val) => WizardData.email = val ?? '',
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Step2AddressScreen()),
                    );
                  }
                },
                child: const Text('Next: Address ->'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Step 2 Screen
class Step2AddressScreen extends StatefulWidget {
  const Step2AddressScreen({super.key});

  @override
  State<Step2AddressScreen> createState() => _Step2AddressScreenState();
}

class _Step2AddressScreenState extends State<Step2AddressScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Step 2: Address Info')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const LinearProgressIndicator(value: 0.66),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: WizardData.city,
                decoration: const InputDecoration(labelText: 'City', border: OutlineInputBorder()),
                validator: (val) => val == null || val.trim().isEmpty ? 'Enter city' : null,
                onSaved: (val) => WizardData.city = val ?? '',
              ),
              const SizedBox(height: 15),
              TextFormField(
                initialValue: WizardData.pincode,
                decoration: const InputDecoration(labelText: 'Pincode', border: OutlineInputBorder()),
                validator: (val) => val == null || val.length < 6 ? 'Pincode must be 6 digits' : null,
                onSaved: (val) => WizardData.pincode = val ?? '',
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('<- Back'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Step3ReviewScreen()),
                        );
                      }
                    },
                    child: const Text('Next: Review ->'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Step 3 Screen
class Step3ReviewScreen extends StatelessWidget {
  const Step3ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Step 3: Review Details')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const LinearProgressIndicator(value: 1.0),
            const SizedBox(height: 20),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Name: ${WizardData.name}', style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 8),
                    Text('Email: ${WizardData.email}', style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 8),
                    Text('City: ${WizardData.city}', style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 8),
                    Text('Pincode: ${WizardData.pincode}', style: const TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('<- Back'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Form Submitted Successfully!')),
                    );
                  },
                  child: const Text('Submit Form'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
