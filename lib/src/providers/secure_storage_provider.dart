import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';

class SecureStorageProvider {
  final FlutterSecureStorage secureStorage;

  SecureStorageProvider({required this.secureStorage});

  Future<void> generateEncryptionKey() async {
    final key = Hive.generateSecureKey();
    await secureStorage.write(
      key: 'key',
      value: base64Encode(key),
    );
  }

  Future<Uint8List> getEncryptionKey() async {
    final encryptionKey = await secureStorage.read(key: 'key');
    if (encryptionKey == null) {
      generateEncryptionKey();
    }
    final key = await secureStorage.read(key: 'key');
    return base64Url.decode(key!);
  }
}
