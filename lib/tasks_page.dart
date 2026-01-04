import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'tasks_provider.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tasks = context.watch<TasksProvider>().tasks;

    return Scaffold(
      appBar: AppBar(title: const Text('Tasks'), centerTitle: true),
      body: tasks.isEmpty
          ? const Center(child: Text("Пока нет задач"))
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(tasks[index]),
                  onLongPress: () {
                    context.read<TasksProvider>().removeTask(index);
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<TasksProvider>().addTask('Новая задача');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
