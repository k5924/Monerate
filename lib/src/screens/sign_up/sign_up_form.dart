// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:monerate/src/providers/export.dart';
import 'package:monerate/src/screens/export.dart';
import 'package:monerate/src/utilities/export.dart';
import 'package:monerate/src/widgets/export.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController confirmEmailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final AuthProvider authProvider = AuthProvider();

  late String result;

  bool _showPassword = false;

  @override
  void dispose() {
    // Clean up controllers when form is disposed
    emailController.dispose();
    confirmEmailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<String?> _checkCredentials() async {
    return authProvider.registerUser(
      emailController.text,
      passwordController.text,
    );
  }

  void closeDialogBox() {
    return Navigator.pop(context);
  }

  Future<String?> displayConfirmationDialog() {
    return customAlertDialog(
      context: context,
      title: "Terms and Conditions",
      content: kTermsAndConditions,
      actions: [
        OutlinedButton(
          onPressed: () => closeDialogBox(),
          child: const Text(
            "Cancel",
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            result = (await _checkCredentials())!;
            // ignore: unnecessary_null_comparison
            if (result ==
                'Please verify the email sent to the email address you provided') {
              Navigator.popAndPushNamed(
                context,
                LoginScreen.kID,
              );
            } else {
              closeDialogBox();
            }
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  result,
                ),
              ),
            );
          },
          child: const Text("Agree and Continue"),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 25, 25, 50),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              validator: EmailValidator().validateEmail,
              onSaved: (value) {
                emailController.text = value!;
              },
              decoration: const InputDecoration(
                hintText: 'Email Address',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: confirmEmailController,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                return EmailValidator().confirmEmail(
                  emailController.text,
                  confirmEmailController.text,
                );
              },
              onSaved: (value) {
                confirmEmailController.text = value!;
              },
              decoration: const InputDecoration(
                hintText: 'Confirm Email Address',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: passwordController,
              validator: PasswordValidator().validatePassword,
              obscureText: !_showPassword,
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
            TextFormField(
              controller: confirmPasswordController,
              validator: (value) {
                return PasswordValidator().confirmPassword(
                  passwordController.text,
                  confirmPasswordController.text,
                );
              },
              obscureText: !_showPassword,
              textInputAction: TextInputAction.done,
              onSaved: (password) {
                confirmPasswordController.text = password!;
              },
              decoration: const InputDecoration(
                hintText: 'Confirm Password',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            CheckboxListTile(
              title: !_showPassword
                  ? const Text("Show Password")
                  : const Text("Hide Password"),
              value: _showPassword,
              onChanged: (value) {
                setState(
                  () {
                    _showPassword = !_showPassword;
                  },
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await displayConfirmationDialog();
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 10,
                ),
              ),
              child: const Text(
                "Register",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
