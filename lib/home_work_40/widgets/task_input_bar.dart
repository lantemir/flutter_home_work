import 'package:flutter/material.dart';

class TaskInputBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onAddPressed;
  final bool enabled;

  const TaskInputBar({
    super.key,
    required this.controller,
    required this.onAddPressed,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            key: const Key('task_input'),
            controller: controller,
            decoration: const InputDecoration(
              labelText: 'Task title',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          key: const Key('add_task_button'),
          onPressed: enabled ? onAddPressed : null,
          child: const Text('Add'),
        ),
      ],
    );
  }
}
