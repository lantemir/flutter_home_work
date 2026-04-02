import 'api_models.dart';

class ApiResponseFactory {
  static ApiItem parse(Map<String, dynamic> json) {
    final type = json['type']?.toString() ?? 'unknown';

    switch (type) {
      case 'user':
        return UserItem(
          id: json['id'].toString(),
          type: type,
          name: json['name']?.toString() ?? '',
          email: json['email']?.toString() ?? '',
        );

      case 'product':
        return ProductItem(
          id: json['id'].toString(),
          type: type,
          title: json['title']?.toString() ?? '',
          price: (json['price'] as num?)?.toDouble() ?? 0,
        );

      default:
        return UnknownItem(
          id: json['id']?.toString() ?? '0',
          type: type,
          raw: json,
        );
    }
  }
}
