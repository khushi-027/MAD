import 'package:flutter_test/flutter_test.dart';
import 'package:student_companion_pr3/main.dart';

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
