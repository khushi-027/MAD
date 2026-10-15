<<<<<<< HEAD
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
=======
<<<<<<< HEAD
# Smart Student Companion - Practical 3

**Name:** Krima | **Roll No.:** 24AIML027 | **Subject:** AIUE302_MAD

Screens: Splash, Login, Registration, Dashboard, Profile, Attendance, Timetable,
Assignments, Notifications, Faculty, Event Gallery. Theme: brown, cream, white.
=======
# Smart Student Companion - Practical 2

**Name:** Krima | **Roll No.:** 24AIML027 | **Subject:** AIUE302_MAD

Practical 2: Design Student Dashboard using Flutter Widgets.

Screens: Splash, Login, Registration, Dashboard (Attendance, Timetable,
Assignments, Notes, Events, Notifications, Settings cards) and Student Profile.
>>>>>>> ce26a43b9d3cb92d948e22bb1456f554e85929a2
>>>>>>> 06896c3daa9244bef5a9719c9b822d58d67eea3c

## Structure
```
lib/
<<<<<<< HEAD
  main.dart                  StatefulWidget root, owns AppSettings, themeMode
  models/app_settings.dart   Application State
  screens/                   12 screens (settings_screen.dart is new)
  widgets/custom_widgets.dart
=======
<<<<<<< HEAD
  main.dart                      theme + named routes
  screens/                       all 11 screens
=======
  main.dart                      app theme + named routes
  screens/                       splash, login, registration, dashboard, profile
>>>>>>> ce26a43b9d3cb92d948e22bb1456f554e85929a2
  widgets/custom_widgets.dart    CustomTextField, CustomButton, SectionHeader, DashboardCard
test/widget_test.dart
>>>>>>> 06896c3daa9244bef5a9719c9b822d58d67eea3c
```

## Run
```bash
flutter create .      # generates android/, ios/ etc. (existing files are kept)
flutter pub get
flutter run
```
<<<<<<< HEAD

## Key Questions
1. **State management:** controlling the data that changes over time and rebuilding the UI to match. Needed so what the user does appears on screen without restarting.
2. **Ephemeral vs Application state:** ephemeral state belongs to one widget (text typed in a field, selected tab); application state is shared by many screens (theme, language, semester, preferences).
3. **setState():** called inside a State object; it runs the given function, marks the widget dirty and schedules `build()` again.
4. **Stateful vs Stateless:** use Stateful when the widget's data changes or needs a lifecycle (forms, timers, toggles); Stateless when output depends only on its constructor values.
5. **Rebuild:** Flutter re-runs `build()` for the dirty widget, compares the new widget tree with the element tree and updates only the render objects that changed.
6. **Controls:** Checkbox (`value`, `onChanged` bool?), Radio (one `groupValue` for a group, via RadioGroup), Switch (`value`, `onChanged` bool), DropdownButton (`items`, `value`, `onChanged`), Slider (`value`, `min`, `max`, `divisions`, `onChanged`). Each stores the new value then calls setState().
7. **Sharing state:** keep it in a common ancestor (here `_StudentCompanionAppState`), pass it down through constructors, and pass a callback up to change it.
8. **Limitations of setState():** state is local to one widget, passing it down many levels is verbose (prop drilling), whole subtrees rebuild, and logic gets mixed with UI. Large apps use Provider, Riverpod or Bloc.
=======
<<<<<<< HEAD
=======

## Key Questions
1. **Widget:** a widget is an immutable description of part of the UI. Flutter builds everything (layout, padding, text, the app itself) from widgets composed together, which makes the UI uniform and easy to combine.
2. **Stateless vs Stateful:** a StatelessWidget never changes after it is built (e.g. DashboardScreen, ProfileScreen). A StatefulWidget owns a State object and can rebuild when data changes or has a lifecycle (e.g. SplashScreen with its 3-second timer, LoginScreen with its form key).
3. **Layout widgets:** Scaffold gives the page structure (app bar, body); SafeArea avoids notches and system bars; AppBar is the top bar; Container is a box for size, colour and constraints; Card is a raised rounded surface; Padding adds space around a child; SizedBox gives a fixed size or gap.
4. **TextFormField vs TextField:** TextFormField is a TextField wrapped in a FormField, so it works inside a Form and supports `validator` and `validate()`. TextField has no built-in validation.
5. **Reusable widgets:** write once, use everywhere (CustomTextField, CustomButton, DashboardCard). This cuts duplicate code, keeps the look consistent, and a change in one place updates every screen.
6. **Widget hierarchy:** widgets form a tree, e.g. MaterialApp > Scaffold > SafeArea > Column > children. Parents pass constraints down and children pass sizes up; the tree decides layout and rebuilds.
7. **Validation:** wrap fields in a Form with a GlobalKey<FormState>, give each TextFormField a validator returning an error string or null, and call `_formKey.currentState!.validate()` on submit.
8. **UI consistency:** the same colours, spacing and components make the app predictable, easier to learn and more professional, and speed up development.
>>>>>>> ce26a43b9d3cb92d948e22bb1456f554e85929a2
>>>>>>> 06896c3daa9244bef5a9719c9b822d58d67eea3c
