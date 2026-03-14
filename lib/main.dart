import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_starter_kit/app.dart';
import 'package:flutter_starter_kit/core/constants/env_config.dart';
import 'package:flutter_starter_kit/core/di/injection.dart';
import 'package:flutter_starter_kit/core/errors/error_handler.dart';
import 'package:flutter_starter_kit/core/l10n/translations.g.dart';
import 'package:flutter_starter_kit/core/observers/app_bloc_observer.dart';
import 'package:flutter_starter_kit/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:flutter_starter_kit/features/auth/presentation/blocs/auth_event.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Application entry point.
///
/// This file is responsible ONLY for bootstrapping — setup required
/// before the app can run. Do not put widgets or UI logic here.
///
/// Will be expanded in later steps:
/// - Step 13: runZonedGuarded for global error handling
/// - Step 14: Firebase.initializeApp()
/// - AppBlocObserver already wired (Step 6)
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set default locale. [LocaleCubit] will overwrite this with the persisted
  // locale once it loads from [SharedPreferences].
  await LocaleSettings.setLocaleRaw('en');

  // Initialise Hive local database. Must be called before any box is opened.
  // Feature-specific Hive adapters will be registered here in their
  // respective steps (step 10+).
  await Hive.initFlutter();

  // Register all dependencies into the service locator.
  // The environment string matches Flutter Flavor names (dev / staging / production)
  // and controls which environment-specific implementations are activated.
  configureDependencies(EnvConfig.flavor);

  // Kick off auth-status check immediately so the router can redirect.
  getIt<AuthBloc>().add(const AuthCheckRequested());

  // Forward all Bloc/Cubit transitions and errors to the global observer.
  // In production this will be wired to Crashlytics (Step 14).
  Bloc.observer = const AppBlocObserver();

  // TODO(step-14): await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Catch errors thrown by the Flutter framework itself (e.g. widget build
  // errors, rendering failures). In debug mode the default red-screen
  // behaviour is preserved; in release it forwards to Crashlytics (Step 14).
  final errorHandler = getIt<ErrorHandler>();
  FlutterError.onError = errorHandler.handleFlutterError;

  // Catch errors that escape the Flutter framework entirely and reach the
  // platform layer (e.g. isolate errors, async errors without a zone).
  PlatformDispatcher.instance.onError = (error, stack) {
    errorHandler.handle(error, stack);
    return true; // mark as handled so the platform doesn't crash the app
  };

  // Catch all remaining synchronous and async errors thrown inside the zone.
  runZonedGuarded(
    () => runApp(const App()),
    errorHandler.handle,
  );
}
