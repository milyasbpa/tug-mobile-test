/// Keys used to store data in SharedPreferences
/// and flutter_secure_storage.
///
/// Centralised here to prevent typos when accessing storage.
abstract final class StorageKeys {
  // ─── Auth ──────────────────────────────────────────────────────────────────
  static const String accessToken = 'access_token';
  static const String refreshToken = 'refresh_token';
  static const String userId = 'user_id';

  // ─── User Preferences ─────────────────────────────────────────────────────
  static const String themeMode = 'theme_mode';
  static const String languageCode = 'language_code';
  static const String isOnboardingDone = 'is_onboarding_done';
}
