import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/core/di/injection.dart';
import 'package:flutter_starter_kit/core/router/go_router_refresh_stream.dart';
import 'package:flutter_starter_kit/core/router/route_names.dart';
import 'package:flutter_starter_kit/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:flutter_starter_kit/features/auth/presentation/blocs/auth_state.dart';
import 'package:flutter_starter_kit/features/auth/presentation/pages/login_page.dart';
import 'package:flutter_starter_kit/features/wellness_packages/presentation/pages/wellness_packages_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: RouteNames.packages,
  debugLogDiagnostics: true,
  refreshListenable: GoRouterRefreshStream(getIt<AuthBloc>().stream),
  redirect: (context, state) {
    final authState = getIt<AuthBloc>().state;
    final isAuthenticated = authState is AuthAuthenticated;
    final isPending = authState is AuthInitial || authState is AuthLoading;
    final location = state.matchedLocation;
    final onAuthScreen = location == RouteNames.login;
    if (isPending) return null;
    if (!isAuthenticated && !onAuthScreen) return RouteNames.login;
    if (isAuthenticated && onAuthScreen) return RouteNames.packages;
    return null;
  },
  routes: [
    GoRoute(
      path: RouteNames.login,
      pageBuilder: (context, state) => _fadeTransitionPage(
        state: state,
        child: const LoginPage(),
      ),
    ),
    GoRoute(
      path: RouteNames.packages,
      pageBuilder: (context, state) => _fadeTransitionPage(
        state: state,
        child: const WellnessPackagesPage(),
      ),
    ),
  ],
);

CustomTransitionPage<void> _fadeTransitionPage({
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 250),
    reverseTransitionDuration: const Duration(milliseconds: 200),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
        child: child,
      );
    },
  );
}
