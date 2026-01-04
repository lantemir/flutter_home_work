import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'tasks_provider.dart';
import 'tasks_page.dart';

void main() {
  runApp(const MyRootApp());
}

class MyRootApp extends StatelessWidget {
  const MyRootApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TasksProvider(),
      child: const MaterialApp(home: TasksPage()),
    );
  }
}
