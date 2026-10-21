import 'package:flutter/material.dart';
import 'models/app_settings.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/attendance_screen.dart';
import 'screens/timetable_screen.dart';
import 'screens/assignments_screen.dart';
import 'screens/notifications_screen.dart';
import 'screens/faculty_screen.dart';
import 'screens/event_gallery_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/notes_tasks_screen.dart';

void main() {
  runApp(const StudentCompanionApp());
}

/// Practical 4: StudentCompanionApp is now a StatefulWidget.
///
/// It owns a single [AppSettings] instance -- the app's Application State.
/// That instance is passed down to any screen that needs to read or change
/// it (Dashboard, Profile, Notifications, Settings). When a screen changes a
/// value it calls [_updateSettings], which runs `setState()` here, so the
/// whole widget tree (including the theme) rebuilds and every screen shows
/// the change immediately -- without restarting the app.
class StudentCompanionApp extends StatefulWidget {
  const StudentCompanionApp({super.key});

  @override
  State<StudentCompanionApp> createState() => _StudentCompanionAppState();
}

class _StudentCompanionAppState extends State<StudentCompanionApp> {
  final AppSettings settings = AppSettings();

  // Passed to every screen that can mutate settings. Screens update the
  // shared AppSettings object directly, then call this to trigger a rebuild.
  void _updateSettings() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Student Companion',
      debugShowCheckedModeBanner: false,
      themeMode: settings.themeMode,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        // Theme updated to Brown, Cream, and White
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF5D4037), // Rich Brown
          brightness: Brightness.light,
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
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF5D4037),
          brightness: Brightness.dark,
          primary: const Color(0xFFD7CCC8),
          secondary: const Color(0xFF8D6E63),
        ),
        scaffoldBackgroundColor: const Color(0xFF1C1B1A),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2A211D),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        cardTheme: const CardThemeData(
          color: Color(0xFF2A211D),
          elevation: 3,
          margin: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegistrationScreen(),
        '/dashboard': (context) => DashboardScreen(settings: settings),
        '/profile': (context) => ProfileScreen(settings: settings),
        '/attendance': (context) => const AttendanceScreen(),
        '/timetable': (context) => const TimetableScreen(),
        '/assignments': (context) => const AssignmentsScreen(),
        '/notifications': (context) => NotificationsScreen(settings: settings),
        '/faculty': (context) => const FacultyScreen(),
        '/events': (context) => const EventGalleryScreen(),
        '/notes': (context) => const NotesTasksScreen(),
        '/settings': (context) => SettingsScreen(
              settings: settings,
              onSettingsChanged: _updateSettings,
            ),
      },
    );
  }
}
