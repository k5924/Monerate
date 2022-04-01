import 'package:flutter/material.dart';
import 'package:monerate/src/screens/export.dart';

/// This screen will be displayed when an end-user wants to manually add an account to their portfolio
class ManualAccountScreen extends StatefulWidget {
  /// This variable stores the named route for this screen
  static const kID = 'manual_account_screen';

  /// This is the constructor for this screen
  const ManualAccountScreen({Key? key}) : super(key: key);

  @override
  State<ManualAccountScreen> createState() => _ManualAccountScreenState();
}

class _ManualAccountScreenState extends State<ManualAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Account Details"),
      ),
      body: const Center(
        child: SingleChildScrollView(
          child: ManualAccountForm(),
        ),
      ),
    );
  }
}
