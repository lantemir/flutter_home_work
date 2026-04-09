import 'package:flutter/foundation.dart';

import '../model/task_item.dart';

abstract class TaskListController extends ChangeNotifier {
  List<TaskItem> get items;
  bool get isLoading;
  String? get errorMessage;

  Future<void> load();
  Future<void> add(String title);
}
