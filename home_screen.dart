import 'package:flutter/material.dart';
import '../models/user_model.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  final UserModel user;

  const HomeScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false,
              );
            },
            tooltip: 'Logout',
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(user.image),
              ),
              const SizedBox(height: 24),

              Icon(
                Icons.check_circle_outline,
                size: 60,
                color: Colors.green[600],
              ),
              const SizedBox(height: 16),

              Text(
                'Login Successful!',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              Text(
                'Welcome, ${user.fullName}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),

              Text(
                '@${user.username}',
                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(height: 8),

              Text(user.email, style: TextStyle(color: Colors.grey[500])),
            ],
          ),
        ),
      ),
    );
  }
}
