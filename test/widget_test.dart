import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:student_companion_pr4/models/app_settings.dart';
import 'package:student_companion_pr4/main.dart';

void main() {
  test('AppSettings defaults', () {
    final s = AppSettings();
    expect(s.enrollmentNo, '24AIML027');
    expect(s.themeMode, ThemeMode.light);
    s.isDarkMode = true;
    expect(s.themeMode, ThemeMode.dark);
  });

  testWidgets('Splash opens Login', (tester) async {
    await tester.pumpWidget(const StudentCompanionApp());
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();
    expect(find.text('Welcome Back'), findsOneWidget);
  });
}
