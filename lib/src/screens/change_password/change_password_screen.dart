// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:monerate/src/screens/change_password/export.dart';

class ChangePasswordScreen extends StatefulWidget {
  static const kID = "change_password_screen";
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  

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
              children: const [
                ChangePasswordForm()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
