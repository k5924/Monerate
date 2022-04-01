// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:monerate/src/screens/export.dart';
import 'package:monerate/src/widgets/export.dart';

class ChangeEmailScreen extends StatefulWidget {
  static const kID = 'change_email_screen';
  const ChangeEmailScreen({Key? key}) : super(key: key);

  @override
  _ChangeEmailScreenState createState() => _ChangeEmailScreenState();
}

class _ChangeEmailScreenState extends State<ChangeEmailScreen> {
  @override
  Widget build(BuildContext context) {
    return CenteredScrollViewWithAppBar(
      appBarTitle: "Change Email Address",
      floatingActionButton: null,
      children: const [
        ChangeEmailForm(),
      ],
    );
  }
}
