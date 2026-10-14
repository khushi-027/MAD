import 'package:flutter/material.dart';
import '../widgets/custom_widgets.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Theme matching brown tones assigned down directly onto elements grid array mapping parameters
    final List<Map<String, dynamic>> modules = [
  {'title': 'Attendance', 'icon': Icons.co_present, 'color': const Color(0xFF5D4037)},
  {'title': 'Timetable', 'icon': Icons.calendar_today, 'color': const Color(0xFF8D6E63)},
  {'title': 'Assignments', 'icon': Icons.assignment, 'color': const Color(0xFF5D4037)},
  {'title': 'Notes', 'icon': Icons.note_alt, 'color': const Color(0xFF8D6E63)},
  {'title': 'Events', 'icon': Icons.event, 'color': const Color(0xFF5D4037)},
  {'title': 'Notifications', 'icon': Icons.notifications, 'color': const Color(0xFF8D6E63)},
  {'title': 'Settings', 'icon': Icons.settings, 'color': const Color(0xFF5D4037)},
];


    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle, size: 30),
            onPressed: () => Navigator.pushNamed(context, '/profile'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            const Text('Hello, Krima', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF5D4037))),
            const Text('Welcome to your academic summary.', style: TextStyle(color: Colors.brown)),
            const SizedBox(height: 16),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    _StatItem(label: 'Semester', value: 'V'),
                    _StatItem(label: 'Attendance', value: '91%'),
                    _StatItem(label: 'Subjects', value: '4'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              itemCount: modules.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 1.0,
              ),
              itemBuilder: (context, index) {
                final module = modules[index];
                return DashboardCard(
                  title: module['title'],
                  icon: module['icon'],
                  color: module['color'],
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Opening ${module['title']}...')),
                    );
                  },
                );
              },
            ),
          ),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;

  const _StatItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF5D4037)),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.brown),
        ),
      ],
    );
  }
}
