import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Practical Hard 3:
// Build a Todo App using Riverpod where list management (add, remove, toggle complete) is done using StateNotifierProvider.

void main() {
  runApp(
    const ProviderScope(
      child: Hard3RiverpodApp(),
    ),
  );
}

class Todo {
  final String id;
  final String title;
  final bool isCompleted;

  Todo({required this.id, required this.title, this.isCompleted = false});

  Todo copyWith({String? id, String? title, bool? isCompleted}) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

class TodoListNotifier extends StateNotifier<List<Todo>> {
  TodoListNotifier()
      : super([
          Todo(id: '1', title: 'Learn Riverpod StateNotifier'),
          Todo(id: '2', title: 'Build Todo App', isCompleted: true),
        ]);

  void addTodo(String title) {
    state = [
      ...state,
      Todo(id: DateTime.now().toString(), title: title),
    ];
  }

  void toggleTodo(String id) {
    state = [
      for (final todo in state)
        if (todo.id == id) todo.copyWith(isCompleted: !todo.isCompleted) else todo,
    ];
  }

  void removeTodo(String id) {
    state = state.where((todo) => todo.id != id).toList();
  }
}

final todoListProvider = StateNotifierProvider<TodoListNotifier, List<Todo>>((ref) {
  return TodoListNotifier();
});

class Hard3RiverpodApp extends StatelessWidget {
  const Hard3RiverpodApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hard 3 - Riverpod Todo App',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const TodoRiverpodScreen(),
    );
  }
}

class TodoRiverpodScreen extends ConsumerStatefulWidget {
  const TodoRiverpodScreen({super.key});

  @override
  ConsumerState<TodoRiverpodScreen> createState() => _TodoRiverpodScreenState();
}

class _TodoRiverpodScreenState extends ConsumerState<TodoRiverpodScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final todos = ref.watch(todoListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Hard 3: Riverpod StateNotifier Todo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'New Task',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    if (_controller.text.trim().isNotEmpty) {
                      ref.read(todoListProvider.notifier).addTodo(_controller.text.trim());
                      _controller.clear();
                    }
                  },
                  child: const Text('Add'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: todos.isEmpty
                  ? const Center(child: Text('No Tasks'))
                  : ListView.builder(
                      itemCount: todos.length,
                      itemBuilder: (context, index) {
                        final todo = todos[index];
                        return Card(
                          child: ListTile(
                            leading: Checkbox(
                              value: todo.isCompleted,
                              onChanged: (_) {
                                ref.read(todoListProvider.notifier).toggleTodo(todo.id);
                              },
                            ),
                            title: Text(
                              todo.title,
                              style: TextStyle(
                                decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
                              ),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                ref.read(todoListProvider.notifier).removeTodo(todo.id);
                              },
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
