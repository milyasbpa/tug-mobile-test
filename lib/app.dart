import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_starter_kit/core/di/injection.dart';
import 'package:flutter_starter_kit/core/l10n/locale_cubit.dart';
import 'package:flutter_starter_kit/core/l10n/translations.g.dart';
import 'package:flutter_starter_kit/core/router/app_router.dart';
import 'package:flutter_starter_kit/core/theme/app_theme.dart';
import 'package:flutter_starter_kit/features/auth/presentation/blocs/auth_bloc.dart';

/// Root widget of the application.
///
/// Responsibilities of this file:
/// - Theme configuration (light & dark) via [AppTheme]
/// - Router/navigation setup via [appRouter]
/// - Localization via slang's [TranslationProvider] + [LocaleCubit]
/// - [AuthBloc] provided via [BlocProvider.value] (singleton managed by GetIt)
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>.value(value: getIt<AuthBloc>()),
        BlocProvider<LocaleCubit>(create: (_) => getIt<LocaleCubit>()),
      ],
      // TranslationProvider listens to LocaleSettings.setLocale() calls and
      // rebuilds the subtree automatically — no BlocBuilder needed for locale.
      child: TranslationProvider(
        child: Builder(
          builder: (ctx) => MaterialApp.router(
            title: 'Flutter Starter Kit',
            debugShowCheckedModeBanner: false,
            routerConfig: appRouter,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            // ── Localization ──────────────────────────────────────────
            locale: TranslationProvider.of(ctx).flutterLocale,
            supportedLocales: AppLocaleUtils.supportedLocales,
            localizationsDelegates: GlobalMaterialLocalizations.delegates,
          ),
        ),
      ),
    );
  }
}
