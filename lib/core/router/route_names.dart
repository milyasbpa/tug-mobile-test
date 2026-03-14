/// All route path constants used throughout the application.
///
/// Use these instead of hardcoded strings to avoid typos and to
/// benefit from IDE auto-complete and refactoring support.
abstract final class RouteNames {
  /// Home / dashboard screen.
  static const String home = '/';

  /// Login screen — used by auth guard redirect.
  static const String login = '/login';

  /// Register / sign-up screen.
  static const String register = '/register';
}
