import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:monerate/src/utilities/export.dart';

/// MyApp is the stateless widget which spawns all other interfaces for the application
class MyApp extends StatelessWidget {
  /// This is the constructor for the MyApp widget
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: kLightTheme,
      darkTheme: kDarkTheme,
      initialRoute: kInitialRoute,
      routes: kRoutes,
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
    );
  }
}
