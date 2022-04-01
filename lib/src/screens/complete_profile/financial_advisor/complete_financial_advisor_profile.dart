// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:monerate/src/screens/export.dart';
import 'package:monerate/src/widgets/export.dart';

/// This is the screen which would be displayed if a user chooses to become a financial advisor
class CompleteFinancialAdvisorProfile extends StatefulWidget {
  /// This is the variable which stores the named route for this screen
  static const String kID = 'complete_financial_advisor_profile';

  /// This is the constructor for this screen
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
        CompleteFinancialAdvisorProfileForm(),
      ],
    );
  }
}
