import 'post_dto.dart';

/// Имитируем, что это ответ от API (JSON).
final List<Map<String, dynamic>> dummyJson = [
  {
    "id": "1",
    "title": "Coffee beans",
    "imageUrl": "https://picsum.photos/id/30/800/500",
    "createdAt": "2024-01-15T10:30:00.000Z",
    "price": 2500.0,
  },
  {
    "id": "2",
    "title": "Grocery basket",
    "imageUrl": "https://picsum.photos/id/1080/800/500",
    "createdAt": "2024-02-03T08:10:00.000Z",
    "price": 14990.0,
  },
  {
    "id": "3",
    "title": "Fresh fruits",
    "imageUrl": "https://picsum.photos/id/102/800/500",
    "createdAt": "2024-03-21T18:40:00.000Z",
    "price": 7990.0,
  },
];

/// Превращаем JSON → DTO через PostDto.fromJson()
final List<PostDto> dummyPosts = dummyJson
    .map((j) => PostDto.fromJson(j))
    .toList();
