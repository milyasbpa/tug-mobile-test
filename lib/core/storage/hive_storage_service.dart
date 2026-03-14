import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

/// Generic key-value store backed by Hive for structured, non-sensitive data.
///
/// Uses a single general-purpose box. Feature-specific boxes with typed
/// adapters should be opened separately in the feature's data layer.
///
/// Hive.initFlutter() must be called in main() before this service is used.
@lazySingleton
class HiveStorageService {
  static const String _boxName = 'app_box';

  Box<dynamic>? _box;

  Future<Box<dynamic>> get _openBox async {
    if (_box != null && _box!.isOpen) return _box!;
    _box = await Hive.openBox<dynamic>(_boxName);
    return _box!;
  }

  /// Stores [value] under [key]. Overwrites any existing value.
  Future<void> put(String key, dynamic value) async {
    final box = await _openBox;
    await box.put(key, value);
  }

  /// Returns the value for [key], cast to [T], or [defaultValue] if absent.
  Future<T?> get<T>(String key, {T? defaultValue}) async {
    final box = await _openBox;
    final value = box.get(key, defaultValue: defaultValue);
    if (value is T) return value;
    return defaultValue;
  }

  /// Removes the entry for [key] if it exists.
  Future<void> delete(String key) async {
    final box = await _openBox;
    await box.delete(key);
  }

  /// Returns `true` if [key] has a value in the box.
  Future<bool> containsKey(String key) async {
    final box = await _openBox;
    return box.containsKey(key);
  }

  /// Deletes all entries from the box.
  Future<void> clearAll() async {
    final box = await _openBox;
    await box.clear();
  }
}
