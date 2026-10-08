import 'package:flutter/material.dart';

// Practical Hard 5:
// Create a layout where ListView.builder and GridView.builder can be toggled on the same screen using a button (same data, different view).

void main() {
  runApp(const Hard5ToggleViewApp());
}

class Hard5ToggleViewApp extends StatelessWidget {
  const Hard5ToggleViewApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hard 5 - Toggle List & Grid',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const ToggleViewScreen(),
    );
  }
}

class ToggleViewScreen extends StatefulWidget {
  const ToggleViewScreen({super.key});

  @override
  State<ToggleViewScreen> createState() => _ToggleViewScreenState();
}

class _ToggleViewScreenState extends State<ToggleViewScreen> {
  bool _isGridView = false;

  final List<Map<String, String>> items = List.generate(
    12,
    (i) => {'title': 'Item ${i + 1}', 'desc': 'Description for item ${i + 1}'},
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hard 5: Toggle List / Grid'),
        actions: [
          IconButton(
            icon: Icon(_isGridView ? Icons.view_list : Icons.grid_view),
            tooltip: _isGridView ? 'Switch to ListView' : 'Switch to GridView',
            onPressed: () {
              setState(() {
                _isGridView = !_isGridView;
              });
            },
          ),
        ],
      ),
      body: _isGridView ? _buildGridView() : _buildListView(),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Card(
          child: ListTile(
            leading: CircleAvatar(child: Text('${index + 1}')),
            title: Text(item['title']!, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(item['desc']!),
          ),
        );
      },
    );
  }

  Widget _buildGridView() {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.1,
      ),
      itemBuilder: (context, index) {
        final item = items[index];
        return Card(
          color: Colors.indigo.shade50,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(child: Text('${index + 1}')),
                const SizedBox(height: 8),
                Text(item['title']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(item['desc']!, style: const TextStyle(fontSize: 12), textAlign: TextAlign.center),
              ],
            ),
          ),
        );
      },
    );
  }
}
