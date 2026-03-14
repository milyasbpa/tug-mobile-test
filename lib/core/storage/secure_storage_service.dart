import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_starter_kit/core/storage/local_storage_service.dart';
import 'package:injectable/injectable.dart';

/// Keys used in platform secure storage.
///
/// Centralised here so all read/write operations stay consistent.
abstract class _Keys {
  static const String accessToken = 'access_token';
  static const String refreshToken = 'refresh_token';
}

/// Stores auth tokens in platform-level encrypted storage.
///
/// - **Android**: EncryptedSharedPreferences (AES256-GCM via Keystore)
/// - **iOS / macOS**: Keychain Services
@LazySingleton(as: LocalStorageService)
class SecureStorageService implements LocalStorageService {
  SecureStorageService()
      : _storage = const FlutterSecureStorage(
          aOptions: AndroidOptions(
            encryptedSharedPreferences: true,
          ),
        );

  final FlutterSecureStorage _storage;

  @override
  Future<void> saveAccessToken(String token) =>
      _storage.write(key: _Keys.accessToken, value: token);

  @override
  Future<String?> getAccessToken() => _storage.read(key: _Keys.accessToken);

  @override
  Future<void> saveRefreshToken(String token) =>
      _storage.write(key: _Keys.refreshToken, value: token);

  @override
  Future<String?> getRefreshToken() => _storage.read(key: _Keys.refreshToken);

  @override
  Future<void> clearAll() => _storage.deleteAll();
}
