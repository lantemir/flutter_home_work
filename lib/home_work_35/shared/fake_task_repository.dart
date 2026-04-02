import 'dart:async';
import 'task_entity.dart';

class FakeTaskRepository {
  final List<TaskEntity> _items = [
    const TaskEntity(id: '1', title: 'Read about MVC', completed: false),
    const TaskEntity(id: '2', title: 'Read about MVP', completed: true),
  ];

  Future<List<TaskEntity>> loadTasks() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));

    // можно временно раскомментировать для проверки ошибок
    // throw Exception('Failed to load tasks');

    return List<TaskEntity>.from(_items);
  }

  Future<List<TaskEntity>> addTask(String title) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));

    if (title.trim().isEmpty) {
      throw Exception('Task title cannot be empty');
    }

    final task = TaskEntity(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title.trim(),
      completed: false,
    );

    _items.insert(0, task);
    return List<TaskEntity>.from(_items);
  }
}
