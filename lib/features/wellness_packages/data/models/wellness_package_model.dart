import 'package:flutter_starter_kit/features/wellness_packages/domain/entities/wellness_package.dart';

/// DTO that maps the JSON item from `GET /api/mobile/packages` to a Dart object.
///
/// Used only in the data layer — treated as a [WellnessPackage] everywhere
/// outside this layer (no casting needed since it extends the entity).
///
/// Example JSON item:
/// ```json
/// {
///   "id": "uuid",
///   "name": "Deep Tissue Massage",
///   "description": "...",
///   "price": 150000.0,
///   "durationMinutes": 60,
///   "createdAt": "2026-01-01T00:00:00.000Z",
///   "updatedAt": "2026-01-01T00:00:00.000Z"
/// }
/// ```
class WellnessPackageModel extends WellnessPackage {
  const WellnessPackageModel({
    required super.id,
    required super.name,
    required super.description,
    required super.price,
    required super.durationMinutes,
    required super.createdAt,
    required super.updatedAt,
  });

  factory WellnessPackageModel.fromJson(Map<String, dynamic> json) {
    return WellnessPackageModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      durationMinutes: json['durationMinutes'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }
}
