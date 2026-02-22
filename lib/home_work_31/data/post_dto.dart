import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_dto.freezed.dart';
part 'post_dto.g.dart';

/// DTO (Data Transfer Object) — модель, которая соответствует данным от API / JSON.
/// Freezed генерирует:
/// - copyWith
/// - == по значениям
/// - toString
/// JsonSerializable генерирует:
/// - fromJson / toJson
@freezed
class PostDto with _$PostDto {
  const factory PostDto({
    required String id,
    required String title,
    required String imageUrl,

    /// json_serializable умеет DateTime (ISO-строка ↔ DateTime)
    required DateTime createdAt,

    /// пример для intl (валюта)
    required double price,
  }) = _PostDto;

  /// Автогенерируемый парсер JSON → объект
  factory PostDto.fromJson(Map<String, dynamic> json) =>
      _$PostDtoFromJson(json);
}
