# Smart Student Companion - Practical 6
**Student Notes & Task Manager (SQLite)** - builds on Practical 4/5 (`student_dash`).

## What was added
| File | Purpose |
|---|---|
| `lib/models/note_entry.dart` | `NoteEntry` model (Note or Task) with `toMap()` / `fromMap()` |
| `lib/database/database_helper.dart` | Singleton: opens DB, creates table + sample rows, CRUD, search, filter, sort (all `Future` / `async-await`) |
| `lib/database/db_locator*.dart` | Chooses the SQLite engine per platform (Android/iOS, desktop, web) |
| `lib/screens/notes_tasks_screen.dart` | List screen: `FutureBuilder`, search bar, filter chips, sort menu, complete checkbox, delete with confirmation, empty/error states |
| `lib/screens/entry_form_screen.dart` | Create / Edit form with validation (title, note text, due date for tasks) |
| `lib/widgets/custom_widgets.dart` | `CustomTextField` (maxLines / maxLength) and `CustomButton` (loading) extended |
| `lib/screens/dashboard_screen.dart`, `lib/main.dart`, `lib/models/app_settings.dart` | "Notes & Tasks" card, `/notes` route, Dashboard Customization switch |

Table `entries`: `id, title, content, type (Note/Task), subject, priority, due_date, is_completed, created_at, updated_at`.

## Run
```
flutter pub get
flutter run                      # Android emulator / device
```
**Chrome (web) only - one-time setup** (copies `sqlite3.wasm` and `sqflite_sw.js` into `web/`):
```
dart run sqflite_common_ffi_web:setup
flutter run -d chrome
```
Open the app: Login > Dashboard > **Notes & Tasks**.
