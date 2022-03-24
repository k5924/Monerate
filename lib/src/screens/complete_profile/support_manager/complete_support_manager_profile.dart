// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:monerate/src/screens/export.dart';
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
