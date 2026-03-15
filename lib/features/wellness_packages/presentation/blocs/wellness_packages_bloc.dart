import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_starter_kit/features/wellness_packages/domain/entities/get_packages_params.dart';
import 'package:flutter_starter_kit/features/wellness_packages/domain/usecases/get_wellness_packages_use_case.dart';
import 'package:flutter_starter_kit/features/wellness_packages/presentation/blocs/wellness_packages_event.dart';
import 'package:flutter_starter_kit/features/wellness_packages/presentation/blocs/wellness_packages_state.dart';
import 'package:injectable/injectable.dart';

/// Manages the lifecycle for the Wellness Packages feature.
///
/// Supports initial load, pull-to-refresh, and infinite-scroll pagination.
/// Inject via `getIt<WellnessPackagesBloc>()` and provide it with
/// [BlocProvider] at the page level.
@injectable
class WellnessPackagesBloc
    extends Bloc<WellnessPackagesEvent, WellnessPackagesState> {
  WellnessPackagesBloc(this._getPackages)
      : super(const WellnessPackagesInitial()) {
    on<WellnessPackagesLoadRequested>(_onLoadRequested);
    on<WellnessPackagesLoadMoreRequested>(_onLoadMoreRequested);
  }

  final GetWellnessPackagesUseCase _getPackages;

  /// Loads the first page of packages, optionally filtered by a search query.
  ///
  /// Resets any existing list — use this for initial load and pull-to-refresh.
  Future<void> _onLoadRequested(
    WellnessPackagesLoadRequested event,
    Emitter<WellnessPackagesState> emit,
  ) async {
    emit(const WellnessPackagesLoading());
    final result = await _getPackages(
      GetPackagesParams(search: event.search),
    );
    result.fold(
      (failure) => emit(WellnessPackagesError(message: failure.message)),
      (data) => emit(
        WellnessPackagesLoaded(packages: data.packages, paginatedData: data),
      ),
    );
  }

  /// Appends the next page of packages to the existing list.
  ///
  /// No-op if the current state is not [WellnessPackagesLoaded] or
  /// [PaginatedPackages.hasNextPage] is false.
  Future<void> _onLoadMoreRequested(
    WellnessPackagesLoadMoreRequested event,
    Emitter<WellnessPackagesState> emit,
  ) async {
    final current = state;
    if (current is! WellnessPackagesLoaded) return;
    if (!current.paginatedData.hasNextPage) return;

    emit(current.copyWith(isLoadingMore: true));

    final nextPage = current.paginatedData.page + 1;
    final result = await _getPackages(GetPackagesParams(page: nextPage));
    result.fold(
      (failure) => emit(WellnessPackagesError(message: failure.message)),
      (data) => emit(
        WellnessPackagesLoaded(
          packages: [...current.packages, ...data.packages],
          paginatedData: data,
        ),
      ),
    );
  }
}
