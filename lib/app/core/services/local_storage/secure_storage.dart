// ignore_for_file: avoid-dynamic
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'local_storage_service.dart';

class SecureStorage implements LocalStorage {
  final FlutterSecureStorage _storage;

  SecureStorage(this._storage);

  @override
  Future<T?> read<T>(String key) async {
    switch (T) {
      case String:
        return await _readString(key) as T?;
      case bool:
        return await _readBool(key) as T?;
      case int:
        return await _readInt(key) as T?;
      case double:
        return await _readDouble(key) as T?;
      case const (Map<String, dynamic>):
        return await _readMap(key) as T?;
      case const (List<Map<String, dynamic>>):
        return await _readListOfMap(key) as T?;
      default:
        throw UnsupportedStorageTypeException('Type $T is not supported');
    }
  }

  Future<String?> _readString(String key) async {
    return await _storage.read(key: key);
  }

  Future<bool?> _readBool(String key) async {
    final value = await _storage.read(key: key);
    switch (value) {
      case 'true':
        return true;
      case 'false':
        return false;
      case null:
        return null;
      default:
        await _storage.delete(key: key);
        throw InvalidStorageTypeException('Recovered value is not a boolean');
    }
  }

  Future<int?> _readInt(String key) async {
    final value = await _storage.read(key: key);
    if (value == null) {
      return null;
    }
    final convertedValue = int.tryParse(value);
    if (convertedValue == null) {
      await _storage.delete(key: key);
      throw InvalidStorageTypeException('Recovered value is not a int');
    }

    return convertedValue;
  }

  Future<double?> _readDouble(String key) async {
    final value = await _storage.read(key: key);
    if (value == null) {
      return null;
    }
    final convertedValue = double.tryParse(value);
    if (convertedValue == null) {
      await _storage.delete(key: key);
      throw InvalidStorageTypeException('Recovered value is not a double');
    }

    return convertedValue;
  }

  Future<Map<String, dynamic>?> _readMap(String key) async {
    try {
      final value = await _storage.read(key: key);
      if (value == null) {
        return null;
      }

      return jsonDecode(value);
    } on TypeError catch (exception) {
      await _storage.delete(key: key);
      throw InvalidStorageTypeException(exception.toString());
    } on FormatException catch (exception) {
      await _storage.delete(key: key);
      throw InvalidStorageTypeException(exception.toString());
    }
  }

  Future<List<Map<String, dynamic>>?> _readListOfMap(String key) async {
    try {
      final value = await _storage.read(key: key);
      if (value == null) {
        return null;
      }

      final decoded = jsonDecode(value);

      return (decoded as List<dynamic>).map<Map<String, dynamic>>((e) => e).toList();
    } on TypeError catch (exception) {
      await _storage.delete(key: key);
      throw InvalidStorageTypeException(exception.toString());
    } on FormatException catch (exception) {
      await _storage.delete(key: key);
      throw InvalidStorageTypeException(exception.toString());
    }
  }

  @override
  Future<void> write(String key, dynamic value) async {
    if (value is Map<String, dynamic> || value is List<Map<String, dynamic>>) {
      final encoded = jsonEncode(value);
      await _storage.write(key: key, value: encoded);
    } else if ([String, bool, int, double].contains(value.runtimeType)) {
      await _storage.write(key: key, value: value.toString());
    } else {
      throw UnsupportedStorageTypeException('Type ${value.runtimeType} is not supported');
    }
  }

  @override
  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  @override
  Future<void> clearAll() async {
    await _storage.deleteAll();
  }

  @override
  Future<bool> contains(String key) async {
    return await _storage.containsKey(key: key);
  }
}
