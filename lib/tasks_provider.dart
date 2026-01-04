import 'package:flutter/foundation.dart';

class TasksProvider extends ChangeNotifier {
  List<String> tasks = [];

  void addTask(String task) {
    tasks.add(task);
    notifyListeners();
  }

  void removeTask(int index) {
    tasks.removeAt(index);
    notifyListeners(); // сигнал всем, кто “слушает” этот провайдер: данные изменились, перестройте UI
  }
}
