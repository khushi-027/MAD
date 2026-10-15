import 'package:flutter/material.dart';

class EventGalleryScreen extends StatelessWidget {
  const EventGalleryScreen({super.key});

  // At least six events, as required by the dataset
  static const List<Map<String, dynamic>> _events = [
<<<<<<< HEAD
    {
      'title': 'Tech Hackathon 2026',
      'date': '18 Aug',
      'color': Color(0xFF5D4037),
      'icon': Icons.laptop_mac,
    },
    {
      'title': 'AI & ML Workshop',
      'date': '22 Aug',
      'color': Color(0xFF6D4C41),
      'icon': Icons.memory,
    },
    {
      'title': 'Coding Sprint',
      'date': '29 Aug',
      'color': Color(0xFF8D6E63),
      'icon': Icons.code,
    },
    {
      'title': 'Cultural Fest',
      'date': '02 Sep',
      'color': Color(0xFFA1887F),
      'icon': Icons.celebration,
    },
    {
      'title': 'Sports Meet',
      'date': '10 Sep',
      'color': Color(0xFF795548),
      'icon': Icons.sports_soccer,
    },
    {
      'title': 'Alumni Talk',
      'date': '15 Sep',
      'color': Color(0xFF4E342E),
      'icon': Icons.record_voice_over,
    },
=======
    {'title': 'Tech Hackathon 2026', 'date': '18 Aug', 'color': Color(0xFF5D4037), 'icon': Icons.laptop_mac},
    {'title': 'AI & ML Workshop', 'date': '22 Aug', 'color': Color(0xFF6D4C41), 'icon': Icons.memory},
    {'title': 'Coding Sprint', 'date': '29 Aug', 'color': Color(0xFF8D6E63), 'icon': Icons.code},
    {'title': 'Cultural Fest', 'date': '02 Sep', 'color': Color(0xFFA1887F), 'icon': Icons.celebration},
    {'title': 'Sports Meet', 'date': '10 Sep', 'color': Color(0xFF795548), 'icon': Icons.sports_soccer},
    {'title': 'Alumni Talk', 'date': '15 Sep', 'color': Color(0xFF4E342E), 'icon': Icons.record_voice_over},
>>>>>>> 06896c3daa9244bef5a9719c9b822d58d67eea3c
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Event Gallery')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        // LayoutBuilder + GridView: adapts column count to available width
        // (2 columns on phones, more on tablets/web) for true responsiveness.
        child: LayoutBuilder(
          builder: (context, constraints) {
            final crossAxisCount = (constraints.maxWidth ~/ 170).clamp(2, 4);
            return GridView.builder(
              itemCount: _events.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.85,
              ),
              itemBuilder: (context, index) {
                final event = _events[index];
                return _EventCard(
                  title: event['title'] as String,
                  date: event['date'] as String,
                  color: event['color'] as Color,
                  icon: event['icon'] as IconData,
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _EventCard extends StatelessWidget {
  final String title;
  final String date;
  final Color color;
  final IconData icon;

<<<<<<< HEAD
  const _EventCard({
    required this.title,
    required this.date,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
=======
  const _EventCard({required this.title, required this.date, required this.color, required this.icon});

  @override
  Widget build(BuildContext context) {
>>>>>>> 06896c3daa9244bef5a9719c9b822d58d67eea3c
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      // Stack: layers a gradient scrim and text on top of a colored
      // "image" placeholder, positioned using Align/Positioned children.
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [color, color.withOpacity(0.6)],
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
<<<<<<< HEAD
            child: Icon(
              icon,
              size: 40,
              color: cs.onBackground.withOpacity(0.35),
            ),
=======
            child: Icon(icon, size: 40, color: Colors.white.withOpacity(0.35)),
>>>>>>> 06896c3daa9244bef5a9719c9b822d58d67eea3c
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(10),
<<<<<<< HEAD
              decoration: BoxDecoration(
                color: cs.onBackground.withOpacity(0.18),
=======
              decoration: const BoxDecoration(
                color: Colors.black26,
>>>>>>> 06896c3daa9244bef5a9719c9b822d58d67eea3c
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
<<<<<<< HEAD
                    style: TextStyle(
                      color: cs.onBackground,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
=======
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
>>>>>>> 06896c3daa9244bef5a9719c9b822d58d67eea3c
                  ),
                  const SizedBox(height: 2),
                  Text(
                    date,
<<<<<<< HEAD
                    style: TextStyle(
                      color: cs.onBackground.withOpacity(0.78),
                      fontSize: 11,
                    ),
=======
                    style: const TextStyle(color: Colors.white70, fontSize: 11),
>>>>>>> 06896c3daa9244bef5a9719c9b822d58d67eea3c
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
