import 'package:flutter/material.dart';

// Practical Hard 9:
// Create Nested Navigation: each tab of a Bottom Navigation Bar has its own separate Navigator stack (for example, using IndexedStack).

void main() {
  runApp(const Hard9NestedNavApp());
}

class Hard9NestedNavApp extends StatelessWidget {
  const Hard9NestedNavApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hard 9 - Nested Navigation',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const MainBottomNavScreen(),
    );
  }
}

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  int _currentIndex = 0;

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  void _onTabTapped(int index) {
    if (index == _currentIndex) {
      // Pop to first route if user taps current active tab
      _navigatorKeys[index].currentState?.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          _buildTabNavigator(0, const HomeTabMainScreen()),
          _buildTabNavigator(1, const SearchTabMainScreen()),
          _buildTabNavigator(2, const ProfileTabMainScreen()),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildTabNavigator(int index, Widget rootScreen) {
    return Navigator(
      key: _navigatorKeys[index],
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (context) => rootScreen,
        );
      },
    );
  }
}

// Tab 1: Home
class HomeTabMainScreen extends StatelessWidget {
  const HomeTabMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Tab (Level 1)')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const DetailScreen(title: 'Home Detail (Level 2)')),
            );
          },
          child: const Text('Push Home Detail Screen'),
        ),
      ),
    );
  }
}

// Tab 2: Search
class SearchTabMainScreen extends StatelessWidget {
  const SearchTabMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Tab (Level 1)')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const DetailScreen(title: 'Search Result (Level 2)')),
            );
          },
          child: const Text('Push Search Detail Screen'),
        ),
      ),
    );
  }
}

// Tab 3: Profile
class ProfileTabMainScreen extends StatelessWidget {
  const ProfileTabMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile Tab (Level 1)')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const DetailScreen(title: 'Edit Profile (Level 2)')),
            );
          },
          child: const Text('Push Profile Detail Screen'),
        ),
      ),
    );
  }
}

// Shared Nested Detail Screen
class DetailScreen extends StatelessWidget {
  final String title;

  const DetailScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('You are in nested stack: $title', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Pop Back inside Tab'),
            ),
          ],
        ),
      ),
    );
  }
}
