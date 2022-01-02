import 'package:flutter/cupertino.dart';
import 'package:monerate/src/screens/export.dart';

String kInitialRoute = SplashScreen.kID;

Map<String, Widget Function(BuildContext)> kRoutes = {
  SplashScreen.kID: (context) => const SplashScreen(),
  LoginScreen.kID: (context) => const LoginScreen(),
  ConstructionPage.kID: (context) => const ConstructionPage(),
  ForgotPasswordScreen.kID: (context) => const ForgotPasswordScreen(),
  SignUpScreen.kID: (context) => const SignUpScreen(),
  CompleteProfileScreen.kID: (context) => const CompleteProfileScreen(),
  CompleteEndUserProfile.kID: (context) => const CompleteEndUserProfile(),
  CompleteFinancialAdvisorProfile.kID: (context) =>
      const CompleteFinancialAdvisorProfile(),
  CompleteSupportManagerProfile.kID: (context) =>
      const CompleteSupportManagerProfile(),
  DashboardScreen.kID: (context) => const DashboardScreen(),
};
