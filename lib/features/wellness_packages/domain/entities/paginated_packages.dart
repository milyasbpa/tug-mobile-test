import 'package:equatable/equatable.dart';
import 'package:flutter_starter_kit/features/wellness_packages/domain/entities/wellness_package.dart';

/// Represents a paginated result set of [WellnessPackage] items.
class PaginatedPackages extends Equatable {
  const PaginatedPackages({
    required this.packages,
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPages,
  });

  final List<WellnessPackage> packages;

  final int total;

  final int page;

  final int limit;

  final int totalPages;

  /// Returns `true` when there are more pages to load.
  bool get hasNextPage => page < totalPages;

  @override
  List<Object?> get props => [packages, total, page, limit, totalPages];
}
