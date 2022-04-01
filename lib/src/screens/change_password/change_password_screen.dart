// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:monerate/src/screens/export.dart';
import 'package:monerate/src/widgets/export.dart';

class ChangePasswordScreen extends StatefulWidget {
  static const kID = "change_password_screen";
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return CenteredScrollViewWithAppBar(
      appBarTitle: "Change Password",
      floatingActionButton: null,
      children: const [
        ChangePasswordForm(),
      ],
    );
  }
}
