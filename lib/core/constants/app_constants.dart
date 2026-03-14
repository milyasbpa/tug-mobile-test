/// Global constants used across the entire application.
///
/// For more specific constants, use the following files:
/// - [ApiConstants]   — base URL, endpoint paths
/// - [AssetConstants] — paths to assets (images, fonts, lottie)
/// - [StorageKeys]    — keys for SharedPreferences / Hive
abstract final class AppConstants {
  /// The application name displayed to the user.
  static const String appName = 'Flutter Starter Kit';

  /// Default animation duration for UI transitions.
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);

  /// Short animation duration for small animations (fade, scale).
  static const Duration shortAnimationDuration = Duration(milliseconds: 150);

  /// Default timeout for HTTP connect.
  static const Duration connectTimeout = Duration(seconds: 30);

  /// Default timeout for receiving a response from the server.
  static const Duration receiveTimeout = Duration(seconds: 30);

  /// Number of items per page for pagination.
  static const int defaultPageSize = 20;
}
