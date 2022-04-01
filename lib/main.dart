import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:monerate/firebase_options.dart';
import 'package:monerate/src/app.dart';
import 'package:monerate/src/models/export.dart';
import 'package:monerate/src/providers/export.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: 'recaptcha-v3-site-key',
  );
  final secureStorageProvider =
      SecureStorageProvider(secureStorage: const FlutterSecureStorage());
  final encryptionKey = await secureStorageProvider.getEncryptionKey();
  await Hive.initFlutter();
  Hive.registerAdapter(LocalKeyModelAdapter());
  await Hive.openBox<LocalKeyModel>(
    'local_keys',
    encryptionCipher: HiveAesCipher(encryptionKey),
  );
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
  configLoading();
}

/// Provides config for EasyLoading widget
void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.ring
    ..indicatorColor = Colors.deepPurpleAccent
    ..loadingStyle =
        SchedulerBinding.instance!.window.platformBrightness == Brightness.dark
            ? EasyLoadingStyle.dark
            : EasyLoadingStyle.light
    ..maskColor = Colors.black.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false;
}
