import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../services/task_service.dart';
import '../screens/task_edit_screen.dart';

class TaskTile extends StatelessWidget {
  final Task task;

  const TaskTile({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final service = TaskService();

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => TaskEditScreen(task: task)),
          );
        },

        // Чекбокс completed
        leading: Checkbox(
          value: task.completed,
          onChanged: (value) async {
            await service.updateTask(
              Task(
                id: task.id,
                title: task.title,
                description: task.description,
                completed: value ?? false,
                category: task.category,
                userId: task.userId,
                createdAt: task.createdAt,
              ),
            );
          },
        ),

        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.completed ? TextDecoration.lineThrough : null,
          ),
        ),

        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (task.description != null && task.description!.isNotEmpty)
              Text(task.description!),
            const SizedBox(height: 4),
            Chip(
              label: Text(task.category),
              visualDensity: VisualDensity.compact,
            ),
          ],
        ),

        trailing: IconButton(
          icon: const Icon(Icons.delete_outline),
          onPressed: () async {
            await service.deleteTask(task.id);
          },
        ),
      ),
    );
  }
}
