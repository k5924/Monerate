// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:monerate/src/screens/export.dart';
import 'package:monerate/src/widgets/export.dart';

class CompleteEndUserProfile extends StatefulWidget {
  static const String kID = 'complete_end_user_profile';
  const CompleteEndUserProfile({Key? key}) : super(key: key);

  @override
  _CompleteEndUserProfileState createState() => _CompleteEndUserProfileState();
}

class _CompleteEndUserProfileState extends State<CompleteEndUserProfile> {
  @override
  Widget build(BuildContext context) {
    return const CenteredScrollView(
      children: [
        Padding(
          padding: EdgeInsets.all(25),
          child: CompleteEndUserProfileForm(),
        ),
      ],
    );
  }
}
