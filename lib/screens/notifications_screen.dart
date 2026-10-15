import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  // Dataset from Practical 3
  static const List<Map<String, dynamic>> _notifications = [
    {
      'title': 'Internal Exam Schedule',
      'subtitle': 'Semester V internal exams begin next Monday.',
      'icon': Icons.event_note,
      'time': '2h ago',
    },
    {
      'title': 'Assignment Deadline',
      'subtitle': 'REST API Integration assignment due tomorrow.',
      'icon': Icons.assignment_late,
      'time': '5h ago',
    },
    {
      'title': 'Technical Event Registration',
      'subtitle': 'Registrations for the Hackathon close this Friday.',
      'icon': Icons.campaign,
      'time': '1d ago',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      // ListView.separated: multi-child scrollable widget with a divider
      // between each entry, adapting to any number of notifications.
      body: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: _notifications.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final item = _notifications[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: const Color(0xFF5D4037).withOpacity(0.1),
                  child: Icon(item['icon'] as IconData, color: const Color(0xFF5D4037)),
                ),
                const SizedBox(width: 14),
                // Expanded: message text wraps and fills remaining row width
                // responsively across phone and tablet screen sizes.
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['title'] as String,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item['subtitle'] as String,
                        style: const TextStyle(fontSize: 13, color: Colors.brown),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  item['time'] as String,
                  style: const TextStyle(fontSize: 11, color: Colors.grey),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
