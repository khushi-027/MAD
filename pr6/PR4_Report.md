# Practical 4 — State Management for Dynamic Application Features

Continues directly from Practical 3 (`student_dash`, six module screens +
named routing + brown/cream theme). All Practical 3 screens and navigation
are unchanged; Practical 4 adds a Settings module and wires it into the
existing screens using `setState()`.

## What was added

| Layer | File | Purpose |
|---|---|---|
| Model | `lib/models/app_settings.dart` | Holds the shared **Application State**: profile, semester, theme, language, notification prefs, course prefs, study-hours goal, dashboard visibility |
| Root | `lib/main.dart` | `StudentCompanionApp` converted to `StatefulWidget`; owns the one `AppSettings` instance and a `_updateSettings()` method that calls `setState()`; light/dark `ThemeData` switches on `settings.themeMode` |
| Screen | `lib/screens/settings_screen.dart` | New module: Student Profile Settings, Theme Selection, Semester Selection, Language Selection, Notification Preferences, Course Preferences, Study-goal Slider, Dashboard Customization |
| Screen | `lib/screens/dashboard_screen.dart` | Greets the user by the live name, shows semester/course stats, hides/shows module cards per Dashboard Customization, "Settings" tile now navigates instead of showing a placeholder snackbar |
| Screen | `lib/screens/profile_screen.dart` | Displays live profile/semester/language/theme/course values from `AppSettings`; edit icon jumps to Settings |
| Screen | `lib/screens/notifications_screen.dart` | Filters the notification list by the Notification Preferences checkboxes |

No new packages were added — everything uses the Flutter `material` library
already in `pubspec.yaml`.

## Key Questions / Analysis

**1. What is State Management in Flutter and why is it required?**
State is any data that can change while the app runs and that affects what
is drawn on screen (a checkbox's checked flag, a theme mode, a list of
selected courses). State Management is the set of techniques used to store
that data, update it in response to user actions, and make Flutter redraw
only the parts of the UI that depend on it. It is required because Flutter's
widgets are otherwise immutable descriptions of the UI — without a
mechanism to say "this value changed, rebuild," the screen would stay frozen
after the first frame no matter what the user does.

**2. Ephemeral State vs Application State**
*Ephemeral (local) state* belongs to a single widget and is lost once that
widget is removed from the tree — e.g. the text currently typed into the
Settings profile form's `TextEditingController`s before "Save Profile" is
pressed, or which tab is selected in a `TabBar`. *Application state* is
shared across more than one part of the app and needs to survive
navigation — e.g. the `AppSettings` object in this project: the theme mode,
semester, and notification preferences are all read by the Dashboard,
Profile, Notifications and Settings screens, so a single instance is created
once in `main.dart` and passed down rather than being owned by any one
screen.

**3. How `setState()` works**
`setState()` is a method on `State<T>` that takes a callback, runs it
synchronously (usually just to mutate a few fields), and then marks the
widget as "dirty." Flutter schedules a rebuild of that `State` object's
`build()` method on the next frame, producing a new widget subtree that the
framework diffs against the old one and patches into the real render tree.
Calling `setState()` outside a `State` object, or after the widget has been
disposed, throws an error, which is why it is always called on `this` inside
a `State` class (directly, or, as in `SettingsScreen`, indirectly through a
callback such as `widget.onSettingsChanged`, which itself calls `setState()`
in the parent `_StudentCompanionAppState`).

**4. When to prefer StatefulWidget over StatelessWidget**
Use `StatefulWidget` when a widget needs to hold onto mutable data across
rebuilds and change what it displays in response to events — user input,
timers, animations, or (as here) a passed-in mutable model it needs local
controllers for. `SettingsScreen` is stateful because it owns
`TextEditingController`s. `DashboardScreen` and `ProfileScreen` stay
`StatelessWidget` even though the data they show changes, because they hold
no state of their own — they simply read the `AppSettings` object they were
given and rebuild whenever their parent rebuilds them with new data.

