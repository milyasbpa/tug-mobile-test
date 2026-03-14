import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_starter_kit/core/di/injection.dart';
import 'package:flutter_starter_kit/core/l10n/locale_cubit.dart';
import 'package:flutter_starter_kit/core/l10n/translations.g.dart';
import 'package:flutter_starter_kit/core/router/go_router_refresh_stream.dart';
import 'package:flutter_starter_kit/core/router/route_names.dart';
import 'package:flutter_starter_kit/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:flutter_starter_kit/features/auth/presentation/blocs/auth_event.dart';
import 'package:flutter_starter_kit/features/auth/presentation/blocs/auth_state.dart';
import 'package:flutter_starter_kit/features/auth/presentation/pages/login_page.dart';
import 'package:flutter_starter_kit/features/auth/presentation/pages/register_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: RouteNames.home,
  debugLogDiagnostics: true, // TODO(step-17): disable in production build
  refreshListenable: GoRouterRefreshStream(getIt<AuthBloc>().stream),
  redirect: (context, state) {
    final authState = getIt<AuthBloc>().state;
    final isAuthenticated = authState is AuthAuthenticated;
    final isPending = authState is AuthInitial || authState is AuthLoading;
    final location = state.matchedLocation;
    final onAuthScreen =
        location == RouteNames.login || location == RouteNames.register;
    if (isPending) return null;
    if (!isAuthenticated && !onAuthScreen) return RouteNames.login;
    if (isAuthenticated && onAuthScreen) return RouteNames.home;
    return null;
  },
  routes: [
    GoRoute(
      path: RouteNames.home,
      pageBuilder: (context, state) => _fadeTransitionPage(
        state: state,
        child: const _HomePage(),
      ),
    ),
    GoRoute(
      path: RouteNames.login,
      pageBuilder: (context, state) => _fadeTransitionPage(
        state: state,
        child: const LoginPage(),
      ),
    ),
    GoRoute(
      path: RouteNames.register,
      pageBuilder: (context, state) => _fadeTransitionPage(
        state: state,
        child: const RegisterPage(),
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

class _HomePage extends StatelessWidget {
  const _HomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.t.home.title),
        actions: [
          // ── Language switcher ──────────────────────────────────────────────
          BlocBuilder<LocaleCubit, AppLocale>(
            builder: (context, locale) {
              return PopupMenuButton<AppLocale>(
                icon: const Icon(Icons.language),
                tooltip: context.t.settings.languageTitle,
                initialValue: locale,
                onSelected: context.read<LocaleCubit>().changeLocale,
                itemBuilder: (_) => [
                  PopupMenuItem(
                    value: AppLocale.en,
                    child: Text(context.t.settings.languageEnglish),
                  ),
                  PopupMenuItem(
                    value: AppLocale.id,
                    child: Text(context.t.settings.languageIndonesian),
                  ),
                ],
              );
            },
          ),
          // ── Sign out ───────────────────────────────────────────────────────
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: context.t.auth.logoutButton,
            onPressed: () =>
                context.read<AuthBloc>().add(const AuthLogoutRequested()),
          ),
        ],
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          final email = state is AuthAuthenticated ? state.user.email : '';
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  context.t.home.welcome,
                  style: const TextStyle(fontSize: 24),
                ),
                if (email.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(email),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
