import 'package:sqflite_common/sqlite_api.dart';

import '../models/note_entry.dart';
import 'db_locator.dart';

enum EntryFilter { all, notes, tasks, pending, completed }

enum SortOption { newest, oldest, titleAZ, dueDate, priority }

/// Single access point to the SQLite database (singleton).
/// Every method is asynchronous (Future + async/await) so the UI never blocks.
class DatabaseHelper {
  DatabaseHelper._();
  static final DatabaseHelper instance = DatabaseHelper._();

  static const String _dbName = 'student_companion.db';
  static const String _table = 'entries';

  Future<Database>? _opening;

  /// Opens the database once and re-uses the same connection afterwards.
  Future<Database> get database {
    return _opening ??= _open();
  }

  Future<Database> _open() async {
    try {
      final location = await locateDatabase(_dbName);
      return await location.factory.openDatabase(
        location.path,
        options: OpenDatabaseOptions(version: 1, onCreate: _onCreate),
      );
    } catch (_) {
      _opening = null; // allow a retry after a failure
      rethrow;
    }
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_table (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        content TEXT NOT NULL DEFAULT '',
        type TEXT NOT NULL,
        subject TEXT NOT NULL,
        priority INTEGER NOT NULL DEFAULT 1,
        due_date TEXT,
        is_completed INTEGER NOT NULL DEFAULT 0,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL
      )
    ''');
    await db.execute('CREATE INDEX idx_entries_type ON $_table (type)');

    // A few sample records so the module is not empty on first launch.
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final seeds = <NoteEntry>[
      NoteEntry(
        title: 'Flutter widget tree revision',
        content:
            'Revise Stateless vs Stateful widgets and the layout widget hierarchy for the MAD viva.',
        type: NoteEntry.typeNote,
        subject: 'MAD',
        createdAt: now.subtract(const Duration(minutes: 4)),
        updatedAt: now.subtract(const Duration(minutes: 4)),
      ),
      NoteEntry(
        title: 'Submit SQLite practical',
        content: 'Complete CRUD, search and sort screens and upload the report.',
        type: NoteEntry.typeTask,
        subject: 'MAD',
        priority: 2,
        dueDate: today.add(const Duration(days: 2)),
        createdAt: now.subtract(const Duration(minutes: 3)),
        updatedAt: now.subtract(const Duration(minutes: 3)),
      ),
      NoteEntry(
        title: 'DBMS normalization notes',
        content: '1NF, 2NF, 3NF and BCNF with one example each.',
        type: NoteEntry.typeNote,
        subject: 'DBMS',
        priority: 0,
        createdAt: now.subtract(const Duration(minutes: 2)),
        updatedAt: now.subtract(const Duration(minutes: 2)),
      ),
      NoteEntry(
        title: 'Prepare for AI internal exam',
        content: 'Search algorithms and knowledge representation.',
        type: NoteEntry.typeTask,
        subject: 'AI',
        priority: 2,
        dueDate: today.add(const Duration(days: 5)),
        createdAt: now.subtract(const Duration(minutes: 1)),
        updatedAt: now.subtract(const Duration(minutes: 1)),
      ),
      NoteEntry(
        title: 'Computer Networks assignment',
        content: 'OSI vs TCP/IP comparison table.',
        type: NoteEntry.typeTask,
        subject: 'CN',
        dueDate: today.add(const Duration(days: 7)),
        isCompleted: true,
        createdAt: now,
        updatedAt: now,
      ),
    ];
    final batch = db.batch();
    for (final s in seeds) {
      batch.insert(_table, s.toMap());
    }
    await batch.commit(noResult: true);
  }

  // ------------------------------ CREATE ------------------------------
  Future<int> insert(NoteEntry entry) async {
    final db = await database;
    return db.insert(_table, entry.toMap());
  }

  // ------------------------------ READ --------------------------------
  /// Reads entries with optional search text, filter and sort order.
  /// All user text is passed through `whereArgs` (never concatenated).
  Future<List<NoteEntry>> getEntries({
    String search = '',
    EntryFilter filter = EntryFilter.all,
    SortOption sort = SortOption.newest,
  }) async {
    final db = await database;
    final where = <String>[];
    final args = <Object?>[];

    final q = search.trim();
    if (q.isNotEmpty) {
      where.add(
        "(title LIKE ? ESCAPE '!' OR content LIKE ? ESCAPE '!' OR subject LIKE ? ESCAPE '!')",
      );
      final like = '%${_escapeLike(q)}%';
      args.addAll([like, like, like]);
    }

    switch (filter) {
      case EntryFilter.all:
        break;
      case EntryFilter.notes:
        where.add('type = ?');
        args.add(NoteEntry.typeNote);
      case EntryFilter.tasks:
        where.add('type = ?');
        args.add(NoteEntry.typeTask);
      case EntryFilter.pending:
        where.add('type = ? AND is_completed = 0');
        args.add(NoteEntry.typeTask);
      case EntryFilter.completed:
        where.add('type = ? AND is_completed = 1');
        args.add(NoteEntry.typeTask);
    }

    final rows = await db.query(
      _table,
      where: where.isEmpty ? null : where.join(' AND '),
      whereArgs: args.isEmpty ? null : args,
      orderBy: _orderBy(sort),
    );
    return rows.map(NoteEntry.fromMap).toList();
  }

  // ------------------------------ UPDATE ------------------------------
  Future<int> update(NoteEntry entry) async {
    final db = await database;
    return db.update(
      _table,
      entry.toMap(),
      where: 'id = ?',
      whereArgs: [entry.id],
    );
  }

  Future<int> setCompleted(int id, bool completed) async {
    final db = await database;
    return db.update(
      _table,
      {
        'is_completed': completed ? 1 : 0,
        'updated_at': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // ------------------------------ DELETE ------------------------------
  Future<int> delete(int id) async {
    final db = await database;
    return db.delete(_table, where: 'id = ?', whereArgs: [id]);
  }

  // ------------------------------ helpers -----------------------------
  String _escapeLike(String s) =>
      s.replaceAll('!', '!!').replaceAll('%', '!%').replaceAll('_', '!_');

  /// Fixed whitelist, so the ORDER BY clause can never come from user input.
  String _orderBy(SortOption sort) {
    switch (sort) {
      case SortOption.newest:
        return 'created_at DESC';
      case SortOption.oldest:
        return 'created_at ASC';
      case SortOption.titleAZ:
        return 'title COLLATE NOCASE ASC';
      case SortOption.dueDate:
        return 'due_date IS NULL, due_date ASC';
      case SortOption.priority:
        return 'priority DESC, created_at DESC';
    }
  }
}
