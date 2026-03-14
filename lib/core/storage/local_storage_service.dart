/// Abstract contract for persisting and retrieving auth tokens.
///
/// The concrete implementation ([SecureStorageService]) stores tokens using
/// platform-level encryption so they are never persisted in plain text.
///
/// Step 10 will expand this interface with session management helpers.
abstract class LocalStorageService {
  /// Persists the short-lived JWT access token.
  Future<void> saveAccessToken(String token);

  /// Returns the stored access token, or `null` if none exists.
  Future<String?> getAccessToken();

  /// Persists the long-lived refresh token used to obtain new access tokens.
  Future<void> saveRefreshToken(String token);

  /// Returns the stored refresh token, or `null` if none exists.
  Future<String?> getRefreshToken();

  /// Wipes all persisted values (called on logout).
  Future<void> clearAll();
}
