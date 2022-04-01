import 'dart:typed_data';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:monerate/src/models/export.dart';
import 'package:monerate/src/providers/export.dart';

/// This class lets us interact with Hive Boxes
class BoxProvider {
  /// This variable will store an instance of secure storage provider
  final secureStorageProvider =
      SecureStorageProvider(secureStorage: const FlutterSecureStorage());

  /// This variable will store the encryption key for the hive box
  late Uint8List encryptionKey;

  /// This variable will store our hive box
  late Box<LocalKeyModel> box;

  Future<void> _setEncryptionKey() async {
    encryptionKey = await secureStorageProvider.getEncryptionKey();
  }

  /// This method will get the data stored in our hive box
  Future<Box<LocalKeyModel>> getKeys() async {
    await _setEncryptionKey();
    box = await Hive.openBox<LocalKeyModel>(
      'local_keys',
      encryptionCipher: HiveAesCipher(encryptionKey),
    );
    return box;
  }
}
