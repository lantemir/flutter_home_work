import 'package:flutter/material.dart';
import 'auth/auth_gate.dart';

class HomeWork32App extends StatelessWidget {
  const HomeWork32App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthGate(),
    );
  }
}
