import 'package:flutter/material.dart';
<<<<<<< HEAD
import '../models/app_settings.dart';
import '../widgets/custom_widgets.dart';

/// Practical 4: DashboardScreen now takes the shared [AppSettings] so it can
/// show live values (name, semester) and respect Dashboard Customization
/// (modules toggled off in Settings simply disappear from the grid). This is
/// StatelessWidget: the screen holds no state of its own -- it only reads
/// the Application State object it was given, so it rebuilds correctly
/// whenever the parent's setState() runs after a settings change.
class DashboardScreen extends StatelessWidget {
  final AppSettings settings;

  const DashboardScreen({super.key, required this.settings});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final List<Map<String, dynamic>> allModules = [
      {
        'title': 'Attendance',
        'icon': Icons.co_present,
        'color': const Color(0xFF5D4037),
        'route': '/attendance',
      },
      {
        'title': 'Timetable',
        'icon': Icons.calendar_today,
        'color': const Color(0xFF8D6E63),
        'route': '/timetable',
      },
      {
        'title': 'Assignments',
        'icon': Icons.assignment,
        'color': const Color(0xFF5D4037),
        'route': '/assignments',
      },
      {
        'title': 'Faculty',
        'icon': Icons.people_alt,
        'color': const Color(0xFF8D6E63),
        'route': '/faculty',
      },
      {
        'title': 'Events',
        'icon': Icons.event,
        'color': const Color(0xFF5D4037),
        'route': '/events',
      },
      {
        'title': 'Notifications',
        'icon': Icons.notifications,
        'color': const Color(0xFF8D6E63),
        'route': '/notifications',
      },
    ];

    // Dashboard Customization: only include modules the user left switched
    // on in Settings. "Settings" itself is always shown (not toggleable).
    final modules = [
      ...allModules.where(
        (m) => settings.dashboardVisibility[m['title']] ?? true,
      ),
      {
        'title': 'Settings',
        'icon': Icons.settings,
        'color': const Color(0xFF5D4037),
        'route': '/settings',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dashboard',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
=======
import '../widgets/custom_widgets.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Theme matching brown tones assigned down directly onto elements grid array mapping parameters
    final List<Map<String, dynamic>> modules = [
<<<<<<< HEAD
  {'title': 'Attendance', 'icon': Icons.co_present, 'color': const Color(0xFF5D4037), 'route': '/attendance'},
  {'title': 'Timetable', 'icon': Icons.calendar_today, 'color': const Color(0xFF8D6E63), 'route': '/timetable'},
  {'title': 'Assignments', 'icon': Icons.assignment, 'color': const Color(0xFF5D4037), 'route': '/assignments'},
  {'title': 'Faculty', 'icon': Icons.people_alt, 'color': const Color(0xFF8D6E63), 'route': '/faculty'},
  {'title': 'Events', 'icon': Icons.event, 'color': const Color(0xFF5D4037), 'route': '/events'},
  {'title': 'Notifications', 'icon': Icons.notifications, 'color': const Color(0xFF8D6E63), 'route': '/notifications'},
  {'title': 'Settings', 'icon': Icons.settings, 'color': const Color(0xFF5D4037), 'route': null},
];

=======
  {'title': 'Attendance', 'icon': Icons.co_present, 'color': const Color(0xFF5D4037)},
  {'title': 'Timetable', 'icon': Icons.calendar_today, 'color': const Color(0xFF8D6E63)},
  {'title': 'Assignments', 'icon': Icons.assignment, 'color': const Color(0xFF5D4037)},
  {'title': 'Notes', 'icon': Icons.note_alt, 'color': const Color(0xFF8D6E63)},
  {'title': 'Events', 'icon': Icons.event, 'color': const Color(0xFF5D4037)},
  {'title': 'Notifications', 'icon': Icons.notifications, 'color': const Color(0xFF8D6E63)},
  {'title': 'Settings', 'icon': Icons.settings, 'color': const Color(0xFF5D4037)},
];


>>>>>>> ce26a43b9d3cb92d948e22bb1456f554e85929a2
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard', style: TextStyle(fontWeight: FontWeight.bold)),
>>>>>>> 06896c3daa9244bef5a9719c9b822d58d67eea3c
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle, size: 30),
            onPressed: () => Navigator.pushNamed(context, '/profile'),
          ),
        ],
      ),
<<<<<<< HEAD
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final crossAxisCount = (constraints.maxWidth / 180).floor().clamp(
              2,
              4,
            );
            final isLandscape =
                MediaQuery.of(context).orientation == Orientation.landscape;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  Text(
                    'Hello, ${settings.name.isEmpty ? 'Student' : settings.name.split(' ').first}',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: cs.onBackground,
                    ),
                  ),
                  Text(
                    'Welcome to your academic summary.',
                    style: TextStyle(color: cs.onBackground.withOpacity(0.78)),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 14.0,
                        horizontal: 8.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _StatItem(
                            label: 'Semester',
                            value: settings.semester.replaceFirst(
                              'Semester ',
                              '',
                            ),
                          ),
                          _StatItem(label: 'Attendance', value: '91%'),
                          _StatItem(
                            label: 'Courses',
                            value: '${settings.selectedCourses.length}',
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: GridView.builder(
                      itemCount: modules.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: isLandscape ? 1.25 : 0.92,
                      ),
                      itemBuilder: (context, index) {
                        final module = modules[index];
                        return DashboardCard(
                          title: module['title'] as String,
                          icon: module['icon'] as IconData,
                          color: module['color'] as Color,
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              module['route'] as String,
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
=======
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
<<<<<<< HEAD
                    final route = module['route'];
                    if (route != null) {
                      Navigator.pushNamed(context, route);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Opening ${module['title']}...')),
                      );
                    }
=======
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Opening ${module['title']}...')),
                    );
>>>>>>> ce26a43b9d3cb92d948e22bb1456f554e85929a2
                  },
                );
              },
            ),
          ),
          ],
>>>>>>> 06896c3daa9244bef5a9719c9b822d58d67eea3c
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
<<<<<<< HEAD
    final cs = Theme.of(context).colorScheme;
=======
>>>>>>> 06896c3daa9244bef5a9719c9b822d58d67eea3c
    return Column(
      children: [
        Text(
          value,
<<<<<<< HEAD
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: cs.primary,
          ),
=======
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF5D4037)),
>>>>>>> 06896c3daa9244bef5a9719c9b822d58d67eea3c
        ),
        const SizedBox(height: 4),
        Text(
          label,
<<<<<<< HEAD
          style: TextStyle(
            fontSize: 12,
            color: cs.onBackground.withOpacity(0.78),
          ),
=======
          style: const TextStyle(fontSize: 12, color: Colors.brown),
>>>>>>> 06896c3daa9244bef5a9719c9b822d58d67eea3c
        ),
      ],
    );
  }
}
