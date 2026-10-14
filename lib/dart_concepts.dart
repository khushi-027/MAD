// Practical 1 - Dart programming concepts (console version)
// Run: dart run lib/dart_concepts.dart

void main() {
  // 1. Variables and Data Types
  String name = "Rahul";
  int age = 20;
  double marks = 85.5;
  bool isStudent = true;
  print("Name: $name");
  print("Age: $age");
  print("Marks: $marks");
  print("Student: $isStudent");

  // 2. Operators
  int a = 10, b = 5;
  print("Addition: ${a + b}");
  print("Subtraction: ${a - b}");

  // 3. Decision Making
  if (marks >= 40) {
    print("Result: Pass");
  } else {
    print("Result: Fail");
  }

  // 4. For Loop
  for (int i = 1; i <= 5; i++) {
    print(i);
  }

  // 5. While Loop
  int i = 1;
  while (i <= 3) {
    print(i);
    i++;
  }

  // 6. Function
  print("Sum: ${add(10, 20)}");

  // 7. Class and Object
  Student s = Student("Rahul", 20);
  s.display();
}

// Function
int add(int x, int y) {
  return x + y;
}

// Class
class Student {
  String name;
  int age;

  Student(this.name, this.age);

  void display() {
    print("Student Name: $name");
    print("Student Age: $age");
  }
}
