/// Central environment configuration.
/// Values are injected at compile time via `--dart-define-from-file=.env.{flavor}`
/// Never hardcode environment-specific values outside this class.
class EnvConfig {
  // Private constructor — this is a pure static utility class.
  const EnvConfig._();

  /// Active flavor name: 'dev' | 'staging' | 'production'
  static const String flavor =
      String.fromEnvironment('FLAVOR', defaultValue: 'dev');

  /// Display name shown in the app (and optionally in OS launcher via native config)
  static const String appName =
      String.fromEnvironment('APP_NAME', defaultValue: 'StarterKit Dev');

  /// Base URL for all API calls — consumed by DioClient
  static const String baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'https://api.dev.example.com',
  );

  /// True only for production builds — controls Crashlytics, analytics, log output
  static const bool isProduction = bool.fromEnvironment('IS_PRODUCTION');

  /// When true, verbose logs are printed to console
  static const bool enableLogging =
      bool.fromEnvironment('ENABLE_LOGGING', defaultValue: true);

  // ── Derived helpers ──────────────────────────────────────────────────────

  /// True when running the dev flavor
  static bool get isDev => flavor == 'dev';

  /// True when running the staging flavor
  static bool get isStaging => flavor == 'staging';
}
