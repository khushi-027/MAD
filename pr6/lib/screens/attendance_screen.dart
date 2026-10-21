import 'package:flutter/material.dart';
import '../widgets/custom_widgets.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  // Dataset from Practical 3
  static const List<Map<String, dynamic>> _attendance = [
    {'subject': 'DBMS', 'percent': 0.92},
    {'subject': 'MAD', 'percent': 0.88},
    {'subject': 'AI', 'percent': 0.95},
    {'subject': 'CN', 'percent': 0.90},
  ];

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final double overall =
        _attendance.map((e) => e['percent'] as double).reduce((a, b) => a + b) /
        _attendance.length;

    return Scaffold(
      appBar: AppBar(title: const Text('Attendance Summary')),
      // ListView.builder: Multi-Child scrollable widget, ensures the screen
      // adapts to any device height without overflow.
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Single Child widget (Card) wrapping a Row/Column combination
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            color: cs.primary,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Overall Attendance',
                    style: TextStyle(
                      color: cs.onPrimary.withOpacity(0.9),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${(overall * 100).toStringAsFixed(0)}%',
                    style: TextStyle(
                      color: cs.onPrimary,
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Row + Expanded: fills all available horizontal space responsively
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: LinearProgressIndicator(
                            value: overall,
                            minHeight: 8,
                            backgroundColor: cs.onPrimary.withOpacity(0.24),
                            valueColor: AlwaysStoppedAnimation(cs.onPrimary),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SectionHeader(
            title: 'Subject-wise Attendance',
            icon: Icons.bar_chart,
          ),
          // Column of subject rows built from the dataset
          ..._attendance.map(
            (item) => _AttendanceTile(
              subject: item['subject'] as String,
              percent: item['percent'] as double,
            ),
          ),
        ],
      ),
    );
  }
}

class _AttendanceTile extends StatelessWidget {
  final String subject;
  final double percent;

  const _AttendanceTile({required this.subject, required this.percent});

  Color get _statusColor {
    if (percent >= 0.90) return const Color(0xFF2E7D32); // Good
    if (percent >= 0.75) return const Color(0xFFEF6C00); // Warning
    return const Color(0xFFC62828); // Critical
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          children: [
            // Flexible: subject name shrinks/grows but never forces overflow
            Flexible(
              flex: 2,
              child: Text(
                subject,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Expanded: progress bar always fills remaining space regardless of screen width
            Expanded(
              flex: 4,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: percent,
                  minHeight: 10,
                  backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
                  valueColor: AlwaysStoppedAnimation(_statusColor),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              '${(percent * 100).toStringAsFixed(0)}%',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: _statusColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
