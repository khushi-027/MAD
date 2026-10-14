# Smart Student Companion - Practical 2

**Name:** Krima | **Roll No.:** 24AIML027 | **Subject:** AIUE302_MAD

Practical 2: Design Student Dashboard using Flutter Widgets.

Screens: Splash, Login, Registration, Dashboard (Attendance, Timetable,
Assignments, Notes, Events, Notifications, Settings cards) and Student Profile.

## Structure
```
lib/
  main.dart                      app theme + named routes
  screens/                       splash, login, registration, dashboard, profile
  widgets/custom_widgets.dart    CustomTextField, CustomButton, SectionHeader, DashboardCard
test/widget_test.dart
```

## Run
```bash
flutter create .      # generates android/, ios/ etc. (existing files are kept)
flutter pub get
flutter run
```

## Key Questions
1. **Widget:** a widget is an immutable description of part of the UI. Flutter builds everything (layout, padding, text, the app itself) from widgets composed together, which makes the UI uniform and easy to combine.
2. **Stateless vs Stateful:** a StatelessWidget never changes after it is built (e.g. DashboardScreen, ProfileScreen). A StatefulWidget owns a State object and can rebuild when data changes or has a lifecycle (e.g. SplashScreen with its 3-second timer, LoginScreen with its form key).
3. **Layout widgets:** Scaffold gives the page structure (app bar, body); SafeArea avoids notches and system bars; AppBar is the top bar; Container is a box for size, colour and constraints; Card is a raised rounded surface; Padding adds space around a child; SizedBox gives a fixed size or gap.
4. **TextFormField vs TextField:** TextFormField is a TextField wrapped in a FormField, so it works inside a Form and supports `validator` and `validate()`. TextField has no built-in validation.
5. **Reusable widgets:** write once, use everywhere (CustomTextField, CustomButton, DashboardCard). This cuts duplicate code, keeps the look consistent, and a change in one place updates every screen.
6. **Widget hierarchy:** widgets form a tree, e.g. MaterialApp > Scaffold > SafeArea > Column > children. Parents pass constraints down and children pass sizes up; the tree decides layout and rebuilds.
7. **Validation:** wrap fields in a Form with a GlobalKey<FormState>, give each TextFormField a validator returning an error string or null, and call `_formKey.currentState!.validate()` on submit.
8. **UI consistency:** the same colours, spacing and components make the app predictable, easier to learn and more professional, and speed up development.
