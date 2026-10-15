import 'package:flutter/material.dart';
import '../models/app_settings.dart';

/// Practical 4: NotificationsScreen now reads the shared [AppSettings]
/// object. Each notification is tagged with a `category` matching one of
/// the Notification Preferences checkboxes in Settings; items whose
/// category has been switched off there are filtered out here. This
/// demonstrates two different widgets (SettingsScreen and this one)
/// sharing and reacting to the same Application State.
class NotificationsScreen extends StatelessWidget {
  final AppSettings settings;

  const NotificationsScreen({super.key, required this.settings});

  static const List<Map<String, dynamic>> _allNotifications = [
    {
      'title': 'Internal Exam Schedule',
      'subtitle': 'Semester V internal exams begin next Monday.',
      'icon': Icons.event_note,
      'time': '2h ago',
      'category': 'Examination Notifications',
    },
    {
      'title': 'Assignment Deadline',
      'subtitle': 'REST API Integration assignment due tomorrow.',
      'icon': Icons.assignment_late,
      'time': '5h ago',
      'category': 'Assignment Alerts',
    },
    {
      'title': 'Technical Event Registration',
      'subtitle': 'Registrations for the Hackathon close this Friday.',
      'icon': Icons.campaign,
      'time': '1d ago',
      'category': 'Event Announcements',
    },
    {
      'title': 'Campus Placement Drive',
      'subtitle': 'TCS placement drive registrations open now.',
      'icon': Icons.work_outline,
      'time': '2d ago',
      'category': 'Placement Updates',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final notifications = _allNotifications
        .where((n) => settings.notificationPrefs[n['category']] ?? true)
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: notifications.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  'All notification categories are turned off.\n'
                  'Enable them from Settings > Notification Preferences.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: cs.onBackground.withOpacity(0.78)),
                ),
              ),
            )
          // ListView.separated: multi-child scrollable widget with a divider
          // between each entry, adapting to any number of notifications.
          : ListView.separated(
              padding: const EdgeInsets.all(16.0),
              itemCount: notifications.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final item = notifications[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: cs.primary.withOpacity(0.08),
                        child: Icon(
                          item['icon'] as IconData,
                          color: cs.primary,
                        ),
                      ),
                      const SizedBox(width: 14),
                      // Expanded: message text wraps and fills remaining row
                      // width responsively across phone and tablet screens.
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['title'] as String,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item['subtitle'] as String,
                              style: TextStyle(
                                fontSize: 13,
                                color: cs.onBackground.withOpacity(0.78),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        item['time'] as String,
                        style: TextStyle(
                          fontSize: 11,
                          color: cs.onBackground.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
