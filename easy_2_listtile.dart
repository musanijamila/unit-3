import 'package:flutter/material.dart';

// Practical Easy 2:
// In ListView.builder, create a ListTile with an Icon and text for each item.

void main() {
  runApp(const Easy2ListTileApp());
}

class Easy2ListTileApp extends StatelessWidget {
  const Easy2ListTileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Easy 2 - ListTile with Icon',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const ListTileScreen(),
    );
  }
}

class ListTileItem {
  final String title;
  final String subtitle;
  final IconData icon;

  const ListTileItem({
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}

class ListTileScreen extends StatelessWidget {
  const ListTileScreen({super.key});

  final List<ListTileItem> items = const [
    ListTileItem(title: 'Home', subtitle: 'Go to dashboard', icon: Icons.home),
    ListTileItem(title: 'Profile', subtitle: 'View user details', icon: Icons.person),
    ListTileItem(title: 'Settings', subtitle: 'App preferences', icon: Icons.settings),
    ListTileItem(title: 'Notifications', subtitle: 'View all alerts', icon: Icons.notifications),
    ListTileItem(title: 'Favorites', subtitle: 'Saved items', icon: Icons.favorite),
    ListTileItem(title: 'Search', subtitle: 'Find items', icon: Icons.search),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Easy 2: ListTile with Icon'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              leading: Icon(item.icon, color: Colors.teal, size: 30),
              title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(item.subtitle),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            ),
          );
        },
      ),
    );
  }
}
