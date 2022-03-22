// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:monerate/src/providers/export.dart';
import 'package:monerate/src/screens/export.dart';
import 'package:monerate/src/utilities/export.dart';
import 'package:monerate/src/widgets/export.dart';

class CompleteSupportManagerProfile extends StatefulWidget {
  static const String kID = 'complete_support_manager_profile';
  const CompleteSupportManagerProfile({Key? key}) : super(key: key);

  @override
  _CompleteSupportManagerProfileState createState() =>
      _CompleteSupportManagerProfileState();
}

class _CompleteSupportManagerProfileState
    extends State<CompleteSupportManagerProfile> {
  @override
  Widget build(BuildContext context) {
    return const CenteredScrollView(
      children: [
        Padding(
          padding: EdgeInsets.all(25),
          child: CompleteFinancialAdvisorProfileForm(),
        ),
      ],
    );
  }
}
