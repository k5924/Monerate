// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:monerate/src/screens/export.dart';
import 'package:monerate/src/widgets/export.dart';

/// This page will be displayed if a user chooses to be an end-user
class CompleteEndUserProfile extends StatefulWidget {
  /// This variable stores the named route for this page
  static const String kID = 'complete_end_user_profile';

  /// This is the constructor for this page
  const CompleteEndUserProfile({Key? key}) : super(key: key);

  @override
  _CompleteEndUserProfileState createState() => _CompleteEndUserProfileState();
}

class _CompleteEndUserProfileState extends State<CompleteEndUserProfile> {
  @override
  Widget build(BuildContext context) {
    return const CenteredScrollView(
      children: [
        CompleteEndUserProfileForm(),
      ],
    );
  }
}
