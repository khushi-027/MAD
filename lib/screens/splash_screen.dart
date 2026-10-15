import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    final cs = Theme.of(context).colorScheme;
=======
>>>>>>> 06896c3daa9244bef5a9719c9b822d58d67eea3c
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
<<<<<<< HEAD
            Icon(Icons.school_rounded, size: 100, color: cs.onPrimary),
            const SizedBox(height: 16),
            Text(
              'Smart Student Companion',
              style: TextStyle(
                color: cs.onPrimary,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            CircularProgressIndicator(color: cs.onPrimary),
=======
            const Icon(Icons.school_rounded, size: 100, color: Colors.white),
            const SizedBox(height: 16),
            const Text(
              'Smart Student Companion',
              style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            const CircularProgressIndicator(color: Colors.white),
>>>>>>> 06896c3daa9244bef5a9719c9b822d58d67eea3c
          ],
        ),
      ),
    );
  }
}
