import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';

/// This class lets us interact with the secure storage package from flutter
class SecureStorageProvider {
  /// This variable will store an instance of FlutterSecureStorage
  final FlutterSecureStorage secureStorage;

  /// This constructor requires us to first inject an instance of FlutterSecureStorage before using the class
  SecureStorageProvider({required this.secureStorage});

  Future<void> _generateEncryptionKey() async {
    final key = Hive.generateSecureKey();
    await secureStorage.write(
      key: 'key',
      value: base64Encode(key),
    );
  }

  /// This function retrieves the encryption keys for Hive by reading the devices secure storage
  Future<Uint8List> getEncryptionKey() async {
    final encryptionKey = await secureStorage.read(key: 'key');
    if (encryptionKey == null) {
      _generateEncryptionKey();
    }
    final key = await secureStorage.read(key: 'key');
    return base64Url.decode(key!);
  }
}
