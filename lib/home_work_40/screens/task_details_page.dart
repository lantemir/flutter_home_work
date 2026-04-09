import 'package:flutter/material.dart';

import '../model/task_item.dart';

class TaskDetailsPage extends StatelessWidget {
  final TaskItem item;

  const TaskDetailsPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Task Details')),
      body: Center(
        child: Text(
          item.title,
          key: const Key('details_title'),
          style: const TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}
