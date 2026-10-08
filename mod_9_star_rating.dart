import 'package:flutter/material.dart';

// Practical Moderate 9:
// Build a star rating widget (1 to 5 stars) that updates the selected rating using setState().

void main() {
  runApp(const Mod9StarRatingApp());
}

class Mod9StarRatingApp extends StatelessWidget {
  const Mod9StarRatingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Moderate 9 - Star Rating Widget',
      theme: ThemeData(primarySwatch: Colors.amber),
      home: const StarRatingScreen(),
    );
  }
}

class StarRatingScreen extends StatefulWidget {
  const StarRatingScreen({super.key});

  @override
  State<StarRatingScreen> createState() => _StarRatingScreenState();
}

class _StarRatingScreenState extends State<StarRatingScreen> {
  int _currentRating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Moderate 9: Star Rating Widget')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Rate your experience:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                final starNumber = index + 1;
                return IconButton(
                  iconSize: 40,
                  icon: Icon(
                    starNumber <= _currentRating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                  ),
                  onPressed: () {
                    setState(() {
                      _currentRating = starNumber;
                    });
                  },
                );
              }),
            ),
            const SizedBox(height: 20),
            Text(
              _currentRating == 0
                  ? 'No rating selected'
                  : 'You rated: $_currentRating / 5 Stars',
              style: const TextStyle(fontSize: 18, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
