import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'tasks_provider.dart';
import 'gallery_page.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({
    super.key,
    required this.isDark,
    required this.onToggleTheme,
  });

  final bool isDark;
  final VoidCallback onToggleTheme;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWide = width > 600;

    final tasks = context.watch<TasksProvider>().tasks;

    final list = tasks.isEmpty
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
          );

    final rightPanel = Padding(
      padding: EdgeInsets.all(isWide ? 24 : 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Панель',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontSize: isWide ? 26 : null),
          ),
          const SizedBox(height: 12),
          Text(
            'Всего задач: ${tasks.length}',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(fontSize: isWide ? 18 : null),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              context.read<TasksProvider>().addTask('Новая задача');
            },
            child: const Text("Добавить задачу"),
          ),
          const SizedBox(height: 8),
          Text(
            'Долгое нажатие по задаче - удаление',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
        centerTitle: true,
        actions: [
          Row(
            children: [
              const Icon(Icons.light_mode),
              Switch(value: isDark, onChanged: (_) => onToggleTheme()),
              const Icon(Icons.dark_mode),
              const SizedBox(width: 8),

              IconButton(
                tooltip: 'Галерея',
                icon: const Icon(Icons.photo_library_outlined),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const GalleryPage()),
                  );
                },
              ),
            ],
          ),
        ],
      ),

      body: Padding(
        padding: EdgeInsets.all(isWide ? 24 : 12),
        child: isWide
            ? Row(
                children: [
                  Expanded(child: list),
                  const SizedBox(width: 16),
                  SizedBox(width: 280, child: rightPanel),
                ],
              )
            : Column(
                children: [
                  Expanded(child: list),
                  const SizedBox(height: 12),
                  rightPanel,
                ],
              ),
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
