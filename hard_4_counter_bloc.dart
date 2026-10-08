import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Practical Hard 4:
// Build a simple Counter App using the BLoC pattern (flutter_bloc) that handles Increment and Decrement Events.

void main() {
  runApp(const Hard4BlocApp());
}

// Events
abstract class CounterEvent {}

class IncrementEvent extends CounterEvent {}

class DecrementEvent extends CounterEvent {}

// BLoC
class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<IncrementEvent>((event, emit) => emit(state + 1));
    on<DecrementEvent>((event, emit) => emit(state - 1));
  }
}

class Hard4BlocApp extends StatelessWidget {
  const Hard4BlocApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hard 4 - Counter BLoC App',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: BlocProvider(
        create: (_) => CounterBloc(),
        child: const CounterBlocScreen(),
      ),
    );
  }
}

class CounterBlocScreen extends StatelessWidget {
  const CounterBlocScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hard 4: flutter_bloc Counter')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'BLoC State Value:',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10),
            BlocBuilder<CounterBloc, int>(
              builder: (context, state) {
                return Text(
                  '$state',
                  style: const TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                );
              },
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  heroTag: 'dec_bloc',
                  onPressed: () {
                    context.read<CounterBloc>().add(DecrementEvent());
                  },
                  tooltip: 'Decrement',
                  child: const Icon(Icons.remove),
                ),
                const SizedBox(width: 20),
                FloatingActionButton(
                  heroTag: 'inc_bloc',
                  onPressed: () {
                    context.read<CounterBloc>().add(IncrementEvent());
                  },
                  tooltip: 'Increment',
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
