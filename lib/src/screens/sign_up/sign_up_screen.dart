import 'package:flutter/material.dart';
import 'package:monerate/src/screens/export.dart';
import 'package:monerate/src/widgets/export.dart';

/// This is the signup screen for the application
class SignUpScreen extends StatefulWidget {
  /// This variable stores the named route for the signup screen
  static const String kID = 'sign_up_screen';

  /// This is the constructor for the signup screen
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return CenteredScrollView(
      children: [
        const ScreenHeader(screenName: "Sign Up"),
        const SignUpForm(),
        OutlinedButton(
          onPressed: () => Navigator.pop(context),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 10,
            ),
          ),
          child: const Text(
            "Login",
            style: TextStyle(
              fontSize: 24,
            ),
          ),
        ),
      ],
    );
  }
}
