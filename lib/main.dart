import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MAD Practical 1',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class Student {
  String name;
  int age;

  Student(this.name, this.age);

  String display() => "Student Name: $name, Age: $age";
}

int add(int x, int y) => x + y;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Builds the output lines using the same Dart concepts as the practical.
  List<String> _buildOutput() {
    final List<String> out = [];

    // 1. Variables and Data Types
    String name = "Rahul";
    int age = 20;
    double marks = 85.5;
    bool isStudent = true;
    out.add("Name: $name");
    out.add("Age: $age");
    out.add("Marks: $marks");
    out.add("Student: $isStudent");

    // 2. Operators
    int a = 10, b = 5;
    out.add("Addition: ${a + b}");
    out.add("Subtraction: ${a - b}");

    // 3. Decision Making
    out.add(marks >= 40 ? "Result: Pass" : "Result: Fail");

    // 4. For Loop
    for (int i = 1; i <= 5; i++) {
      out.add("For loop: $i");
    }

    // 5. While Loop
    int j = 1;
    while (j <= 3) {
      out.add("While loop: $j");
      j++;
    }

    // 6. Function
    out.add("Sum: ${add(10, 20)}");

    // 7. Class and Object
    out.add(Student("Rahul", 20).display());

    return out;
  }

  @override
  Widget build(BuildContext context) {
    final lines = _buildOutput();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Krima | 24AIML027'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: lines.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (_, i) => ListTile(
          dense: true,
          leading: CircleAvatar(radius: 14, child: Text('${i + 1}')),
          title: Text(lines[i]),
        ),
      ),
    );
  }
}
