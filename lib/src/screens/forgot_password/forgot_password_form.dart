// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:monerate/src/providers/export.dart';
import 'package:monerate/src/screens/export.dart';
import 'package:monerate/src/utilities/export.dart';
import 'package:monerate/src/widgets/export.dart';

/// This is the form which would be displayed on the forgot password screen
class ForgotPasswordForm extends StatefulWidget {
  /// This is the constructor for the forgot password form
  const ForgotPasswordForm({Key? key}) : super(key: key);

  @override
  _ForgotPasswordFormState createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final TextEditingController emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final AuthProvider authProvider = AuthProvider(auth: FirebaseAuth.instance);
  late String result = '';

  @override
  void dispose() {
    // Clean up controllers when form is disposed
    emailController.dispose();
    super.dispose();
  }

  Future<String?> _sendPasswordResetEmail() async {
    return authProvider.forgotPassword(
      email: emailController.text,
    );
  }

  Future<String?> _displayConfirmationDialog() {
    return customAlertDialog(
      context: context,
      title: "Confirmation Required",
      content:
          "By continuing with this action, a password reset email will be sent to the email address provided. Do you wish to continue?",
      actions: [
        OutlinedButton(
          onPressed: () => closeDialogBox(context),
          child: const Text(
            "Cancel",
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            EasyLoading.show(status: 'loading...');
            result = (await _sendPasswordResetEmail())!;
            if (result == "Password reset email sent") {
              Navigator.popAndPushNamed(
                context,
                LoginScreen.kID,
              );
              EasyLoading.showSuccess(result);
            } else {
              closeDialogBox(context);
              EasyLoading.showError(result);
            }
          },
          child: const Text("Send Email"),
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
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  FocusScope.of(context).unfocus();
                  await _displayConfirmationDialog();
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 10,
                ),
              ),
              child: const Text(
                "Send Password Reset Email",
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
