// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:monerate/src/screens/export.dart';
import 'package:monerate/src/widgets/export.dart';

class CompleteFinancialAdvisorProfile extends StatefulWidget {
  static const String kID = 'complete_financial_advisor_profile';
  const CompleteFinancialAdvisorProfile({Key? key}) : super(key: key);

  @override
  _CompleteFinancialAdvisorProfileState createState() =>
      _CompleteFinancialAdvisorProfileState();
}

class _CompleteFinancialAdvisorProfileState
    extends State<CompleteFinancialAdvisorProfile> {
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
