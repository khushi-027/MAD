import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/profile_screen.dart';

void main() {
  runApp(const StudentCompanionApp());
}

class StudentCompanionApp extends StatelessWidget {
  const StudentCompanionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Student Companion',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        // Theme updated to Brown, Cream, and White
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF5D4037), // Rich Brown
          primary: const Color(0xFF5D4037),
          secondary: const Color(0xFF8D6E63), // Light Soft Brown
          surface: const Color(0xFFFFFDD0), // Warm Cream
        ),
        scaffoldBackgroundColor: const Color(0xFFFFFDD0), // Cream Base
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF5D4037),
          foregroundColor: Colors.white, // White text/icons
          elevation: 0,
        ),
        cardTheme: const CardThemeData(
          color: Colors.white, // Crisp White Cards
          elevation: 3,
          margin: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegistrationScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
    );
  }
}
