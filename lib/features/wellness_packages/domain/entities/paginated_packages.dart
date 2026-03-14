import 'package:equatable/equatable.dart';
import 'package:flutter_starter_kit/features/wellness_packages/domain/entities/wellness_package.dart';

/// Represents a paginated result set of [WellnessPackage] items.
///
/// Mirrors the `meta` object returned by the `/api/mobile/packages` endpoint.
class PaginatedPackages extends Equatable {
  const PaginatedPackages({
    required this.packages,
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPages,
  });

  /// The list of [WellnessPackage] items for the current page.
  final List<WellnessPackage> packages;

  /// Total number of packages across all pages.
  final int total;

  /// Current page number (1-based).
  final int page;

  /// Number of items per page.
  final int limit;

  /// Total number of pages available.
  final int totalPages;

  /// Returns `true` when there are more pages to load.
  bool get hasNextPage => page < totalPages;

  @override
  List<Object?> get props => [packages, total, page, limit, totalPages];
}
