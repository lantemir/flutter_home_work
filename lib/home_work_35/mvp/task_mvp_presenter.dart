import '../shared/error_handler.dart';
import '../shared/fake_task_repository.dart';
import 'task_mvp_contract.dart';

class TaskMvpPresenter {
  final FakeTaskRepository repository;
  final TaskMvpView view;

  TaskMvpPresenter({required this.repository, required this.view});

  Future<void> load() async {
    try {
      view.showLoading(true);
      final tasks = await repository.loadTasks();
      view.showTasks(tasks);
    } catch (e) {
      view.showError(ErrorHandler.map(e));
    } finally {
      view.showLoading(false);
    }
  }

  Future<void> add(String title) async {
    try {
      view.showLoading(true);
      final tasks = await repository.addTask(title);
      view.showTasks(tasks);
      view.clearInput();
    } catch (e) {
      view.showError(ErrorHandler.map(e));
    } finally {
      view.showLoading(false);
    }
  }
}
