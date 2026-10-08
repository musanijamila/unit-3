import 'package:flutter/material.dart';

// Practical Hard 6:
// Create a complex Form with a Dropdown, Checkbox, and TextFormField together, and use Form.save() to pass all values to a Summary screen via navigation.

void main() {
  runApp(const Hard6ComplexFormApp());
}

class FormDataModel {
  String name = '';
  String country = 'India';
  bool agreeTerms = false;
}

class Hard6ComplexFormApp extends StatelessWidget {
  const Hard6ComplexFormApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hard 6 - Complex Form',
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      home: const ComplexFormScreen(),
    );
  }
}

class ComplexFormScreen extends StatefulWidget {
  const ComplexFormScreen({super.key});

  @override
  State<ComplexFormScreen> createState() => _ComplexFormScreenState();
}

class _ComplexFormScreenState extends State<ComplexFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final FormDataModel _formData = FormDataModel();
  final List<String> countries = ['India', 'USA', 'UK', 'Canada', 'Australia'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hard 6: Complex Form')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'User Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (val) => val == null || val.trim().isEmpty ? 'Please enter name' : null,
                onSaved: (val) => _formData.name = val ?? '',
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                initialValue: _formData.country,
                decoration: const InputDecoration(
                  labelText: 'Select Country',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.flag),
                ),
                items: countries.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                onChanged: (val) {
                  if (val != null) setState(() => _formData.country = val);
                },
                onSaved: (val) => _formData.country = val ?? 'India',
              ),
              const SizedBox(height: 20),
              FormField<bool>(
                initialValue: _formData.agreeTerms,
                validator: (val) {
                  if (val != true) return 'You must accept the terms';
                  return null;
                },
                onSaved: (val) => _formData.agreeTerms = val ?? false,
                builder: (state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: state.value,
                            onChanged: (val) {
                              state.didChange(val);
                            },
                          ),
                          const Text('I accept the terms and conditions'),
                        ],
                      ),
                      if (state.hasError)
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Text(
                            state.errorText!,
                            style: const TextStyle(color: Colors.red, fontSize: 12),
                          ),
                        ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SummaryScreen(data: _formData),
                        ),
                      );
                    }
                  },
                  child: const Text('Save & Go to Summary'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SummaryScreen extends StatelessWidget {
  final FormDataModel data;

  const SummaryScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Summary Screen')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Form Summary:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const Divider(),
                Text('Name: ${data.name}', style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 10),
                Text('Country: ${data.country}', style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 10),
                Text('Terms Accepted: ${data.agreeTerms ? "Yes" : "No"}', style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Back to Form'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
