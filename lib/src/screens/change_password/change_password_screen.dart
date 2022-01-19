// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:monerate/src/providers/export.dart';
import 'package:monerate/src/screens/export.dart';
import 'package:monerate/src/utilities/export.dart';
import 'package:monerate/src/widgets/export.dart';

class ChangePasswordScreen extends StatefulWidget {
  static const kID = "change_password_screen";
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _showPassword = false;

  final AuthProvider authProvider = AuthProvider();

  void closeDialogBox() {
    return Navigator.pop(context);
  }

  Future<String?> _updatePassword() async {
    return authProvider.changePassword(
      oldPasswordController.text,
      confirmNewPasswordController.text,
    );
  }

  Future<String?> displayConfirmationDialog() {
    return customAlertDialog(
      context: context,
      title: "Confirmation Required",
      content:
          "By continuing with this action, you will be signed out of the current session and will be asked to login with the new credentials you have provided. Do you wish to continue?",
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
            final result = await _updatePassword();
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
          "Change Password",
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
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: oldPasswordController,
                        validator: PasswordValidator().validatePassword,
                        obscureText: !_showPassword,
                        textInputAction: TextInputAction.done,
                        onSaved: (password) {
                          oldPasswordController.text = password!;
                        },
                        decoration: InputDecoration(
                          hintText: 'Old Password',
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
                      TextFormField(
                        controller: newPasswordController,
                        validator: PasswordValidator().validatePassword,
                        obscureText: !_showPassword,
                        textInputAction: TextInputAction.done,
                        onSaved: (password) {
                          newPasswordController.text = password!;
                        },
                        decoration: InputDecoration(
                          hintText: 'New Password',
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
                      TextFormField(
                        controller: confirmNewPasswordController,
                        validator: PasswordValidator().validatePassword,
                        obscureText: !_showPassword,
                        textInputAction: TextInputAction.done,
                        onSaved: (password) {
                          confirmNewPasswordController.text = password!;
                        },
                        decoration: InputDecoration(
                          hintText: 'Confirm New Password',
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