**5. How Flutter rebuilds widgets after a state change**
After `setState()` marks a `State` dirty, Flutter's pipeline calls that
`State`'s `build()` method, producing a new `Element`/widget tree. Flutter
then walks the new tree alongside the previous one (the "diffing" or
reconciliation step) and updates only the `RenderObject`s whose
configuration actually changed, instead of tearing down and rebuilding the
whole screen. This is why toggling a `Switch` in `SettingsScreen` redraws
that tile and the parts of the app that depend on the changed value, without
resetting scroll positions or losing the state of unrelated widgets.

**6. Checkbox, Radio, Switch, DropdownButton, Slider — how they were implemented**
- **Checkbox** (`CheckboxListTile`): Notification Preferences and Course
  Preferences. Each tile's `value` reads a boolean from `settings`, and
  `onChanged` writes the new value back and calls `onSettingsChanged()`.
- **Radio** (`RadioListTile` inside `RadioGroup`): Language Selection. A
  single `RadioGroup<String>` wraps three `RadioListTile`s so only one
  language can be selected at a time; `RadioGroup.onChanged` updates
  `settings.language`.
- **Switch** (`SwitchListTile`): Theme Selection (light/dark) and Dashboard
  Customization (one switch per module).
- **DropdownButton** (`DropdownButtonFormField`): Semester Selection, listing
  Semester I–VIII from `AppSettings.semesters`.
- **Slider**: a "Daily Study Goal" preference (1–8 hours, 7 divisions) —
  an additional customization control beyond the required set.

**7. How multiple widgets share the same application state**
A single `AppSettings` instance is created once, in
`_StudentCompanionAppState`, and passed as a constructor parameter to every
screen route that needs it (`DashboardScreen`, `ProfileScreen`,
`NotificationsScreen`, `SettingsScreen`). Because `AppSettings` is a mutable
object (not a `const` value), any screen holding a reference to it can
change its fields directly; it then calls the shared `onSettingsChanged`
callback, which calls `setState()` on the top-level `State` object, causing
`MaterialApp` — and therefore every screen currently on the stack — to
rebuild with the new values.

**8. Limitations of `setState()` in large-scale applications**
`setState()` only tells the *enclosing* `State` object to rebuild, so
sharing state across distant screens (as done here) requires either lifting
state all the way up to a common ancestor and passing it down through every
constructor, or wiring manual callbacks — both of which get unwieldy as the
app grows ("prop drilling"). It also rebuilds the whole `build()` method of
that State, with no fine-grained way to rebuild only the widgets that
actually depend on one particular value, which can hurt performance in large
widget trees. There is no built-in caching, dependency injection, or
separation between business logic and UI, which makes testing and reuse
harder. This is exactly the gap that Provider, Riverpod, and Bloc are
designed to close (see Advanced Extension below).

## Advanced Extension — setState() vs Provider / Riverpod / Bloc

- **setState()** (used here): simplest option, no dependencies, state and UI
  logic live together in the widget tree; state has to be passed down
  explicitly and every screen holding it must be rebuilt manually.
- **Provider**: wraps an `InheritedWidget`; a `ChangeNotifier` (similar in
  shape to this project's `AppSettings`, but calling `notifyListeners()`
  instead of a manual callback) is exposed to descendants, and only widgets
  that call `context.watch`/`Consumer` rebuild — no prop drilling, and more
  granular rebuilds than `setState()`.
- **Riverpod**: a compile-time-safe evolution of Provider that does not
  need `BuildContext` to read state, catches missing-provider errors at
  compile time, and makes state easy to unit-test outside the widget tree.
- **Bloc**: separates state into immutable `State` classes and business
  logic into `Bloc`/`Cubit` classes that respond to `Event`s; UI only
  dispatches events and listens for state changes, which enforces a strict
  separation between UI and logic and scales well for large teams, at the
  cost of more boilerplate for simple screens.

For this project's scale (one `AppSettings` object read by four screens),
`setState()` with a shared mutable model is proportionate. If a fifth
independent settings area were added, or if screens needed to react to only
one field changing, migrating `AppSettings` to a `ChangeNotifier` consumed
through `Provider` would remove the need to manually pass
`onSettingsChanged` through every constructor.
