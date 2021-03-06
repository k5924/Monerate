import 'package:flutter/material.dart';
import 'package:monerate/src/screens/export.dart';
import 'package:monerate/src/widgets/export.dart';
/// This is the support manager tab which would be displayed as an option for a user to choose when first logging in
class SupportManagerTab extends StatefulWidget {
  /// This is the constructor for this tab
  const SupportManagerTab({Key? key}) : super(key: key);

  @override
  _SupportManagerTabState createState() => _SupportManagerTabState();
}

class _SupportManagerTabState extends State<SupportManagerTab> {
  @override
  Widget build(BuildContext context) {
    return CenteredScrollView(
      children: [
        Text(
          "Support Manager",
          style: Theme.of(context).textTheme.headline3,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 25,
        ),
        Image.asset(
          'assets/images/Support  Manager Complete Profile.png',
        ),
        const SizedBox(
          height: 25,
        ),
        Text(
          "I want to help people use the application",
          style: Theme.of(context).textTheme.headline5,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 25,
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              CompleteSupportManagerProfile.kID,
            );
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 10,
            ),
          ),
          child: const Text(
            "Complete Profile",
            style: TextStyle(
              fontSize: 24,
            ),
          ),
        ),
      ],
    );
  }
}
