import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../model/user.dart';
import '../repository/user_repository.dart';
import '../repository/hive_user_repository_impl.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  final UserRepository _userRepo = HiveUserRepositoryImpl();

  String? _error;

  Future<void> _handleSignup() async {
    try {
      final user = User(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        username: _usernameController.text.trim(),
        // 注册时以下字段默认为""或0或0.0
        gender: "", 
        weight: 0.0,
        height: 0.0,
        age: 0,
        purpose: "",
      );
      await _userRepo.registerUser(user);
      context.go('/welcome'); // 注册成功 -> Welcome Page
    } catch (e) {
      setState(() {
        _error = e.toString().replaceAll('Exception:', '').trim();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            if (_error != null)
              Text(_error!, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _handleSignup,
              child: const Text('Register'),
            ),
            TextButton(
              onPressed: () => context.go('/'),
              child: const Text('Already have an account? Login'),
            ),
          ],
        ),
      ),
    );
  }
}
