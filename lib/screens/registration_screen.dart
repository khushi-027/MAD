import 'package:flutter/material.dart';
import '../widgets/custom_widgets.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  void _handleRegister() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration Successful! Please login.')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Account')),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            // Locked maximum constraint width layout parameters to match login styling consistency
            child: Container(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      label: 'Full Name',
                      icon: Icons.person_outline,
                      validator: (val) => val!.isEmpty ? 'Enter your name' : null,
                    ),
                    CustomTextField(
                      label: 'Student ID / Roll No',
                      icon: Icons.badge_outlined,
                      validator: (val) => val!.isEmpty ? 'Enter your roll number' : null,
                    ),
                    CustomTextField(
                      label: 'Email Address',
                      icon: Icons.email_outlined,
                      validator: (val) => val!.contains('@') ? null : 'Enter a valid email',
                    ),
                    CustomTextField(
                      label: 'Password',
                      icon: Icons.lock_outlined,
                      isPassword: true,
                      validator: (val) => val!.length >= 6 ? null : 'Password must be 6+ characters',
                    ),
                    const SizedBox(height: 24),
                    CustomButton(text: 'Register', onPressed: _handleRegister),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
