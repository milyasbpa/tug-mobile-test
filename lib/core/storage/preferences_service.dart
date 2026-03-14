import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Thin wrapper around [SharedPreferences] for persisting simple user
/// preferences (e.g. selected locale, theme mode, onboarding-seen flag).
///
/// Do NOT store sensitive data (tokens, credentials) here — use
/// [SecureStorageService] instead.
@lazySingleton
class PreferencesService {
  // Preference keys — add more as needed per feature.

  static const String _keyLocale = 'pref_locale';
  static const String _keyThemeMode = 'pref_theme_mode';
  static const String _keyOnboardingSeen = 'pref_onboarding_seen';

  Future<SharedPreferences> get _prefs => SharedPreferences.getInstance();

  // ── Locale ───────────────────────────────────────────────────────────────

  Future<void> saveLocale(String languageCode) async {
    final prefs = await _prefs;
    await prefs.setString(_keyLocale, languageCode);
  }

  Future<String?> getLocale() async {
    final prefs = await _prefs;
    return prefs.getString(_keyLocale);
  }

  // ── Theme ────────────────────────────────────────────────────────────────

  /// Stores the theme mode as a string: `'light'`, `'dark'`, or `'system'`.
  Future<void> saveThemeMode(String themeMode) async {
    final prefs = await _prefs;
    await prefs.setString(_keyThemeMode, themeMode);
  }

  Future<String?> getThemeMode() async {
    final prefs = await _prefs;
    return prefs.getString(_keyThemeMode);
  }

  // ── Onboarding ───────────────────────────────────────────────────────────

  Future<void> setOnboardingSeen() async {
    final prefs = await _prefs;
    await prefs.setBool(_keyOnboardingSeen, true);
  }

  Future<bool> isOnboardingSeen() async {
    final prefs = await _prefs;
    return prefs.getBool(_keyOnboardingSeen) ?? false;
  }

  // ── Utility ──────────────────────────────────────────────────────────────

  /// Clears all preferences. Useful during logout for resetting user state.
  Future<void> clearAll() async {
    final prefs = await _prefs;
    await prefs.clear();
  }
}
