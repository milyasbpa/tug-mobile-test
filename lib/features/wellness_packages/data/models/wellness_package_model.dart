import 'package:flutter_starter_kit/features/wellness_packages/domain/entities/wellness_package.dart';

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
