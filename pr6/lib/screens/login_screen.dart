import 'package:flutter/material.dart';
import '../widgets/custom_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacementNamed(context, '/dashboard');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            // FIXED: Locked width dimension to prevent it from getting too broad
            child: Container(
              constraints: const BoxConstraints(maxWidth: 400), 
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.school, size: 80, color: Theme.of(context).colorScheme.primary),
                    const SizedBox(height: 16),
                    Text(
                      'Welcome Back', 
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary),
                    ),
                    const SizedBox(height: 32),
                    CustomTextField(
                      label: 'Student Email',
                      icon: Icons.email_outlined,
                      validator: (val) => val!.contains('@') ? null : 'Enter a valid university email',
                    ),
                    CustomTextField(
                      label: 'Password',
                      icon: Icons.lock_outlined,
                      isPassword: true,
                      validator: (val) => val!.length >= 6 ? null : 'Password must be 6+ characters',
                    ),
                    const SizedBox(height: 24),
                    CustomButton(text: 'Login', onPressed: _handleLogin),
                    TextButton(
                      onPressed: () => Navigator.pushNamed(context, '/register'),
                      child: Text(
                        "Don't have an account? Register here",
                        style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                      ),
                    ),
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
