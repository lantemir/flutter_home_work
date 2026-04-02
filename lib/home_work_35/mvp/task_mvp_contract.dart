import '../shared/task_entity.dart';

abstract class TaskMvpView {
  void showLoading(bool value);
  void showTasks(List<TaskEntity> tasks);
  void showError(String message);
  void clearInput();
}
