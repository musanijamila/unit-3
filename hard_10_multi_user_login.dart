import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Practical Hard 10:
// Build a Multi-user Login System using Provider and Form validation together, where a List<User> is stored in Provider and the Login screen validates against that list.

void main() {
  runApp(const Hard10MultiUserApp());
}

class User {
  final String email;
  final String password;
  final String name;

  const User({required this.email, required this.password, required this.name});
}

class UserProvider extends ChangeNotifier {
  final List<User> _users = [
    const User(email: 'alice@example.com', password: 'password123', name: 'Alice Smith'),
    const User(email: 'bob@example.com', password: 'password456', name: 'Bob Johnson'),
    const User(email: 'charlie@example.com', password: 'password789', name: 'Charlie Brown'),
  ];

  User? _currentUser;

  List<User> get users => _users;
  User? get currentUser => _currentUser;

  bool validateAndLogin(String email, String password) {
    for (final u in _users) {
      if (u.email == email && u.password == password) {
        _currentUser = u;
        notifyListeners();
        return true;
      }
    }
    return false;
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }
}

class Hard10MultiUserApp extends StatelessWidget {
  const Hard10MultiUserApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hard 10 - Multi-user Login',
        theme: ThemeData(primarySwatch: Colors.indigo),
        home: const MultiUserAuthScreen(),
      ),
    );
  }
}

class MultiUserAuthScreen extends StatelessWidget {
  const MultiUserAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();

    if (userProvider.currentUser != null) {
      return DashboardScreen(user: userProvider.currentUser!);
    }

    return const MultiUserLoginScreen();
  }
}

class MultiUserLoginScreen extends StatefulWidget {
  const MultiUserLoginScreen({super.key});

  @override
  State<MultiUserLoginScreen> createState() => _MultiUserLoginScreenState();
}

class _MultiUserLoginScreenState extends State<MultiUserLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _errorText;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitLogin() {
    if (_formKey.currentState!.validate()) {
      final success = context.read<UserProvider>().validateAndLogin(
            _emailController.text.trim(),
            _passwordController.text.trim(),
          );
      if (!success) {
        setState(() {
          _errorText = 'Invalid email or password! Check registered user list below.';
        });
      } else {
        setState(() {
          _errorText = null;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final users = context.watch<UserProvider>().users;

    return Scaffold(
      appBar: AppBar(title: const Text('Hard 10: Multi-User Login')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.people, size: 70, color: Colors.indigo),
              const SizedBox(height: 15),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                validator: (val) => val == null || val.trim().isEmpty ? 'Enter email' : null,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
                validator: (val) => val == null || val.trim().isEmpty ? 'Enter password' : null,
              ),
              if (_errorText != null) ...[
                const SizedBox(height: 10),
                Text(
                  _errorText!,
                  style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ],
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitLogin,
                child: const Text('Login'),
              ),
              const SizedBox(height: 30),
              const Card(
                color: Colors.indigoAccent,
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    'Stored Users in Provider:',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              ...users.map(
                (u) => ListTile(
                  dense: true,
                  title: Text(u.name),
                  subtitle: Text('Email: ${u.email} | Pass: ${u.password}'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                  onTap: () {
                    _emailController.text = u.email;
                    _passwordController.text = u.password;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  final User user;

  const DashboardScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => context.read<UserProvider>().logout(),
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 40,
                child: Icon(Icons.person, size: 40),
              ),
              const SizedBox(height: 20),
              Text('Welcome, ${user.name}!', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text('Logged in as: ${user.email}', style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                icon: const Icon(Icons.logout),
                label: const Text('Logout'),
                onPressed: () => context.read<UserProvider>().logout(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
