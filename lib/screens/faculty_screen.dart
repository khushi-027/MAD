import 'package:flutter/material.dart';

class FacultyScreen extends StatelessWidget {
  const FacultyScreen({super.key});

  // Faculty mapped to the attendance-module subjects from the dataset
  static const List<Map<String, String>> _faculty = [
    {'name': 'Prof. Nirav Bhatt', 'subject': 'DBMS', 'cabin': 'Cabin 12, Block A'},
    {'name': 'Prof. Gaurav Kumar', 'subject': 'MAD', 'cabin': 'Cabin 04, Block B'},
    {'name': 'Prof. Prajyot Patel', 'subject': 'AI', 'cabin': 'Cabin 09, Block A'},
    {'name': 'Prof. Dheeraj shringi', 'subject': 'CP', 'cabin': 'Cabin 07, Block C'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Faculty Information')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        // LayoutBuilder + GridView: column count adapts to the available
        // width so the screen stays usable on both phones and tablets.
        child: LayoutBuilder(
          builder: (context, constraints) {
            final crossAxisCount = (constraints.maxWidth ~/ 180).clamp(1, 3);
            return GridView.builder(
              itemCount: _faculty.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.95,
              ),
              itemBuilder: (context, index) {
                final f = _faculty[index];
                return _FacultyCard(
                  name: f['name']!,
                  subject: f['subject']!,
                  cabin: f['cabin']!,
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _FacultyCard extends StatelessWidget {
  final String name;
  final String subject;
  final String cabin;

  const _FacultyCard({required this.name, required this.subject, required this.cabin});

  @override
  Widget build(BuildContext context) {
    final initials = name
        .split(' ')
        .where((w) => w.isNotEmpty)
        .map((w) => w[0])
        .take(2)
        .join()
        .toUpperCase();

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Stack: overlays the subject badge on the bottom-right corner
            // of the avatar — a Multi-Child positioning widget.
            SizedBox(
              width: 72,
              height: 72,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  CircleAvatar(
                    radius: 36,
                    backgroundColor: const Color(0xFF5D4037),
                    child: Text(
                      initials,
                      style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Positioned(
                    bottom: -2,
                    right: -2,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFF8D6E63),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: Text(
                        subject,
                        style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              name,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF5D4037)),
            ),
            const SizedBox(height: 4),
            Text(
              cabin,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 11, color: Colors.brown),
            ),
          ],
        ),
      ),
    );
  }
}
