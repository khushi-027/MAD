import 'package:flutter/material.dart';

class TimetableScreen extends StatefulWidget {
  const TimetableScreen({super.key});

  @override
  State<TimetableScreen> createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<TimetableScreen> {
  int _selectedDay = 0;

  static const List<String> _days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'];

  // Weekly schedule built from the Practical dataset (DBMS, MAD, AI, CN)
  static const Map<String, List<Map<String, String>>> _schedule = {
    'Mon': [
      {'time': '09:00 - 10:00', 'subject': 'DBMS', 'room': 'Room 204'},
      {'time': '10:00 - 11:00', 'subject': 'MAD', 'room': 'Room 105'},
      {'time': '11:15 - 12:15', 'subject': 'AI', 'room': 'Lab 3'},
    ],
    'Tue': [
      {'time': '09:00 - 10:00', 'subject': 'CN', 'room': 'Room 302'},
      {'time': '10:00 - 11:00', 'subject': 'DBMS', 'room': 'Lab 1'},
    ],
    'Wed': [
      {'time': '09:00 - 10:00', 'subject': 'AI', 'room': 'Room 204'},
      {'time': '10:00 - 11:00', 'subject': 'MAD', 'room': 'Lab 2'},
      {'time': '11:15 - 12:15', 'subject': 'CN', 'room': 'Room 105'},
    ],
    'Thu': [
      {'time': '09:00 - 10:00', 'subject': 'DBMS', 'room': 'Room 204'},
      {'time': '10:00 - 11:00', 'subject': 'AI', 'room': 'Lab 3'},
    ],
    'Fri': [
      {'time': '09:00 - 10:00', 'subject': 'MAD', 'room': 'Room 105'},
      {'time': '10:00 - 11:00', 'subject': 'CN', 'room': 'Room 302'},
      {'time': '11:15 - 12:15', 'subject': 'AI', 'room': 'Lab 1'},
    ],
  };

  static const Map<String, Color> _subjectColors = {
    'DBMS': Color(0xFF5D4037),
    'MAD': Color(0xFF8D6E63),
    'AI': Color(0xFF6D4C41),
    'CN': Color(0xFFA1887F),
  };

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final entries = _schedule[_days[_selectedDay]] ?? [];

    return Scaffold(
      appBar: AppBar(title: const Text('Timetable')),
      body: Column(
        children: [
          // Wrap: multi-child widget that lays day chips out responsively,
          // moving to a new line automatically on narrow screens.
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Wrap(
              spacing: 8,
              children: List.generate(_days.length, (index) {
                final selected = index == _selectedDay;
                return ChoiceChip(
                  label: Text(_days[index]),
                  selected: selected,
                  onSelected: (_) => setState(() => _selectedDay = index),
                  selectedColor: cs.primary,
                  labelStyle: TextStyle(
                    color: selected ? cs.onPrimary : cs.onBackground,
                    fontWeight: FontWeight.bold,
                  ),
                  backgroundColor: cs.surface,
                );
              }),
            ),
          ),
          // Expanded + ListView: remaining vertical space is filled and the
          // period list scrolls independently of the day-selector above it.
          Expanded(
            child: entries.isEmpty
                ? Center(
                    child: Text(
                      'No classes scheduled',
                      style: TextStyle(
                        color: cs.onBackground.withOpacity(0.75),
                      ),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    itemCount: entries.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final entry = entries[index];
                      final color =
                          _subjectColors[entry['subject']] ??
                          const Color(0xFF5D4037);
                      return _PeriodTile(
                        time: entry['time']!,
                        subject: entry['subject']!,
                        room: entry['room']!,
                        color: color,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _PeriodTile extends StatelessWidget {
  final String time;
  final String subject;
  final String room;
  final Color color;

  const _PeriodTile({
    required this.time,
    required this.subject,
    required this.room,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // Fixed-width single-child container acting as a colored time marker
            Container(
              width: 6,
              height: 44,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: 14),
            // Expanded: subject/room text takes all remaining row width responsively
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subject,
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
                  const SizedBox(height: 2),
                  Text(
                    room,
                    style: TextStyle(
                      color: Theme.of(
                        context,
                      ).colorScheme.onBackground.withOpacity(0.75),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              time,
              style: TextStyle(
                fontSize: 12,
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
