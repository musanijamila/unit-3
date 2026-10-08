import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Practical Hard 7:
// Build a Dark Mode / Light Mode Theme Switcher using Provider that applies across the entire app.

void main() {
  runApp(const Hard7ThemeApp());
}

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    _themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class Hard7ThemeApp extends StatelessWidget {
  const Hard7ThemeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Hard 7 - Theme Switcher',
            theme: ThemeData.light(useMaterial3: true),
            darkTheme: ThemeData.dark(useMaterial3: true),
            themeMode: themeProvider.themeMode,
            home: const ThemeSwitcherScreen(),
          );
        },
      ),
    );
  }
}

class ThemeSwitcherScreen extends StatelessWidget {
  const ThemeSwitcherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hard 7: App Theme Switcher'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                size: 80,
                color: themeProvider.isDarkMode ? Colors.yellow : Colors.orange,
              ),
              const SizedBox(height: 20),
              Text(
                themeProvider.isDarkMode ? 'Dark Mode Active' : 'Light Mode Active',
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Light', style: TextStyle(fontSize: 16)),
                  Switch(
                    value: themeProvider.isDarkMode,
                    onChanged: (isOn) {
                      context.read<ThemeProvider>().toggleTheme(isOn);
                    },
                  ),
                  const Text('Dark', style: TextStyle(fontSize: 16)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
