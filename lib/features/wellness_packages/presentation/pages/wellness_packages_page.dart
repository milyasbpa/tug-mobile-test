import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_starter_kit/core/di/injection.dart';
import 'package:flutter_starter_kit/core/l10n/translations.g.dart';
import 'package:flutter_starter_kit/core/theme/app_colors.dart';
import 'package:flutter_starter_kit/core/theme/app_spacing.dart';
import 'package:flutter_starter_kit/core/theme/app_text_styles.dart';
import 'package:flutter_starter_kit/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:flutter_starter_kit/features/auth/presentation/blocs/auth_event.dart';
import 'package:flutter_starter_kit/features/wellness_packages/domain/entities/wellness_package.dart';
import 'package:flutter_starter_kit/features/wellness_packages/presentation/blocs/wellness_packages_bloc.dart';
import 'package:flutter_starter_kit/features/wellness_packages/presentation/blocs/wellness_packages_event.dart';
import 'package:flutter_starter_kit/features/wellness_packages/presentation/blocs/wellness_packages_state.dart';
import 'package:flutter_starter_kit/features/wellness_packages/presentation/widgets/wellness_package_card.dart';
import 'package:flutter_starter_kit/features/wellness_packages/presentation/widgets/wellness_package_loading.dart';
import 'package:flutter_starter_kit/features/wellness_packages/presentation/widgets/wellness_packages_empty.dart';
import 'package:flutter_starter_kit/features/wellness_packages/presentation/widgets/wellness_packages_error.dart';
import 'package:flutter_starter_kit/shared/widgets/app_loading.dart';

class WellnessPackagesPage extends StatelessWidget {
  const WellnessPackagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<WellnessPackagesBloc>()..add(const WellnessPackagesLoadRequested()),
      child: const _WellnessPackagesView(),
    );
  }
}

class _WellnessPackagesView extends StatefulWidget {
  const _WellnessPackagesView();

  @override
  State<_WellnessPackagesView> createState() => _WellnessPackagesViewState();
}

class _WellnessPackagesViewState extends State<_WellnessPackagesView> {
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();
  Timer? _debounce;
  bool _searchVisible = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onScroll() {
    final bloc = context.read<WellnessPackagesBloc>();
    final state = bloc.state;

    if (state is! WellnessPackagesLoaded) return;
    if (state.isLoadingMore) return;
    if (!state.paginatedData.hasNextPage) return;

    final atBottom = _scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200;

    if (atBottom) {
      bloc.add(const WellnessPackagesLoadMoreRequested());
    }
  }

  void _onSearchChanged(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      context.read<WellnessPackagesBloc>().add(
            WellnessPackagesLoadRequested(
              search: query.trim().isEmpty ? null : query.trim(),
            ),
          );
    });
  }

  void _toggleSearch() {
    setState(() {
      _searchVisible = !_searchVisible;
      if (!_searchVisible) {
        _searchController.clear();
        context
            .read<WellnessPackagesBloc>()
            .add(const WellnessPackagesLoadRequested());
      }
    });
  }

  Future<void> _onRefresh() async {
    final query = _searchController.text.trim();
    context.read<WellnessPackagesBloc>().add(
          WellnessPackagesLoadRequested(
            search: query.isEmpty ? null : query,
          ),
        );
    // Wait until the state changes away from Loading
    await context
        .read<WellnessPackagesBloc>()
        .stream
        .firstWhere((s) => s is! WellnessPackagesLoading);
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).wellnessPackages;
    return Scaffold(
      appBar: AppBar(
        title: _searchVisible
            ? TextField(
                controller: _searchController,
                autofocus: true,
                onChanged: _onSearchChanged,
                style: AppTextStyles.bodyMedium,
                decoration: InputDecoration(
                  hintText: t.searchHint,
                  border: InputBorder.none,
                  hintStyle: const TextStyle(color: AppColors.grey500),
                ),
              )
            : Text(
                t.title,
                style: AppTextStyles.titleLarge,
              ),
        actions: [
          IconButton(
            icon: Icon(_searchVisible ? Icons.close : Icons.search_rounded),
            tooltip:
                _searchVisible ? t.searchTooltipClose : t.searchTooltipOpen,
            onPressed: _toggleSearch,
          ),
          if (!_searchVisible)
            IconButton(
              icon: const Icon(Icons.logout),
              tooltip: 'Logout',
              onPressed: () => context.read<AuthBloc>().add(
                    const AuthLogoutRequested(),
                  ),
            ),
        ],
      ),
      body: BlocBuilder<WellnessPackagesBloc, WellnessPackagesState>(
        builder: (context, state) {
          if (state is WellnessPackagesLoading) {
            return const WellnessPackageLoadingView();
          }

          if (state is WellnessPackagesError) {
            return WellnessPackagesErrorView(message: state.message);
          }

          if (state is WellnessPackagesLoaded) {
            if (state.packages.isEmpty) {
              return const WellnessPackagesEmptyView();
            }
            return _PackagesList(
              packages: state.packages,
              isLoadingMore: state.isLoadingMore,
              scrollController: _scrollController,
              onRefresh: _onRefresh,
            );
          }

          // Initial state — show nothing while first load is in-flight
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _PackagesList extends StatelessWidget {
  const _PackagesList({
    required this.packages,
    required this.isLoadingMore,
    required this.scrollController,
    required this.onRefresh,
  });

  final List<WellnessPackage> packages;
  final bool isLoadingMore;
  final ScrollController scrollController;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.builder(
        controller: scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
        // +1 for the load-more footer slot
        itemCount: packages.length + (isLoadingMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == packages.length) {
            // Load-more spinner at the bottom of the list
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
              child: AppLoading.circular(),
            );
          }
          return WellnessPackageCard(package: packages[index]);
        },
      ),
    );
  }
}
