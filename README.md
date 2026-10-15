# Smart Student Companion - Practical 4

**Name:** Krima | **Roll No.:** 24AIML027 | **Subject:** AIUE302_MAD

State management with `setState()`: a shared `AppSettings` object (Application State)
lives in `main.dart`; Settings changes update every screen instantly.

| Module | Control |
|---|---|
| Student Profile Settings | TextFormField (ephemeral draft) + Save |
| Theme (Light/Dark) | Switch |
| Semester Selection | DropdownButton |
| Language Selection | Radio buttons |
| Notification Preferences | Checkbox |
| Course Preferences | Checkbox |
| Daily Study Goal | Slider |
| Dashboard Customization | Switch per module |

## Structure
```
lib/
  main.dart                  StatefulWidget root, owns AppSettings, themeMode
  models/app_settings.dart   Application State
  screens/                   12 screens (settings_screen.dart is new)
  widgets/custom_widgets.dart
```

## Run
```bash
flutter create .      # generates android/, ios/ etc. (existing files are kept)
flutter pub get
flutter run
```

## Key Questions
1. **State management:** controlling the data that changes over time and rebuilding the UI to match. Needed so what the user does appears on screen without restarting.
2. **Ephemeral vs Application state:** ephemeral state belongs to one widget (text typed in a field, selected tab); application state is shared by many screens (theme, language, semester, preferences).
3. **setState():** called inside a State object; it runs the given function, marks the widget dirty and schedules `build()` again.
4. **Stateful vs Stateless:** use Stateful when the widget's data changes or needs a lifecycle (forms, timers, toggles); Stateless when output depends only on its constructor values.
5. **Rebuild:** Flutter re-runs `build()` for the dirty widget, compares the new widget tree with the element tree and updates only the render objects that changed.
6. **Controls:** Checkbox (`value`, `onChanged` bool?), Radio (one `groupValue` for a group, via RadioGroup), Switch (`value`, `onChanged` bool), DropdownButton (`items`, `value`, `onChanged`), Slider (`value`, `min`, `max`, `divisions`, `onChanged`). Each stores the new value then calls setState().
7. **Sharing state:** keep it in a common ancestor (here `_StudentCompanionAppState`), pass it down through constructors, and pass a callback up to change it.
8. **Limitations of setState():** state is local to one widget, passing it down many levels is verbose (prop drilling), whole subtrees rebuild, and logic gets mixed with UI. Large apps use Provider, Riverpod or Bloc.
