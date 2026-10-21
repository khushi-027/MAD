import 'package:flutter/material.dart';

class AssignmentsScreen extends StatelessWidget {
  const AssignmentsScreen({super.key});

  // Dataset from Practical 3
  static const List<Map<String, dynamic>> _assignments = [
    {
      'title': 'Flutter UI Design',
      'subject': 'MAD',
      'due': 'Due in 2 days',
      'status': 'Pending',
    },
    {
      'title': 'Database CRUD',
      'subject': 'DBMS',
      'due': 'Due in 5 days',
      'status': 'In Progress',
    },
    {
      'title': 'REST API Integration',
      'subject': 'MAD',
      'due': 'Submitted',
      'status': 'Completed',
    },
  ];

  Color _statusColor(String status) {
    switch (status) {
      case 'Completed':
        return const Color(0xFF2E7D32);
      case 'In Progress':
        return const Color(0xFFEF6C00);
      default:
        return const Color(0xFFC62828);
    }
  }

  IconData _statusIcon(String status) {
    switch (status) {
      case 'Completed':
        return Icons.check_circle;
      case 'In Progress':
        return Icons.hourglass_bottom;
      default:
        return Icons.pending_actions;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Assignment List')),
      // ListView.builder: multi-child scrollable widget, handles any number
      // of assignments without overflowing the screen.
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _assignments.length,
        itemBuilder: (context, index) {
          final item = _assignments[index];
          final status = item['status'] as String;
          final color = _statusColor(status);

          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: color.withOpacity(0.12),
                    child: Icon(_statusIcon(status), color: color),
                  ),
                  const SizedBox(width: 14),
                  // Expanded: title/subject column stretches to fill remaining
                  // width so the layout adapts to any device size.
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['title'] as String,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ) ??
                              const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${item['subject']} • ${item['due']}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(
                              context,
                            ).colorScheme.onBackground.withOpacity(0.75),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Flexible: status chip only takes the width its text needs
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(
                          color: color,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
