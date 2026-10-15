import 'package:flutter/material.dart';

// Reusable Input Field
class CustomTextField extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isPassword;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  const CustomTextField({
    super.key,
    required this.label,
    required this.icon,
    this.isPassword = false,
    this.validator,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    final cs = Theme.of(context).colorScheme;
=======
>>>>>>> 06896c3daa9244bef5a9719c9b822d58d67eea3c
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Theme.of(context).colorScheme.primary),
<<<<<<< HEAD
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
          fillColor: cs.surface, // theme-aware fill color
=======
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Colors.white, // Input field matches White accent
>>>>>>> 06896c3daa9244bef5a9719c9b822d58d67eea3c
        ),
      ),
    );
  }
}

// Reusable Primary Button
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
<<<<<<< HEAD
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
=======
          foregroundColor: Colors.white,
>>>>>>> 06896c3daa9244bef5a9719c9b822d58d67eea3c
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
<<<<<<< HEAD
        child: Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
=======
        child: Text(text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
>>>>>>> 06896c3daa9244bef5a9719c9b822d58d67eea3c
      ),
    );
  }
}

<<<<<<< HEAD
=======

>>>>>>> 06896c3daa9244bef5a9719c9b822d58d67eea3c
// Reusable section title used to organize content within a scrollable screen
class SectionHeader extends StatelessWidget {
  final String title;
  final IconData? icon;

  const SectionHeader({super.key, required this.title, this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          if (icon != null) ...[
<<<<<<< HEAD
            Icon(icon, size: 18, color: Theme.of(context).colorScheme.primary),
=======
            Icon(icon, size: 18, color: const Color(0xFF5D4037)),
>>>>>>> 06896c3daa9244bef5a9719c9b822d58d67eea3c
            const SizedBox(width: 6),
          ],
          Text(
            title,
<<<<<<< HEAD
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onBackground,
=======
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF5D4037),
>>>>>>> 06896c3daa9244bef5a9719c9b822d58d67eea3c
            ),
          ),
        ],
      ),
    );
  }
}

// Reusable Interactive Dashboard Card
class DashboardCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const DashboardCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0), // Reduced internal padding
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 20, // Reduced circle element boundary size
                backgroundColor: color.withOpacity(0.1),
<<<<<<< HEAD
                child: Icon(
                  icon,
                  size: 22,
                  color: color,
                ), // Reduced icon scaling size
=======
                child: Icon(icon, size: 22, color: color), // Reduced icon scaling size
>>>>>>> 06896c3daa9244bef5a9719c9b822d58d67eea3c
              ),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
<<<<<<< HEAD
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.onBackground,
=======
                style: const TextStyle(
                  fontWeight: FontWeight.bold, 
                  fontSize: 14, // More compact text sizing rules
                  color: Color(0xFF5D4037),
>>>>>>> 06896c3daa9244bef5a9719c9b822d58d67eea3c
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
