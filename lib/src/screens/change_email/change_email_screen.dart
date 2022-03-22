// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:monerate/src/screens/change_email/change_email_form.dart';
import 'package:monerate/src/screens/export.dart';

class ChangeEmailScreen extends StatefulWidget {
  static const kID = 'change_email_screen';
  const ChangeEmailScreen({Key? key}) : super(key: key);

  @override
  _ChangeEmailScreenState createState() => _ChangeEmailScreenState();
}

class _ChangeEmailScreenState extends State<ChangeEmailScreen> {
  

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
              children: const [
                ChangeEmailForm()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
