// Values injected at compile time via --dart-define-from-file=.env.{flavor}
class EnvConfig {
  const EnvConfig._();

  static const String flavor =
      String.fromEnvironment('FLAVOR', defaultValue: 'dev');

  static const String appName =
      String.fromEnvironment('APP_NAME', defaultValue: 'StarterKit Dev');

  static const String baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'https://api.dev.example.com',
  );

  static const bool isProduction = bool.fromEnvironment('IS_PRODUCTION');

  static const bool enableLogging =
      bool.fromEnvironment('ENABLE_LOGGING', defaultValue: true);

  static bool get isDev => flavor == 'dev';
  static bool get isStaging => flavor == 'staging';
}
