import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Student Profile')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundColor: const Color(0xFF5D4037),
                child: const Text(
                  'KP',
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 16),
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
                minimumSize: const Size(double.infinity, 50),
              ),
              icon: const Icon(Icons.logout),
              label: const Text('Logout'),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
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

  const ProfileInfoTile({super.key, required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(color: Colors.brown, fontSize: 12)),
              Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xFF5D4037))),
            ],
          ),
        ],
      ),
    );
  }
}
