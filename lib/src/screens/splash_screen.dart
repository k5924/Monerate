import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:monerate/src/screens/export.dart';

class SplashScreen extends StatefulWidget {
  static const String kID = 'splash_screen';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  Future<void> _navigateToHome() async {
    await Future.delayed(
      const Duration(
        seconds: 2,
      ),
      () => Navigator.pushReplacementNamed(
        context,
        MyHomePage.kID,
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
              const Icon(
                Icons.account_balance,
                size: 214,
              ),
              AnimatedTextKit(
                animatedTexts: [
                  TyperAnimatedText(
                    'Monerate',
                    textStyle: const TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                    ),
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
