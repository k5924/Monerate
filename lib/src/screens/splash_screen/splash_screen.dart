import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:monerate/src/screens/export.dart';
import 'package:monerate/src/widgets/export.dart';

/// This is the splash screen of the application
class SplashScreen extends StatefulWidget {
  /// This is the variable which stores the named route of the splash screen
  static const String kID = 'splash_screen';

  /// This is the constructor of the splash screen widget
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToLoginScreen();
  }

  Future<void> _navigateToLoginScreen() async {
    await Future.delayed(
      const Duration(
        seconds: 2,
      ),
      () => Navigator.pushReplacementNamed(
        context,
        LoginScreen.kID,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AppIcon(),
              AnimatedTextKit(
                animatedTexts: [
                  TyperAnimatedText(
                    'Monerate',
                    textStyle: Theme.of(context).textTheme.headline4,
                    speed: const Duration(milliseconds: 220),
                  ),
                ],
                isRepeatingAnimation: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
