import 'package:flutter/material.dart';

// Practical Moderate 3:
// Pass data with navigation: send a Student object (name, roll no, marks) from HomeScreen to DetailScreen and display it.

void main() {
  runApp(const Mod3StudentApp());
}

class Student {
  final String name;
  final int rollNo;
  final double marks;

  const Student({required this.name, required this.rollNo, required this.marks});
}

class Mod3StudentApp extends StatelessWidget {
  const Mod3StudentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Moderate 3 - Pass Student Object',
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      home: const StudentHomeScreen(),
    );
  }
}

class StudentHomeScreen extends StatelessWidget {
  const StudentHomeScreen({super.key});

  final List<Student> students = const [
    Student(name: 'Rohan Sharma', rollNo: 101, marks: 88.5),
    Student(name: 'Priya Patel', rollNo: 102, marks: 92.0),
    Student(name: 'Amit Verma', rollNo: 103, marks: 79.5),
    Student(name: 'Sneha Gupta', rollNo: 104, marks: 95.0),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Moderate 3: Student List')),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          final student = students[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              leading: CircleAvatar(child: Text('${student.rollNo}')),
              title: Text(student.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Marks: ${student.marks}'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StudentDetailScreen(student: student),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class StudentDetailScreen extends StatelessWidget {
  final Student student;

  const StudentDetailScreen({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${student.name} Details')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: CircleAvatar(
                    radius: 40,
                    child: Icon(Icons.school, size: 40),
                  ),
                ),
                const SizedBox(height: 20),
                Text('Student Name: ${student.name}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const Divider(),
                Text('Roll Number: ${student.rollNo}', style: const TextStyle(fontSize: 16)),
                const Divider(),
                Text('Marks Scored: ${student.marks}%', style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Back to Student List'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
