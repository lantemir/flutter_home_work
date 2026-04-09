import 'package:flutter_home_work/home_work_40/controller/task_list_controller.dart';
import 'package:flutter_home_work/home_work_40/model/task_item.dart';

enum FakeScenario { empty, loadingThenItems, error, items }

class FakeTaskListController extends TaskListController {
  FakeScenario scenario;

  FakeTaskListController({this.scenario = FakeScenario.empty});

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
    switch (scenario) {
      case FakeScenario.empty:
        _isLoading = false;
        _items = [];
        _errorMessage = null;
        notifyListeners();
        break;

      case FakeScenario.loadingThenItems:
        _isLoading = true;
        _items = [];
        _errorMessage = null;
        notifyListeners();

        await Future<void>.delayed(const Duration(milliseconds: 100));

        _isLoading = false;
        _items = const [
          TaskItem(id: '1', title: 'Task A'),
          TaskItem(id: '2', title: 'Task B'),
        ];
        notifyListeners();
        break;

      case FakeScenario.error:
        _isLoading = false;
        _items = [];
        _errorMessage = 'Failed to load items';
        notifyListeners();
        break;

      case FakeScenario.items:
        _isLoading = false;
        _items = const [
          TaskItem(id: '1', title: 'Task 1'),
          TaskItem(id: '2', title: 'Task 2'),
        ];
        _errorMessage = null;
        notifyListeners();
        break;
    }
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
