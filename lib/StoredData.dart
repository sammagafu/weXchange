// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:wexchange/model/storage.dart';
// import 'dart:async';
//
// class StorageService {
//   final _storage = const FlutterSecureStorage();
//
//   Future<void> writeSecureData(StorageItem newItem) async {
//     await _storage.write(key: newItem.key, value: newItem.value);
//   }
//
//   Future<String?> readSecureData(String key) async {
//     var readData = await _storage.read(key: key);
//     return readData;
//   }
//
//   Future<void> deleteSecureData(StorageItem item) async {
//     await _storage.delete(key: item.key);
//   }
//
//   Future<bool> containsKeyInSecureData(String key) async {
//     var containsKey = await _storage.containsKey(key: key);
//     return containsKey;
//   }
// }