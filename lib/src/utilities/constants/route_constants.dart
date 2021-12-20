import 'package:flutter/cupertino.dart';
import 'package:monerate/src/screens/export.dart';

String kInitialRoute = SplashScreen.kID;

Map<String, Widget Function(BuildContext)> kRoutes = {
  SplashScreen.kID: (context) => const SplashScreen(),
  MyHomePage.kID: (context) => const MyHomePage(title: 'Fluter Demo'),
  LoginScreen.kID: (context) => const LoginScreen(),
  ConstructionPage.kID: (context) => const ConstructionPage(),
  ForgotPasswordScreen.kID: (context) => const ForgotPasswordScreen(),
};
