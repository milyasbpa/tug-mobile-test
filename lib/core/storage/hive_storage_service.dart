import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class HiveStorageService {
  static const String _boxName = 'app_box';

  Box<dynamic>? _box;

  Future<Box<dynamic>> get _openBox async {
    if (_box != null && _box!.isOpen) return _box!;
    _box = await Hive.openBox<dynamic>(_boxName);
    return _box!;
  }

  Future<void> put(String key, dynamic value) async {
    final box = await _openBox;
    await box.put(key, value);
  }

  Future<T?> get<T>(String key, {T? defaultValue}) async {
    final box = await _openBox;
    final value = box.get(key, defaultValue: defaultValue);
    if (value is T) return value;
    return defaultValue;
  }

  Future<void> delete(String key) async {
    final box = await _openBox;
    await box.delete(key);
  }

  Future<bool> containsKey(String key) async {
    final box = await _openBox;
    return box.containsKey(key);
  }

  Future<void> clearAll() async {
    final box = await _openBox;
    await box.clear();
  }
}
