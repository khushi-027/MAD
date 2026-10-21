import 'package:flutter/material.dart';

/// Application State container for Practical 4.
///
/// Unlike Ephemeral State (a widget's own private `setState()` data, such as
/// text being typed into a field before it is saved), the values below are
/// Application State: they are needed across several screens (Dashboard,
/// Profile, Notifications, Settings), so a single shared instance is created
/// once in `main.dart` and passed down the widget tree. Any screen that
/// changes a value calls [onChanged] to notify the top-level State object,
/// which then calls its own `setState()` to rebuild the whole app.
class AppSettings {
  // ---- Student Profile Settings ----
  String name;
  String enrollmentNo;
  String department;

  // ---- Semester Selection (DropdownButton) ----
  String semester;
  static const List<String> semesters = [
    'Semester I',
    'Semester II',
    'Semester III',
    'Semester IV',
    'Semester V',
    'Semester VI',
    'Semester VII',
    'Semester VIII',
  ];

  // ---- Theme Selection: Light / Dark Mode (Switch) ----
  bool isDarkMode;

  // ---- Language Selection (Radio Button) ----
  String language;
  static const List<String> languages = ['English', 'Hindi', 'Gujarati'];

  // ---- Notification Preferences (Checkbox) ----
  Map<String, bool> notificationPrefs;
  static const List<String> notificationKeys = [
    'Assignment Alerts',
    'Examination Notifications',
    'Placement Updates',
    'Event Announcements',
  ];

  // ---- Course Preferences (Checkbox) ----
  Set<String> selectedCourses;
  static const List<String> availableCourses = [
    'Mobile Application Development',
    'Artificial Intelligence',
    'Database Management System',
    'Computer Networks',
  ];

  // ---- Extra preference: daily study goal (Slider) ----
  double dailyStudyHours;

  // ---- Dashboard Customization (Switch per module) ----
  Map<String, bool> dashboardVisibility;
  static const List<String> dashboardModules = [
    'Attendance',
    'Timetable',
    'Assignments',
    'Faculty',
    'Events',
    'Notifications',
    'Notes & Tasks',
  ];

  AppSettings({
    this.name = 'Krima Parmar',
    this.enrollmentNo = '24AIML027',
    this.department = 'Artificial Intelligence & Machine Learning',
    this.semester = 'Semester V',
    this.isDarkMode = false,
    this.language = 'English',
    Map<String, bool>? notificationPrefs,
    Set<String>? selectedCourses,
    this.dailyStudyHours = 3,
    Map<String, bool>? dashboardVisibility,
  })  : notificationPrefs = notificationPrefs ??
            {for (final k in notificationKeys) k: true},
        selectedCourses = selectedCourses ??
            {
              'Mobile Application Development',
              'Artificial Intelligence',
            },
        dashboardVisibility = dashboardVisibility ??
            {for (final m in dashboardModules) m: true};

  ThemeMode get themeMode => isDarkMode ? ThemeMode.dark : ThemeMode.light;
}
