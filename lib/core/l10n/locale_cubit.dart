import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_starter_kit/core/l10n/translations.g.dart';
import 'package:flutter_starter_kit/core/storage/preferences_service.dart';
import 'package:injectable/injectable.dart';

/// [Cubit] that manages the currently active [AppLocale].
///
/// On construction it immediately loads the locale persisted in
/// [PreferencesService] (or falls back to English). Call [changeLocale] to
/// switch the language at runtime — the choice is persisted automatically.
///
/// [LocaleSettings.setLocale] is called on each change so that
/// [TranslationProvider] rebuilds automatically.
///
/// Usage in widgets:
/// ```dart
/// // Read current locale
/// context.watch<LocaleCubit>().state
///
/// // Change locale
/// context.read<LocaleCubit>().changeLocale(AppLocale.id);
/// ```
@injectable
class LocaleCubit extends Cubit<AppLocale> {
  LocaleCubit(this._prefs) : super(AppLocale.en) {
    unawaited(_loadSavedLocale());
  }

  final PreferencesService _prefs;

  Future<void> _loadSavedLocale() async {
    final code = await _prefs.getLocale();
    if (code != null && !isClosed) {
      final locale = AppLocale.values.firstWhere(
        (l) => l.languageTag == code,
        orElse: () => AppLocale.en,
      );
      await LocaleSettings.setLocale(locale);
      emit(locale);
    }
  }

  /// Changes the active locale, updates [LocaleSettings] (which triggers
  /// [TranslationProvider] to rebuild), and persists the choice.
  Future<void> changeLocale(AppLocale locale) async {
    await LocaleSettings.setLocale(locale);
    await _prefs.saveLocale(locale.languageTag);
    emit(locale);
  }
}
