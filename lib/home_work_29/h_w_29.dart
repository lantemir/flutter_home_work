import 'package:flutter/material.dart';
import 'db/app_db.dart';
import 'screens/tasks_screen.dart';

class HomeWork29 extends StatefulWidget {
  const HomeWork29({super.key});

  @override
  State<HomeWork29> createState() => _HomeWork29State();
}

class _HomeWork29State extends State<HomeWork29> {
  late final AppDatabase db = AppDatabase();

  @override
  void dispose() {
    db.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TasksScreen(db: db);
  }
}
