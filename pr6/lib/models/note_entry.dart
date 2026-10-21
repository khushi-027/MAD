/// One row of the `entries` table: either a Note or a Task.
class NoteEntry {
  static const String typeNote = 'Note';
  static const String typeTask = 'Task';
  static const List<String> subjects = ['MAD', 'DBMS', 'AI', 'CN', 'General'];
  static const List<String> priorityLabels = ['Low', 'Medium', 'High'];

  final int? id;
  final String title;
  final String content;
  final String type;
  final String subject;
  final int priority; // 0 = Low, 1 = Medium, 2 = High
  final DateTime? dueDate;
  final bool isCompleted;
  final DateTime createdAt;
  final DateTime updatedAt;

  const NoteEntry({
    this.id,
    required this.title,
    this.content = '',
    required this.type,
    required this.subject,
    this.priority = 1,
    this.dueDate,
    this.isCompleted = false,
    required this.createdAt,
    required this.updatedAt,
  });

  bool get isTask => type == typeTask;

  Map<String, Object?> toMap() => {
        if (id != null) 'id': id,
        'title': title,
        'content': content,
        'type': type,
        'subject': subject,
        'priority': priority,
        'due_date': dueDate?.toIso8601String(),
        'is_completed': isCompleted ? 1 : 0,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
      };

  factory NoteEntry.fromMap(Map<String, Object?> map) {
    final due = map['due_date'] as String?;
    return NoteEntry(
      id: map['id'] as int?,
      title: map['title'] as String,
      content: (map['content'] as String?) ?? '',
      type: map['type'] as String,
      subject: map['subject'] as String,
      priority: (map['priority'] as int?) ?? 1,
      dueDate: due == null ? null : DateTime.parse(due),
      isCompleted: ((map['is_completed'] as int?) ?? 0) == 1,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }
}

const List<String> _months = [
  'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
  'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
];

/// Formats a date as `21 Oct 2026`.
String formatDate(DateTime d) =>
    '${d.day.toString().padLeft(2, '0')} ${_months[d.month - 1]} ${d.year}';
