import 'package:flutter/material.dart';
import 'package:monerate/src/widgets/export.dart';

class LoginScreen extends StatefulWidget {
  static const String kID = 'login_screen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Monerate",
                style: Theme.of(context).textTheme.headline2,
              ),
              const AppIcon(),
            ],
          ),
        ),
      ),
    );
  }
}
