import 'package:flutter_home_work/home_work_30/data/api_client.dart';
import 'package:flutter_home_work/home_work_30/dom/model_app.dart';

abstract class GroceryRepository {
  Future<List<GroceryItemModel>> getGroceries();
}

class GroceryRepositoryImpl implements GroceryRepository {
  GroceryRepositoryImpl(this.apiClient);

  final ApiClient apiClient;

  @override
  Future<List<GroceryItemModel>> getGroceries() {
    return apiClient.fetchGroceries();
  }
}
