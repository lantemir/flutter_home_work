import 'package:flutter_home_work/home_work_30/data/repository.dart';
import 'package:flutter_home_work/home_work_30/dom/model_app.dart';

class GetGroceriesUseCase {
  GetGroceriesUseCase(this.repository);

  final GroceryRepository repository;

  Future<List<GroceryItemModel>> call() {
    return repository.getGroceries();
  }
}
