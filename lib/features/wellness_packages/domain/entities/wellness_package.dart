import 'package:equatable/equatable.dart';

/// Represents a single wellness package in the domain layer.
class WellnessPackage extends Equatable {
  const WellnessPackage({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.durationMinutes,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;

  final String name;

  final String description;

  final double price;

  final int durationMinutes;

  final DateTime createdAt;

  final DateTime updatedAt;

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        price,
        durationMinutes,
        createdAt,
        updatedAt,
      ];
}
