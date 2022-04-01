// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:monerate/src/screens/export.dart';
import 'package:monerate/src/widgets/export.dart';
/// This page will be displayed when a user chooses their user type as support manager
class CompleteSupportManagerProfile extends StatefulWidget {
  /// This variable stores the named route for this screen
  static const String kID = 'complete_support_manager_profile';
  /// This is the constructor for this screen
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
        CompleteFinancialAdvisorProfileForm(),
      ],
    );
  }
}
