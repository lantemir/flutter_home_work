import 'package:flutter/material.dart';

import '../shared/error_handler.dart';
import '../shared/fake_task_repository.dart';
import '../shared/task_entity.dart';

class TaskMvcController extends ChangeNotifier {
  final FakeTaskRepository repository;

  TaskMvcController({required this.repository});

  List<TaskEntity> tasks = [];
  bool isLoading = false;
  String? errorMessage;

  Future<void> load() async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      tasks = await repository.loadTasks();
    } catch (e) {
      errorMessage = ErrorHandler.map(e);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> add(String title) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      tasks = await repository.addTask(title);
    } catch (e) {
      errorMessage = ErrorHandler.map(e);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
