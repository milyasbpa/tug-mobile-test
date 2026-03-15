import 'package:equatable/equatable.dart';
import 'package:flutter_starter_kit/features/wellness_packages/domain/entities/paginated_packages.dart';
import 'package:flutter_starter_kit/features/wellness_packages/domain/entities/wellness_package.dart';

/// Base class for all states emitted by [WellnessPackagesBloc].
sealed class WellnessPackagesState extends Equatable {
  const WellnessPackagesState();

  @override
  List<Object?> get props => [];
}

/// Initial state before any load has been requested.
final class WellnessPackagesInitial extends WellnessPackagesState {
  const WellnessPackagesInitial();
}

/// A full-page load is in progress (first page or refresh).
final class WellnessPackagesLoading extends WellnessPackagesState {
  const WellnessPackagesLoading();
}

/// Packages have been loaded successfully.
///
/// [packages] is the accumulated list across all loaded pages.
/// [paginatedData] holds the latest API response (used for pagination meta).
/// [isLoadingMore] is `true` while the next page is being fetched.
final class WellnessPackagesLoaded extends WellnessPackagesState {
  const WellnessPackagesLoaded({
    required this.packages,
    required this.paginatedData,
    this.isLoadingMore = false,
  });

  final List<WellnessPackage> packages;
  final PaginatedPackages paginatedData;
  final bool isLoadingMore;

  /// Returns a copy with the specified fields replaced.
  WellnessPackagesLoaded copyWith({
    List<WellnessPackage>? packages,
    PaginatedPackages? paginatedData,
    bool? isLoadingMore,
  }) {
    return WellnessPackagesLoaded(
      packages: packages ?? this.packages,
      paginatedData: paginatedData ?? this.paginatedData,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object?> get props => [packages, paginatedData, isLoadingMore];
}

/// A load operation failed with a user-facing [message].
final class WellnessPackagesError extends WellnessPackagesState {
  const WellnessPackagesError({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}
