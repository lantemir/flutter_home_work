import 'package:flutter/material.dart';

import '../shared/fake_task_repository.dart';
import '../shared/task_entity.dart';
import 'task_mvp_contract.dart';
import 'task_mvp_presenter.dart';

class TaskMvpPage extends StatefulWidget {
  const TaskMvpPage({super.key});

  @override
  State<TaskMvpPage> createState() => _TaskMvpPageState();
}

class _TaskMvpPageState extends State<TaskMvpPage> implements TaskMvpView {
  late final TaskMvpPresenter presenter;
  final TextEditingController textController = TextEditingController();

  List<TaskEntity> tasks = [];
  bool isLoading = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    presenter = TaskMvpPresenter(repository: FakeTaskRepository(), view: this);
    presenter.load();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  Future<void> _addTask() async {
    await presenter.add(textController.text);
  }

  @override
  void showLoading(bool value) {
    if (!mounted) return;
    setState(() {
      isLoading = value;
    });
  }

  @override
  void showTasks(List<TaskEntity> tasks) {
    if (!mounted) return;
    setState(() {
      this.tasks = tasks;
      errorMessage = null;
    });
  }

  @override
  void showError(String message) {
    if (!mounted) return;
    setState(() {
      errorMessage = message;
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void clearInput() {
    textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HW35 MVP')),
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
                  onPressed: isLoading ? null : _addTask,
                  child: const Text('Add'),
                ),
              ],
            ),
            const SizedBox(height: 16),

            if (isLoading) const LinearProgressIndicator(),

            if (errorMessage != null && tasks.isEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(errorMessage!),
              ),

            const SizedBox(height: 12),

            Expanded(
              child: tasks.isEmpty && !isLoading
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
