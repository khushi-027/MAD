import 'package:flutter/material.dart';
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
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle, size: 30),
            onPressed: () => Navigator.pushNamed(context, '/profile'),
          ),
        ],
      ),
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
    final cs = Theme.of(context).colorScheme;
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: cs.primary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: cs.onBackground.withOpacity(0.78),
          ),
        ),
      ],
    );
  }
}
