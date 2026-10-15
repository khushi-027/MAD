import 'package:flutter_test/flutter_test.dart';
<<<<<<< HEAD
import 'package:student_companion_pr3/main.dart';
=======
import 'package:student_companion_pr2/main.dart';
>>>>>>> ce26a43b9d3cb92d948e22bb1456f554e85929a2

void main() {
  testWidgets('Splash opens Login, empty login shows validation', (tester) async {
    await tester.pumpWidget(const StudentCompanionApp());
    expect(find.text('Smart Student Companion'), findsOneWidget);

    // Splash waits 3 seconds, then replaces itself with Login.
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();
    expect(find.text('Welcome Back'), findsOneWidget);

    await tester.tap(find.text('Login'));
    await tester.pump();
    expect(find.text('Enter a valid university email'), findsOneWidget);
  });
}
