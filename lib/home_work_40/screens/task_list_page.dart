import 'package:flutter/material.dart';

import '../controller/task_list_controller.dart';
import '../model/task_item.dart';
import '../widgets/task_input_bar.dart';
import 'task_details_page.dart';

class TaskListPage extends StatefulWidget {
  final TaskListController controller;

  const TaskListPage({super.key, required this.controller});

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  late final TextEditingController textController;

  TaskListController get controller => widget.controller;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    controller.addListener(_onChanged);
    controller.load();
  }

  void _onChanged() {
    if (!mounted) return;

    setState(() {});

    final error = controller.errorMessage;
    if (error != null && error.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(key: const Key('error_snackbar'), content: Text(error)),
      );
    }
  }

  @override
  void dispose() {
    controller.removeListener(_onChanged);
    textController.dispose();
    super.dispose();
  }

  Future<void> _onAddPressed() async {
    await controller.add(textController.text);
    if (controller.errorMessage == null) {
      textController.clear();
    }
  }

  void _openDetails(TaskItem item) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => TaskDetailsPage(item: item)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = controller.items;
    final isLoading = controller.isLoading;
    final hasError =
        controller.errorMessage != null && controller.errorMessage!.isNotEmpty;

    return Scaffold(
      appBar: AppBar(title: const Text('HW40 Task List')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TaskInputBar(
              controller: textController,
              onAddPressed: _onAddPressed,
              enabled: !isLoading,
            ),
            const SizedBox(height: 16),

            if (isLoading)
              const LinearProgressIndicator(key: Key('loading_indicator')),

            if (!isLoading && items.isEmpty && !hasError)
              const Expanded(
                child: Center(
                  child: Text('No items', key: Key('empty_state_text')),
                ),
              )
            else if (!isLoading && items.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  key: const Key('task_list'),
                  itemCount: items.length,
                  itemBuilder: (_, index) {
                    final item = items[index];
                    return ListTile(
                      key: Key('task_tile_${item.id}'),
                      title: Text(item.title),
                      onTap: () => _openDetails(item),
                    );
                  },
                ),
              )
            else if (!isLoading && hasError && items.isEmpty)
              Expanded(
                child: Center(
                  child: Text(
                    controller.errorMessage!,
                    key: const Key('error_text'),
                  ),
                ),
              )
            else
              const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
