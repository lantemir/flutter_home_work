// интерфейс + Mock и Real.

import '../dom/model_app.dart';

abstract class ApiClient {
  Future<List<GroceryItemModel>> fetchGroceries();
}

/// Mock реализация:  возвращает фейковые данные.
class MockApiClient implements ApiClient {
  @override
  Future<List<GroceryItemModel>> fetchGroceries() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    return const [
      GroceryItemModel(name: "Milk (mock)", quantity: 2),
      GroceryItemModel(name: 'Bread (mock)', quantity: 1),
      GroceryItemModel(name: 'Eggs (mock)', quantity: 10),
    ];
  }
}

/// Real реализация: здесь обычно HTTP (Dio/http).
/// Чтобы не тянуть сеть/пакеты, имитируем "реальный" запрос:
class RealApiClient implements ApiClient {
  @override
  Future<List<GroceryItemModel>> fetchGroceries() async {
    await Future<void>.delayed(const Duration(milliseconds: 700));
    return const [
      GroceryItemModel(name: 'Milk', quantity: 2),
      GroceryItemModel(name: 'Apples', quantity: 5),
      GroceryItemModel(name: 'Chicken', quantity: 1),
    ];
  }
}
