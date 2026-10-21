import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:student_dash/main.dart';

void main() {
  testWidgets('Dashboard loads student profile test', (WidgetTester tester) async {
    // FIXED: Changed StudentDashboardApp() to StudentCompanionApp()
    await tester.pumpWidget(const StudentCompanionApp());

    // 1. Handle the Splash Screen delay (3 seconds) to let it route to Login
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    // 2. Bypass Login Screen by filling fields and tapping Login
    await tester.enterText(find.byType(TextFormField).at(0), 'student@university.edu');
    await tester.enterText(find.byType(TextFormField).at(1), 'password123');
    await tester.tap(find.text('Login'));
    
    // Settle animations after moving to Dashboard
    await tester.pumpAndSettle();

    // 3. Verify that the Dashboard content appears on screen
    // FIXED: Matched exact strings from your dashboard implementation
    expect(find.text('Dashboard'), findsOneWidget);
    expect(find.text('Hello, Krima'), findsOneWidget);
  });
}
