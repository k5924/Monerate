import 'package:flutter/material.dart';
import 'package:monerate/src/widgets/export.dart';

class SignUpScreen extends StatefulWidget {
  static const String kID = 'sign_up_screen';
  const SignUpScreen({ Key? key }) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return CenteredScrollView(
      children: [
        const ScreenHeader(screenName: "Sign Up"),
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
