import 'package:flutter/material.dart';
import 'package:monerate/src/screens/export.dart';
import 'package:monerate/src/widgets/export.dart';

/// This is the forgot password screen
class ForgotPasswordScreen extends StatefulWidget {
  /// This variable stores the named route for the forgot password screen
  static const String kID = 'forgot_password_screen';

  /// This is the constructor for the forgot password screen
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return CenteredScrollView(
      children: [
        const ScreenHeader(screenName: "Forgot Password"),
        const ForgotPasswordForm(),
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
