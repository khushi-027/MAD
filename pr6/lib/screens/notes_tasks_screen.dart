import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import '../database/database_helper.dart';
import '../models/note_entry.dart';
import 'entry_form_screen.dart';

/// Practical 6: Student Notes & Task Manager (SQLite).
///
/// * Read   : FutureBuilder shows the rows returned by an async query.
/// * Create / Update : [EntryFormScreen] (floating button, tap a card, menu).
/// * Delete : menu action + confirmation dialog.
/// * Search / Filter / Sort : re-run the query and rebuild the FutureBuilder.
class NotesTasksScreen extends StatefulWidget {
  const NotesTasksScreen({super.key});

  @override
  State<NotesTasksScreen> createState() => _NotesTasksScreenState();
}

class _NotesTasksScreenState extends State<NotesTasksScreen> {
  static const Map<EntryFilter, String> _filterLabels = {
    EntryFilter.all: 'All',
    EntryFilter.notes: 'Notes',
    EntryFilter.tasks: 'Tasks',
    EntryFilter.pending: 'Pending',
    EntryFilter.completed: 'Completed',
  };

  static const Map<SortOption, String> _sortLabels = {
    SortOption.newest: 'Newest first',
    SortOption.oldest: 'Oldest first',
    SortOption.titleAZ: 'Title (A to Z)',
    SortOption.dueDate: 'Due date',
    SortOption.priority: 'Priority',
  };

  final TextEditingController _searchController = TextEditingController();
  final DatabaseHelper _db = DatabaseHelper.instance;
  EntryFilter _filter = EntryFilter.all;
  SortOption _sort = SortOption.newest;
  late Future<List<NoteEntry>> _future;

