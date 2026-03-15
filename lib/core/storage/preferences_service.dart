import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// SharedPreferences wrapper for user preferences (locale, theme, onboarding).
@lazySingleton
class PreferencesService {
  static const String _keyLocale = 'pref_locale';
  static const String _keyThemeMode = 'pref_theme_mode';
  static const String _keyOnboardingSeen = 'pref_onboarding_seen';

  Future<SharedPreferences> get _prefs => SharedPreferences.getInstance();

  Future<void> saveLocale(String languageCode) async {
    final prefs = await _prefs;
    await prefs.setString(_keyLocale, languageCode);
  }

  Future<String?> getLocale() async {
    final prefs = await _prefs;
    return prefs.getString(_keyLocale);
  }

  Future<void> saveThemeMode(String themeMode) async {
    final prefs = await _prefs;
    await prefs.setString(_keyThemeMode, themeMode);
  }

  Future<String?> getThemeMode() async {
    final prefs = await _prefs;
    return prefs.getString(_keyThemeMode);
  }

  Future<void> setOnboardingSeen() async {
    final prefs = await _prefs;
    await prefs.setBool(_keyOnboardingSeen, true);
  }

  Future<bool> isOnboardingSeen() async {
    final prefs = await _prefs;
    return prefs.getBool(_keyOnboardingSeen) ?? false;
  }

  Future<void> clearAll() async {
    final prefs = await _prefs;
    await prefs.clear();
  }
}
