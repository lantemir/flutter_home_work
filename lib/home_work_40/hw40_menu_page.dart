import 'package:flutter/material.dart';

import 'controller/task_list_controller.dart';
import 'model/task_item.dart';
import 'screens/task_list_page.dart';

class DemoTaskListController extends TaskListController {
  List<TaskItem> _items = [];
  bool _isLoading = false;
  String? _errorMessage;

  @override
  List<TaskItem> get items => _items;

  @override
  bool get isLoading => _isLoading;

  @override
  String? get errorMessage => _errorMessage;

  @override
  Future<void> load() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    await Future<void>.delayed(const Duration(milliseconds: 400));

    _isLoading = false;
    _items = const [
      TaskItem(id: '1', title: 'Demo task 1'),
      TaskItem(id: '2', title: 'Demo task 2'),
    ];
    notifyListeners();
  }

  @override
  Future<void> add(String title) async {
    if (title.trim().isEmpty) {
      _errorMessage = 'Title cannot be empty';
      notifyListeners();
      return;
    }

    _errorMessage = null;
    _items = [
      TaskItem(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title.trim(),
      ),
      ..._items,
    ];
    notifyListeners();
  }
}

class HomeWork40MenuPage extends StatelessWidget {
  const HomeWork40MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TaskListPage(controller: DemoTaskListController());
  }
}
