// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:monerate/src/providers/export.dart';
import 'package:monerate/src/screens/export.dart';
import 'package:monerate/src/utilities/export.dart';
import 'package:monerate/src/widgets/export.dart';

class ChangeEmailScreen extends StatefulWidget {
  static const kID = 'change_email_screen';
  const ChangeEmailScreen({Key? key}) : super(key: key);

  @override
  _ChangeEmailScreenState createState() => _ChangeEmailScreenState();
}

class _ChangeEmailScreenState extends State<ChangeEmailScreen> {
  final TextEditingController newEmailController = TextEditingController();
  final TextEditingController confirmEmailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _showPassword = false;

  final AuthProvider authProvider = AuthProvider();

  @override
  void dispose() {
    // Clean up controllers when form is disposed
    newEmailController.dispose();
    confirmEmailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void closeDialogBox() {
    return Navigator.pop(context);
  }

  Future<String?> _updateEmail() async {
    return authProvider.changeEmail(
      confirmEmailController.text,
      passwordController.text,
    );
  }

  Future<String?> displayConfirmationDialog() {
    return customAlertDialog(
      context: context,
      title: "Confirmation Required",
      content:
          "By continuing with this action, you will be signed out of the current session. A verification email will be sent to the provided email which must be verified before logging in with your new credentials. Do you wish to continue?",
      actions: [
        OutlinedButton(
          onPressed: () => closeDialogBox(),
          child: const Text(
            "Cancel",
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            EasyLoading.show(status: 'loading...');
            final result = await _updateEmail();
            if (result != null) {
              closeDialogBox();
              EasyLoading.showError(result);
            } else {
              Navigator.pushReplacementNamed(
                context,
                LoginScreen.kID,
              );
              EasyLoading.dismiss();
            }
          },
          child: const Text("Update Email"),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Change Email Address",
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: newEmailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: EmailValidator().validateEmail,
                        onSaved: (value) {
                          newEmailController.text = value!;
                        },
                        decoration: const InputDecoration(
                          hintText: 'New Email Address',
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: confirmEmailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          return EmailValidator().confirmEmail(
                            newEmailController.text,
                            confirmEmailController.text,
                          );
                        },
                        onSaved: (value) {
                          confirmEmailController.text = value!;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Confirm New Email Address',
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: passwordController,
                        validator: PasswordValidator().validatePassword,
                        obscureText: !_showPassword,
                        textInputAction: TextInputAction.done,
                        onSaved: (password) {
                          passwordController.text = password!;
                        },
                        decoration: InputDecoration(
                          hintText: 'Password',
                          suffixIcon: GestureDetector(
                            onTap: () => setState(() {
                              _showPassword = !_showPassword;
                            }),
                            child: Icon(
                              _showPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            FocusScope.of(context).unfocus();
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
                          "Submit",
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