  @override
  void initState() {
    super.initState();
    _future = _load();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<List<NoteEntry>> _load() {
    return _db.getEntries(
      search: _searchController.text,
      filter: _filter,
      sort: _sort,
    );
  }

  void _reload() {
    setState(() {
      _future = _load();
    });
  }

  void _snack(String message, {bool error = false}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: error ? Theme.of(context).colorScheme.error : null,
          content: Text(message),
        ),
      );
  }

  Future<void> _openForm([NoteEntry? entry]) async {
    final message = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (_) => EntryFormScreen(entry: entry)),
    );
    if (!mounted || message == null) return;
    _reload();
    _snack(message);
  }

  Future<void> _toggle(NoteEntry entry, bool value) async {
    try {
      await _db.setCompleted(entry.id!, value);
      if (!mounted) return;
      _reload();
      _snack(value ? 'Task marked as completed' : 'Task marked as pending');
    } catch (e) {
      if (!mounted) return;
      _snack('Could not update the task: $e', error: true);
    }
  }

  Future<void> _confirmDelete(NoteEntry entry) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        icon: const Icon(Icons.delete_outline),
        title: Text('Delete ${entry.type.toLowerCase()}?'),
        content: Text('"${entry.title}" will be permanently removed.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(dialogContext).colorScheme.error,
              foregroundColor: Theme.of(dialogContext).colorScheme.onError,
            ),
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    try {
      await _db.delete(entry.id!);
      if (!mounted) return;
      _reload();
      _snack('${entry.type} deleted');
    } catch (e) {
      if (!mounted) return;
      _snack('Could not delete: $e', error: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final fill = Theme.of(context).cardTheme.color ?? cs.surface;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notes & Tasks',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          PopupMenuButton<SortOption>(
            tooltip: 'Sort',
            icon: const Icon(Icons.sort),
            initialValue: _sort,
            onSelected: (value) {
              _sort = value;
              _reload();
            },
            itemBuilder: (context) => SortOption.values
                .map(
                  (o) => CheckedPopupMenuItem<SortOption>(
                    value: o,
                    checked: o == _sort,
                    child: Text(_sortLabels[o]!),
                  ),
                )
                .toList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openForm(),
        icon: const Icon(Icons.add),
        label: const Text('Add'),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (_) => _reload(),
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      hintText: 'Search notes and tasks',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _searchController.text.isEmpty
                          ? null
                          : IconButton(
                              icon: const Icon(Icons.close),
                              tooltip: 'Clear',
                              onPressed: () {
                                _searchController.clear();
                                _reload();
                              },
                            ),
                      filled: true,
                      fillColor: fill,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 48,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: EntryFilter.values
                        .map(
                          (f) => Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: ChoiceChip(
                              label: Text(_filterLabels[f]!),
                              selected: f == _filter,
                              showCheckmark: false,
                              selectedColor: cs.primary,
                              backgroundColor: fill,
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: f == _filter ? cs.onPrimary : cs.onSurface,
                              ),
                              onSelected: (_) {
                                _filter = f;
                                _reload();
                              },
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
                Expanded(
                  child: FutureBuilder<List<NoteEntry>>(
                    future: _future,
                    builder: (context, snapshot) {
                      // Keep showing the previous rows while a new query runs.
                      if (snapshot.connectionState == ConnectionState.waiting &&
                          !snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return _MessageState(
                          icon: Icons.error_outline,
                          title: 'Could not open the database',
                          message: kIsWeb
                              ? 'On Chrome run "dart run sqflite_common_ffi_web:setup" once, then restart the app.\n\n${snapshot.error}'
                              : '${snapshot.error}',
                          actionLabel: 'Retry',
                          onAction: _reload,
                        );
                      }
                      final entries = snapshot.data ?? const <NoteEntry>[];
                      if (entries.isEmpty) {
                        final searching = _searchController.text.trim().isNotEmpty ||
                            _filter != EntryFilter.all;
                        return _MessageState(
                          icon: searching ? Icons.search_off : Icons.edit_note,
                          title: searching ? 'No matching records' : 'Nothing here yet',
                          message: searching
                              ? 'Try a different search or filter.'
                              : 'Tap Add to create your first note or task.',
                        );
                      }
                      return ListView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 4, 16, 96),
                        itemCount: entries.length + 1,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 4, left: 4),
                              child: Text(
                                '${entries.length} ${entries.length == 1 ? 'record' : 'records'}  |  ${_sortLabels[_sort]}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: cs.onSurface.withValues(alpha: 0.7),
                                ),
                              ),
                            );
                          }
                          final entry = entries[index - 1];
                          return _EntryCard(
                            entry: entry,
                            onEdit: () => _openForm(entry),
                            onDelete: () => _confirmDelete(entry),
                            onToggle: (v) => _toggle(entry, v),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Semantic colours for priority / overdue, readable in light and dark mode.
Color _priorityColor(BuildContext context, int priority) {
  final dark = Theme.of(context).brightness == Brightness.dark;
  switch (priority) {
    case 0:
      return dark ? const Color(0xFF66BB6A) : const Color(0xFF2E7D32);
    case 2:
      return dark ? const Color(0xFFEF5350) : const Color(0xFFC62828);
    default:
      return dark ? const Color(0xFFFFA726) : const Color(0xFFEF6C00);
  }
}

class _EntryCard extends StatelessWidget {
  final NoteEntry entry;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final ValueChanged<bool> onToggle;

  const _EntryCard({
    required this.entry,
    required this.onEdit,
    required this.onDelete,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final due = entry.dueDate;
    final overdue =
        entry.isTask && !entry.isCompleted && due != null && due.isBefore(today);
    final done = entry.isTask && entry.isCompleted;

    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onEdit,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 10, 4, 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 48,
                child: entry.isTask
                    ? Checkbox(
                        value: entry.isCompleted,
                        onChanged: (v) => onToggle(v ?? false),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(left: 6, top: 6),
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: cs.primary.withValues(alpha: 0.12),
                          child: Icon(
                            Icons.sticky_note_2,
                            size: 18,
                            color: cs.primary,
                          ),
                        ),
                      ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        entry.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: done
                              ? cs.onSurface.withValues(alpha: 0.55)
                              : cs.onSurface,
                          decoration: done ? TextDecoration.lineThrough : null,
                        ),
                      ),
                    ),
                    if (entry.content.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        entry.content,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13,
                          color: cs.onSurface.withValues(alpha: 0.75),
                        ),
                      ),
                    ],
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      children: [
                        _Tag(label: entry.subject, color: cs.primary),
                        _Tag(
                          label: entry.type,
                          color: cs.secondary,
                          icon: entry.isTask ? Icons.task_alt : Icons.sticky_note_2,
                        ),
                        if (entry.isTask)
                          _Tag(
                            label: NoteEntry.priorityLabels[entry.priority],
                            color: _priorityColor(context, entry.priority),
                            icon: Icons.flag,
                          ),
                        if (entry.isTask && due != null)
                          _Tag(
                            label: overdue
                                ? 'Overdue ${formatDate(due)}'
                                : 'Due ${formatDate(due)}',
                            color: overdue
                                ? _priorityColor(context, 2)
                                : cs.onSurface.withValues(alpha: 0.8),
                            icon: Icons.event,
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              PopupMenuButton<String>(
                tooltip: 'More',
                onSelected: (value) {
                  if (value == 'edit') onEdit();
                  if (value == 'delete') onDelete();
                },
                itemBuilder: (context) => const [
                  PopupMenuItem(
                    value: 'edit',
                    child: ListTile(
                      dense: true,
                      leading: Icon(Icons.edit),
                      title: Text('Edit'),
                    ),
                  ),
                  PopupMenuItem(
                    value: 'delete',
                    child: ListTile(
                      dense: true,
                      leading: Icon(Icons.delete_outline),
                      title: Text('Delete'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final String label;
  final Color color;
  final IconData? icon;

  const _Tag({required this.label, required this.color, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: color),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

/// Used for the empty state and the database-error state.
class _MessageState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  const _MessageState({
    required this.icon,
    required this.title,
    required this.message,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 64, color: cs.onSurface.withValues(alpha: 0.4)),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: cs.onSurface,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(color: cs.onSurface.withValues(alpha: 0.75)),
            ),
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: 16),
              FilledButton(onPressed: onAction, child: Text(actionLabel!)),
            ],
          ],
        ),
      ),
    );
  }
}
