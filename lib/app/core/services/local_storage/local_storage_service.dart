// ignore_for_file: avoid-dynamic

abstract class LocalStorage {
  /// Reads data of type T store in device
  Future<T?> read<T>(String key);

  /// Store data on device locally
  Future<void> write(String key, dynamic value);

  /// Delete data of a given `key`
  Future<void> delete(String key);

  /// Delete ALL data stored in device
  Future<void> clearAll();

  /// Verify if a given `key` exists in device
  Future<bool> contains(String key);
}

class InvalidStorageTypeException implements Exception {
  final String message;

  InvalidStorageTypeException(this.message);

  @override
  String toString() => 'InvalidStorageTypeException(message: $message)';
}

class UnsupportedStorageTypeException implements Exception {
  final String message;

  UnsupportedStorageTypeException(this.message);

  @override
  String toString() => 'InvalidStorageTypeException(message: $message)';
}
