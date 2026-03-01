import 'package:flutter/material.dart';
import '../services/task_service.dart';
import '../widgets/task_tile.dart';
import '../models/task_model.dart';
import 'task_edit_screen.dart';

class TasksScreen extends StatelessWidget {
  final TaskService _service = TaskService();

  TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Tasks")),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const TaskEditScreen()),
          );
        },
      ),
      body: StreamBuilder<List<Task>>(
        stream: _service.streamTasks(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Ошибка загрузки"));
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final tasks = snapshot.data!;

          if (tasks.isEmpty) {
            return const Center(child: Text("Нет задач"));
          }

          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (_, i) => TaskTile(task: tasks[i]),
          );
        },
      ),
    );
  }
}
