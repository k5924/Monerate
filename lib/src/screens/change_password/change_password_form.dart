// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:monerate/src/providers/export.dart';
import 'package:monerate/src/screens/export.dart';
import 'package:monerate/src/utilities/export.dart';
import 'package:monerate/src/widgets/export.dart';

/// This is the form that a user needs to fill out on the change password screen
class ChangePasswordForm extends StatefulWidget {
  /// This is the constructor for this form
  const ChangePasswordForm({Key? key}) : super(key: key);

  @override
  State<ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _showPassword = false;

  final AuthProvider authProvider = AuthProvider(auth: FirebaseAuth.instance);

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    super.dispose();
  }

  Future<String?> _updatePassword() async {
    return authProvider.changePassword(
      oldPassword: oldPasswordController.text,
      newPassword: confirmNewPasswordController.text,
    );
  }

  Future<String?> _displayConfirmationDialog() {
    return customAlertDialog(
      context: context,
      title: "Confirmation Required",
      content:
          "By continuing with this action, you will be signed out of the current session and will be asked to login with the new credentials you have provided. Do you wish to continue?",
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
            final result = await _updatePassword();
            if (result != null) {
              closeDialogBox(context);
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
    return Form(
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
                  _showPassword ? Icons.visibility : Icons.visibility_off,
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
                  _showPassword ? Icons.visibility : Icons.visibility_off,
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
                  _showPassword ? Icons.visibility : Icons.visibility_off,
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
              "Submit",
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
