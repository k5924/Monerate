import 'package:flutter/material.dart';
import 'package:monerate/src/screens/export.dart';
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Monerate",
                  style: Theme.of(context).textTheme.headline4,
                ),
                const AppIcon(),
                Text(
                  "Sign In",
                  style: Theme.of(context).textTheme.headline5,
                ),
                const LoginForm(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 25, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pushNamed(
                          context,
                          ConstructionPage.kID,
                        ),
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 50, 25, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text("Don't have an account?"),
                      OutlinedButton(
                        onPressed: () => Navigator.pushNamed(
                          context,
                          ConstructionPage.kID,
                        ),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 10,
                          ),
                        ),
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
