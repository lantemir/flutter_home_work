import 'package:flutter/material.dart';
import '../db/app_db.dart';
import '../db/dao.dart';
import '../db/tables.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key, required this.db});
  final AppDatabase db;

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  late final TasksDao dao;

  TaskSort _sort = TaskSort.dateDesc;
  bool _useWatch = true; // сравнение watch vs get

  @override
  void initState() {
    super.initState();
    dao = TasksDao(widget.db); // ✅ widget используем только после initState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HW29 — Drift Tasks'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _openEditor(context),
          ),
        ],
      ),
      body: Column(
        children: [
          _Controls(
            sort: _sort,
            useWatch: _useWatch,
            onSortChanged: (s) => setState(() => _sort = s),
            onModeChanged: (v) => setState(() => _useWatch = v),
            onRefreshOnce: () => setState(() {}), // для get() режима
          ),
          const Divider(height: 1),
          Expanded(
            child: _useWatch
                ? StreamBuilder<List<Task>>(
                    stream: dao.watchTasks(_sort),
                    builder: (context, snapshot) {
                      final items = snapshot.data;
                      if (items == null) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return _TasksList(
                        tasks: items,
                        onToggle: dao.toggleCompleted,
                        onEdit: (t) => _openEditor(context, task: t),
                        onDelete: (t) => dao.deleteTask(t.id),
                      );
                    },
                  )
                : FutureBuilder<List<Task>>(
                    future: dao.getTasksOnce(_sort),
                    builder: (context, snapshot) {
                      final items = snapshot.data;
                      if (items == null) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return _TasksList(
                        tasks: items,
                        onToggle: dao.toggleCompleted,
                        onEdit: (t) => _openEditor(context, task: t),
                        onDelete: (t) =>
                            dao.deleteTask(t.id).then((_) => setState(() {})),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Future<void> _openEditor(BuildContext context, {Task? task}) async {
    final res = await showDialog<_TaskEditorResult>(
      context: context,
      builder: (_) => _TaskEditorDialog(dao: dao, task: task),
    );

    // для get() режима надо вручную обновить UI
    if (!_useWatch && res != null) setState(() {});
  }
}

class _Controls extends StatelessWidget {
  const _Controls({
    required this.sort,
    required this.useWatch,
    required this.onSortChanged,
    required this.onModeChanged,
    required this.onRefreshOnce,
  });

  final TaskSort sort;
  final bool useWatch;
  final ValueChanged<TaskSort> onSortChanged;
  final ValueChanged<bool> onModeChanged;
  final VoidCallback onRefreshOnce;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          DropdownButton<TaskSort>(
            value: sort,
            onChanged: (v) => onSortChanged(v!),
            items: const [
              DropdownMenuItem(value: TaskSort.dateDesc, child: Text('Date ↓')),
              DropdownMenuItem(value: TaskSort.dateAsc, child: Text('Date ↑')),
              DropdownMenuItem(
                value: TaskSort.priorityDesc,
                child: Text('Priority ↓'),
              ),
              DropdownMenuItem(
                value: TaskSort.priorityAsc,
                child: Text('Priority ↑'),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('watch()'),
              Switch(value: useWatch, onChanged: onModeChanged),
              const Text('get()'),
            ],
          ),
          if (!useWatch)
            OutlinedButton.icon(
              onPressed: onRefreshOnce,
              icon: const Icon(Icons.refresh),
              label: const Text('Refresh'),
            ),
        ],
      ),
    );
  }
}

class _TasksList extends StatelessWidget {
  const _TasksList({
    required this.tasks,
    required this.onToggle,
    required this.onEdit,
    required this.onDelete,
  });

  final List<Task> tasks;
  final Future<void> Function(Task) onToggle;
  final void Function(Task) onEdit;
  final Future<void> Function(Task) onDelete;

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      return const Center(child: Text('No tasks yet'));
    }

    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (_, i) {
        final t = tasks[i];
        return ListTile(
          leading: Checkbox(
            value: t.isCompleted,
            onChanged: (_) => onToggle(t),
          ),
          title: Text(t.title, maxLines: 1, overflow: TextOverflow.ellipsis),
          subtitle: Text('Priority: ${t.priority.name} • ${t.createdAt}'),
          trailing: Wrap(
            spacing: 8,
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => onEdit(t),
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => onDelete(t),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _TaskEditorResult {
  const _TaskEditorResult();
}

class _TaskEditorDialog extends StatefulWidget {
  const _TaskEditorDialog({required this.dao, this.task});
  final TasksDao dao;
  final Task? task;

  @override
  State<_TaskEditorDialog> createState() => _TaskEditorDialogState();
}

class _TaskEditorDialogState extends State<_TaskEditorDialog> {
  late final TextEditingController title;
  late final TextEditingController desc;
  late final TextEditingController tags;

  late TaskPriority priority;
  late bool done;

  @override
  void initState() {
    super.initState();

    // ✅ все обращения к widget.* только тут (или в build)
    title = TextEditingController(text: widget.task?.title ?? '');
    desc = TextEditingController(text: widget.task?.description ?? '');
    tags = TextEditingController(text: '');

    priority = widget.task?.priority ?? TaskPriority.medium;
    done = widget.task?.isCompleted ?? false;
  }

  @override
  void dispose() {
    title.dispose();
    desc.dispose();
    tags.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.task == null ? 'Add task' : 'Edit task'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: title,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: desc,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 10),
            DropdownButton<TaskPriority>(
              value: priority,
              onChanged: (v) => setState(() => priority = v!),
              items: TaskPriority.values
                  .map((p) => DropdownMenuItem(value: p, child: Text(p.name)))
                  .toList(),
            ),
            Row(
              children: [
                const Text('Completed'),
                Checkbox(
                  value: done,
                  onChanged: (v) => setState(() => done = v ?? false),
                ),
              ],
            ),
            TextField(
              controller: tags,
              decoration: const InputDecoration(
                labelText: 'Tags (comma separated)',
                hintText: 'work, urgent, home',
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            final tagNames = tags.text
                .split(',')
                .map((e) => e.trim())
                .where((e) => e.isNotEmpty)
                .toList();

            if (widget.task == null) {
              await widget.dao.addTask(
                title: title.text.trim(),
                description: desc.text.trim().isEmpty ? null : desc.text.trim(),
                priority: priority,
                tagNames: tagNames,
              );
            } else {
              await widget.dao.updateTask(
                taskId: widget.task!.id,
                title: title.text.trim(),
                description: desc.text.trim().isEmpty ? null : desc.text.trim(),
                priority: priority,
                isCompleted: done,
                tagNames: tagNames,
              );
            }

            if (context.mounted)
              Navigator.pop(context, const _TaskEditorResult());
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
