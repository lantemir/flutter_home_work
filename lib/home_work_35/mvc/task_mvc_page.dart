import 'package:flutter/material.dart';

import '../shared/fake_task_repository.dart';
import 'task_mvc_controller.dart';

class TaskMvcPage extends StatefulWidget {
  const TaskMvcPage({super.key});

  @override
  State<TaskMvcPage> createState() => _TaskMvcPageState();
}

class _TaskMvcPageState extends State<TaskMvcPage> {
  late final TaskMvcController controller;
  final TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller = TaskMvcController(repository: FakeTaskRepository());
    controller.addListener(_onChanged);
    controller.load();
  }

  void _onChanged() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    controller.removeListener(_onChanged);
    textController.dispose();
    super.dispose();
  }

  Future<void> _addTask() async {
    await controller.add(textController.text);

    if (controller.errorMessage == null) {
      textController.clear();
    } else if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(controller.errorMessage!)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final tasks = controller.tasks;

    return Scaffold(
      appBar: AppBar(title: const Text('HW35 MVC')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textController,
                    decoration: const InputDecoration(
                      labelText: 'Task title',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: controller.isLoading ? null : _addTask,
                  child: const Text('Add'),
                ),
              ],
            ),
            const SizedBox(height: 16),

            if (controller.isLoading) const LinearProgressIndicator(),

            if (controller.errorMessage != null && tasks.isEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(controller.errorMessage!),
              ),

            const SizedBox(height: 12),

            Expanded(
              child: tasks.isEmpty && !controller.isLoading
                  ? const Center(child: Text('No tasks'))
                  : ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (_, i) {
                        final task = tasks[i];
                        return Card(
                          child: ListTile(
                            title: Text(task.title),
                            leading: Icon(
                              task.completed
                                  ? Icons.check_circle
                                  : Icons.radio_button_unchecked,
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
