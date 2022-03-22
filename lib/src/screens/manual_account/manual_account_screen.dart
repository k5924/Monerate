import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:monerate/src/providers/export.dart';
import 'package:monerate/src/screens/export.dart';
import 'package:monerate/src/utilities/export.dart';

class ManualAccountScreen extends StatefulWidget {
  static const kID = 'manual_account_screen';
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
          child: ManualAccountForm()
        ),
      ),
    );
  }
}
