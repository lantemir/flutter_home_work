abstract class ApiItem {
  final String id;
  final String type;

  ApiItem({required this.id, required this.type});
}

class UserItem extends ApiItem {
  final String name;
  final String email;

  UserItem({
    required super.id,
    required super.type,
    required this.name,
    required this.email,
  });
}

class ProductItem extends ApiItem {
  final String title;
  final double price;

  ProductItem({
    required super.id,
    required super.type,
    required this.title,
    required this.price,
  });
}

class UnknownItem extends ApiItem {
  final Map<String, dynamic> raw;

  UnknownItem({required super.id, required super.type, required this.raw});
}
