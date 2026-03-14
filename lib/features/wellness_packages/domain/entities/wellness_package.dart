import 'package:equatable/equatable.dart';

/// Represents a single wellness package in the domain layer.
///
/// This is a pure domain entity — no JSON parsing or platform concerns.
/// The data layer is responsible for mapping [WellnessPackageModel] to
/// this entity before it reaches the presentation layer.
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

  /// Unique identifier (UUID) of the package.
  final String id;

  /// Display name of the wellness package.
  final String name;

  /// Detailed description of the package contents.
  final String description;

  /// Price of the package in the base currency (e.g. IDR).
  final double price;

  /// Duration of the session in minutes.
  final int durationMinutes;

  /// Timestamp when the package was created.
  final DateTime createdAt;

  /// Timestamp when the package was last updated.
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
