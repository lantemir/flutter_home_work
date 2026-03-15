import 'package:flutter/material.dart';
import 'screens/notifications_home_screen.dart';

class HomeWork34App extends StatelessWidget {
  const HomeWork34App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HW34 Push Notifications',
      theme: ThemeData(useMaterial3: true),
      home: const NotificationsHomeScreen(),
    );
  }
}
