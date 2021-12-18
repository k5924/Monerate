import 'package:flutter/material.dart';
import 'package:monerate/src/utilities/export.dart';

class MyApp extends StatelessWidget {
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
    );
  }
}
