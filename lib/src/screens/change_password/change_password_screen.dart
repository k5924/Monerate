// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:monerate/src/screens/export.dart';
import 'package:monerate/src/widgets/export.dart';

/// This is the screen which would be displayed when any user chooses to change their password
class ChangePasswordScreen extends StatefulWidget {
  /// This variable stores the named route for this screen
  static const kID = "change_password_screen";

  /// This is the constructor for this screen
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
