import 'dart:typed_data';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:monerate/src/models/export.dart';
import 'package:monerate/src/providers/export.dart';

class BoxProvider {
  final secureStorageProvider =
      SecureStorageProvider(secureStorage: const FlutterSecureStorage());
  late Uint8List encryptionKey;
  late Box<LocalKeyModel> box;

  Future<void> setEncryptionKey() async {
    encryptionKey = await secureStorageProvider.getEncryptionKey();
  }

  Future<Box<LocalKeyModel>> getKeys() async {
    await setEncryptionKey();
    box = await Hive.openBox<LocalKeyModel>(
      'local_keys',
      encryptionCipher: HiveAesCipher(encryptionKey),
    );
    return box;
  }
}
