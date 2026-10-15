import 'package:flutter/material.dart';
<<<<<<< HEAD
import '../models/app_settings.dart';

/// Practical 4: ProfileScreen reads the shared [AppSettings] instance, so
/// any edit made on the Settings screen (name, enrollment no., department,
/// semester) is reflected here immediately -- the same Application State
/// object is shared between both screens.
class ProfileScreen extends StatelessWidget {
  final AppSettings settings;

  const ProfileScreen({super.key, required this.settings});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final initials = settings.name.trim().isEmpty
        ? '?'
        : settings.name
              .trim()
              .split(RegExp(r'\s+'))
              .map((w) => w[0])
              .take(2)
              .join()
              .toUpperCase();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: 'Edit in Settings',
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          ),
        ],
      ),
=======

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Student Profile')),
>>>>>>> 06896c3daa9244bef5a9719c9b822d58d67eea3c
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Center(
              child: CircleAvatar(
                radius: 60,
<<<<<<< HEAD
                backgroundColor: cs.primary,
                child: Text(
                  initials,
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: cs.onPrimary,
                  ),
=======
                backgroundColor: const Color(0xFF5D4037),
                child: const Text(
                  'KP',
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),
>>>>>>> 06896c3daa9244bef5a9719c9b822d58d67eea3c
                ),
              ),
            ),
            const SizedBox(height: 16),
<<<<<<< HEAD
            Center(
              child: Text(
                settings.name,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: cs.onBackground,
                ),
              ),
            ),
            Center(
              child: Text(
                settings.department,
                style: TextStyle(color: cs.onBackground.withOpacity(0.78)),
              ),
            ),
            Divider(height: 40, color: cs.secondary),
            ProfileInfoTile(
              icon: Icons.badge,
              label: 'Enrollment No.',
              value: settings.enrollmentNo,
            ),
            ProfileInfoTile(
              icon: Icons.school,
              label: 'Semester',
              value: settings.semester,
            ),
            ProfileInfoTile(
              icon: Icons.percent,
              label: 'Attendance',
              value: '91%',
            ),
            ProfileInfoTile(
              icon: Icons.menu_book,
              label: 'Course Preferences',
              value: settings.selectedCourses.isEmpty
                  ? 'None selected'
                  : settings.selectedCourses.join(', '),
            ),
            ProfileInfoTile(
              icon: Icons.language,
              label: 'Language',
              value: settings.language,
            ),
            ProfileInfoTile(
              icon: settings.isDarkMode ? Icons.dark_mode : Icons.light_mode,
              label: 'Theme',
              value: settings.isDarkMode ? 'Dark' : 'Light',
            ),
            const SizedBox(height: 40),
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                foregroundColor: cs.error,
                side: BorderSide(color: cs.error),
=======
            const Center(
              child: Text('Krima Parmar', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF5D4037))),
            ),
            const Center(
              child: Text('artificial Intelligence & Machine Learning', style: TextStyle(color: Colors.brown)),
            ),
            const Divider(height: 40, color: Color(0xFF8D6E63)),
            const ProfileInfoTile(icon: Icons.badge, label: 'Student ID', value: '24AIML027'),
            const ProfileInfoTile(icon: Icons.school, label: 'Semester', value: 'V'),
            const ProfileInfoTile(icon: Icons.percent, label: 'Attendance', value: '91%'),
            const ProfileInfoTile(icon: Icons.menu_book, label: 'Subjects', value: 'MAD, DBMS, AI, CP'),
            const ProfileInfoTile(icon: Icons.email, label: 'Email', value: 'krima.parmar@university.edu'),
            const ProfileInfoTile(icon: Icons.phone, label: 'Phone', value: '+91 555-0199'),
            const SizedBox(height: 40),
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.red,
                side: const BorderSide(color: Colors.red),
>>>>>>> 06896c3daa9244bef5a9719c9b822d58d67eea3c
                minimumSize: const Size(double.infinity, 50),
              ),
              icon: const Icon(Icons.logout),
              label: const Text('Logout'),
              onPressed: () {
<<<<<<< HEAD
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login',
                  (route) => false,
                );
=======
                Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
>>>>>>> 06896c3daa9244bef5a9719c9b822d58d67eea3c
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileInfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

<<<<<<< HEAD
  const ProfileInfoTile({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });
=======
  const ProfileInfoTile({super.key, required this.icon, required this.label, required this.value});
>>>>>>> 06896c3daa9244bef5a9719c9b822d58d67eea3c

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
<<<<<<< HEAD
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Theme.of(
                      context,
                    ).colorScheme.onBackground.withOpacity(0.72),
                    fontSize: 12,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              ],
            ),
=======
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(color: Colors.brown, fontSize: 12)),
              Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xFF5D4037))),
            ],
>>>>>>> 06896c3daa9244bef5a9719c9b822d58d67eea3c
          ),
        ],
      ),
    );
  }
}
