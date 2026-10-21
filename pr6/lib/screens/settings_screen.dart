import 'package:flutter/material.dart';
import '../models/app_settings.dart';
import '../widgets/custom_widgets.dart';

/// Practical 4: Settings screen.
///
/// This screen is a StatefulWidget for two reasons:
///  1. It needs local Ephemeral State for the profile text fields while the
///     user is still typing (that draft text is only useful to this screen
///     and disappears once the user navigates away or presses Save).
///  2. It reads and writes the shared [AppSettings] Application State object
///     that was created once in main.dart and passed down here, and to the
///     Dashboard, Profile and Notifications screens.
///
/// Every control below calls `setState()` (or `widget.onSettingsChanged()`,
/// which runs `setState()` in the parent) so the UI updates immediately.
class SettingsScreen extends StatefulWidget {
  final AppSettings settings;
  final VoidCallback onSettingsChanged;

  const SettingsScreen({
    super.key,
    required this.settings,
    required this.onSettingsChanged,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Ephemeral State: local text controllers for the profile form. Their
  // content only matters to this widget until "Save Profile" is pressed.
  late final TextEditingController _nameController;
  late final TextEditingController _enrollmentController;
  late final TextEditingController _departmentController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.settings.name);
    _enrollmentController = TextEditingController(
      text: widget.settings.enrollmentNo,
    );
    _departmentController = TextEditingController(
      text: widget.settings.department,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _enrollmentController.dispose();
    _departmentController.dispose();
    super.dispose();
  }

  // Promotes the Ephemeral form state into the shared Application State.
  void _saveProfile() {
    widget.settings.name = _nameController.text.trim();
    widget.settings.enrollmentNo = _enrollmentController.text.trim();
    widget.settings.department = _departmentController.text.trim();
    widget.onSettingsChanged();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Profile updated')));
  }

  @override
  Widget build(BuildContext context) {
    final settings = widget.settings;
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          // ---------------- Student Profile Settings ----------------
          const SectionHeader(
            title: 'Student Profile Settings',
            icon: Icons.person,
          ),
          CustomTextField(
            label: 'Name',
            icon: Icons.badge,
            controller: _nameController,
          ),
          CustomTextField(
            label: 'Enrollment No.',
            icon: Icons.confirmation_number,
            controller: _enrollmentController,
          ),
          CustomTextField(
            label: 'Department',
            icon: Icons.school,
            controller: _departmentController,
          ),
          const SizedBox(height: 8),
          CustomButton(text: 'Save Profile', onPressed: _saveProfile),
          Divider(height: 40, color: cs.secondary),

          // ---------------- Theme Selection (Switch) ----------------
          const SectionHeader(
            title: 'Theme Selection',
            icon: Icons.brightness_6,
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(settings.isDarkMode ? 'Dark Mode' : 'Light Mode'),
            subtitle: const Text('Switch between light and dark theme'),
            secondary: Icon(
              settings.isDarkMode ? Icons.dark_mode : Icons.light_mode,
            ),
            value: settings.isDarkMode,
            onChanged: (value) {
              settings.isDarkMode = value;
              widget.onSettingsChanged();
            },
          ),
          Divider(height: 40, color: cs.secondary),

          // ---------------- Semester Selection (DropdownButton) ------
          const SectionHeader(
            title: 'Semester Selection',
            icon: Icons.calendar_view_month,
          ),
          DropdownButtonFormField<String>(
            initialValue: settings.semester,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.school),
            ),
            items: AppSettings.semesters
                .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                .toList(),
            onChanged: (value) {
              if (value == null) return;
              settings.semester = value;
              widget.onSettingsChanged();
            },
          ),
          Divider(height: 40, color: cs.secondary),

          // ---------------- Language Selection (Radio) ---------------
          const SectionHeader(
            title: 'Language Selection',
            icon: Icons.language,
          ),
          // RadioGroup centralizes the groupValue + onChanged for every
          // Radio/RadioListTile inside it (current Flutter Radio API).
          RadioGroup<String>(
            groupValue: settings.language,
            onChanged: (value) {
              if (value == null) return;
              settings.language = value;
              widget.onSettingsChanged();
            },
            child: Column(
              children: AppSettings.languages
                  .map(
                    (lang) => RadioListTile<String>(
                      contentPadding: EdgeInsets.zero,
                      title: Text(lang),
                      value: lang,
                    ),
                  )
                  .toList(),
            ),
          ),
          Divider(height: 40, color: cs.secondary),

          // ---------------- Notification Preferences (Checkbox) ------
          const SectionHeader(
            title: 'Notification Preferences',
            icon: Icons.notifications_active,
          ),
          ...AppSettings.notificationKeys.map(
            (key) => CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(key),
              value: settings.notificationPrefs[key] ?? false,
              onChanged: (value) {
                settings.notificationPrefs[key] = value ?? false;
                widget.onSettingsChanged();
              },
            ),
          ),
          Divider(height: 40, color: cs.secondary),

          // ---------------- Course Preferences (Checkbox) -------------
          const SectionHeader(
            title: 'Course Preferences',
            icon: Icons.menu_book,
          ),
          ...AppSettings.availableCourses.map(
            (course) => CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(course),
              value: settings.selectedCourses.contains(course),
              onChanged: (checked) {
                if (checked == true) {
                  settings.selectedCourses.add(course);
                } else {
                  settings.selectedCourses.remove(course);
                }
                widget.onSettingsChanged();
              },
            ),
          ),
          const SizedBox(height: 8),

          // ---------------- Daily study goal (Slider) -----------------
          Row(
            children: [
              Icon(Icons.timer, size: 18, color: cs.primary),
              const SizedBox(width: 6),
              Text(
                'Daily Study Goal: ${settings.dailyStudyHours.toStringAsFixed(0)} hrs',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: cs.onBackground,
                ),
              ),
            ],
          ),
          Slider(
            value: settings.dailyStudyHours,
            min: 1,
            max: 8,
            divisions: 7,
            label: '${settings.dailyStudyHours.toStringAsFixed(0)} hrs',
            onChanged: (value) {
              settings.dailyStudyHours = value;
              widget.onSettingsChanged();
            },
          ),
          Divider(height: 40, color: cs.secondary),

          // ---------------- Dashboard Customization (Switch) ----------
          const SectionHeader(
            title: 'Dashboard Customization',
            icon: Icons.dashboard_customize,
          ),
          Text(
            'Choose which modules appear on your Dashboard.',
            style: TextStyle(
              color: cs.onBackground.withOpacity(0.78),
              fontSize: 13,
            ),
          ),
          ...AppSettings.dashboardModules.map(
            (module) => SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(module),
              value: settings.dashboardVisibility[module] ?? true,
              onChanged: (value) {
                settings.dashboardVisibility[module] = value;
                widget.onSettingsChanged();
              },
            ),
          ),
        ],
      ),
    );
  }
}
