import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:monerate/firebase_options.dart';
import 'package:monerate/src/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
