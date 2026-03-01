import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../screens/home_screen.dart';
import '../screens/login_screen.dart';
import '../screens/tasks_screen.dart';
import 'auth_service.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = AuthService(FirebaseAuth.instance);

    return StreamBuilder<User?>(
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        // loading состояния
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final user = snapshot.data;

        if (user == null) {
          return LoginScreen(auth: auth);
        }

        if (snapshot.hasData) {
          return TasksScreen(); // 🔥 наш новый экран CRUD
        }

        return HomeScreen(auth: auth);
      },
    );
  }
}
