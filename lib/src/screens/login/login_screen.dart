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
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

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
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 25, 25, 50),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (email) {
                            if (email!.isEmpty) {
                              return "Please enter your email";
                            }
                            if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                            ).hasMatch(email)) {
                              return "Please enter a valid email";
                            }

                            return null;
                          },
                          onSaved: (value) {
                            emailController.text = value!;
                          },
                          decoration: const InputDecoration(
                            hintText: 'Email Address',
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: passwordController,
                          validator: (password) {
                            // RegExp regex = RegExp(r'^.{6,}$');
                            if (password!.isEmpty) {
                              return 'A Password is required to login';
                            }
                            if (!RegExp(r'^.{6,}$').hasMatch(password)) {
                              return "Enter a valid password (Minimum 6 chararacters)";
                            }
                          },
                          obscureText: true,
                          textInputAction: TextInputAction.done,
                          onSaved: (password) {
                            passwordController.text = password!;
                          },
                          decoration: const InputDecoration(
                            hintText: 'Password',
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextButton(
                          onPressed: () => Navigator.pushNamed(
                            context,
                            ConstructionPage.kID,
                          ),
                          child: const Text(
                            "Forgot Password",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Navigator.pushNamed(
                                context,
                                MyHomePage.kID,
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
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
                    ),
                  ),
                ),
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
        ),
      ),
    );
  }
}
