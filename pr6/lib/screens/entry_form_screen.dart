import 'package:flutter/material.dart';

import '../database/database_helper.dart';
import '../models/note_entry.dart';
import '../widgets/custom_widgets.dart';

/// Create / Edit form for a note or a task.
/// Pops with a success message (String) when the record was saved,
/// or with null when the user leaves without saving.
class EntryFormScreen extends StatefulWidget {
  final NoteEntry? entry;

  const EntryFormScreen({super.key, this.entry});

  @override
  State<EntryFormScreen> createState() => _EntryFormScreenState();
}

class _EntryFormScreenState extends State<EntryFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _contentController;
  late String _type;
  late String _subject;
  late int _priority;
  DateTime? _dueDate;
  bool _saving = false;

  bool get _isEdit => widget.entry != null;
  bool get _isTask => _type == NoteEntry.typeTask;

  @override
  void initState() {
    super.initState();
    final e = widget.entry;
    _titleController = TextEditingController(text: e?.title ?? '');
    _contentController = TextEditingController(text: e?.content ?? '');
    _type = e?.type ?? NoteEntry.typeNote;
    _subject = e?.subject ?? NoteEntry.subjects.first;
    _priority = e?.priority ?? 1;
    _dueDate = e?.dueDate;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _pickDate(FormFieldState<DateTime> field) async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    // Keep an existing (possibly overdue) date selectable while editing.
    final first = (_dueDate != null && _dueDate!.isBefore(today))
        ? _dueDate!
        : today;
    final picked = await showDatePicker(
      context: context,
      initialDate: _dueDate ?? today,
      firstDate: first,
      lastDate: DateTime(today.year + 5),
    );
    if (picked == null) return;
    setState(() => _dueDate = DateTime(picked.year, picked.month, picked.day));
    field.didChange(_dueDate);
  }

  Future<void> _save() async {
    if (_saving) return;
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: Theme.of(context).colorScheme.error,
            content: const Text('Please fix the highlighted fields'),
          ),
        );
      return;
    }

    setState(() => _saving = true);
    final now = DateTime.now();
    final old = widget.entry;
    final entry = NoteEntry(
      id: old?.id,
      title: _titleController.text.trim(),
      content: _contentController.text.trim(),
      type: _type,
      subject: _subject,
      priority: _isTask ? _priority : 1,
      dueDate: _isTask ? _dueDate : null,
      isCompleted: _isTask ? (old?.isCompleted ?? false) : false,
      createdAt: old?.createdAt ?? now,
      updatedAt: now,
    );

    try {
      if (_isEdit) {
        await DatabaseHelper.instance.update(entry);
      } else {
        await DatabaseHelper.instance.insert(entry);
      }
      if (!mounted) return;
      Navigator.pop(
        context,
        _isEdit
            ? '${entry.type} updated successfully'
            : '${entry.type} saved successfully',
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => _saving = false);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: Theme.of(context).colorScheme.error,
            content: Text('Could not save: $e'),
          ),
        );
    }
  }

  InputDecoration _decoration(String label, IconData icon, {String? error}) {
    return InputDecoration(
      labelText: label,
      errorText: error,
      prefixIcon: Icon(icon, color: Theme.of(context).colorScheme.primary),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      filled: true,
      fillColor: Theme.of(context).colorScheme.surface,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text(_isEdit ? 'Edit Entry' : 'New Entry')),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  SegmentedButton<String>(
                    segments: const [
                      ButtonSegment(
                        value: NoteEntry.typeNote,
                        icon: Icon(Icons.sticky_note_2),
                        label: Text('Note'),
                      ),
                      ButtonSegment(
                        value: NoteEntry.typeTask,
                        icon: Icon(Icons.task_alt),
                        label: Text('Task'),
                      ),
                    ],
                    selected: {_type},
                    onSelectionChanged: (s) => setState(() => _type = s.first),
                  ),
                  const SizedBox(height: 12),
                  CustomTextField(
                    label: 'Title',
                    icon: Icons.title,
                    controller: _titleController,
                    maxLength: 80,
                    validator: (v) {
                      final t = v?.trim() ?? '';
                      if (t.isEmpty) return 'Title is required';
                      if (t.length < 3) return 'Title must be at least 3 characters';
                      return null;
                    },
                  ),
                  CustomTextField(
                    label: _isTask ? 'Description (optional)' : 'Note',
                    icon: Icons.notes,
                    controller: _contentController,
                    maxLines: 5,
                    minLines: 3,
                    maxLength: 500,
                    validator: (v) {
                      final t = v?.trim() ?? '';
                      if (!_isTask && t.length < 5) {
                        return 'Write at least 5 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 4),
                  DropdownButtonFormField<String>(
                    initialValue: _subject,
                    decoration: _decoration('Subject', Icons.menu_book),
                    items: NoteEntry.subjects
                        .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                        .toList(),
                    onChanged: (v) {
                      if (v != null) setState(() => _subject = v);
                    },
                  ),
                  if (_isTask) ...[
                    const SizedBox(height: 16),
                    Text(
                      'Priority',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: cs.onSurface,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SegmentedButton<int>(
                      segments: const [
                        ButtonSegment(value: 0, label: Text('Low')),
                        ButtonSegment(value: 1, label: Text('Medium')),
                        ButtonSegment(value: 2, label: Text('High')),
                      ],
                      selected: {_priority},
                      onSelectionChanged: (s) =>
                          setState(() => _priority = s.first),
                    ),
                    const SizedBox(height: 16),
                    FormField<DateTime>(
                      initialValue: _dueDate,
                      validator: (v) => _isTask && _dueDate == null
                          ? 'Select a due date'
                          : null,
                      builder: (field) => InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () => _pickDate(field),
                        child: InputDecorator(
                          decoration: _decoration(
                            'Due date',
                            Icons.event,
                            error: field.errorText,
                          ),
                          child: Text(
                            _dueDate == null
                                ? 'Tap to select'
                                : formatDate(_dueDate!),
                            style: TextStyle(
                              color: _dueDate == null
                                  ? cs.onSurface.withValues(alpha: 0.6)
                                  : cs.onSurface,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 28),
                  CustomButton(
                    text: _isEdit ? 'Update' : 'Save',
                    loading: _saving,
                    onPressed: _save,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
