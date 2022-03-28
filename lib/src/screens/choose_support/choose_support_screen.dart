import 'package:flutter/material.dart';
import 'package:monerate/src/screens/export.dart';
import 'package:monerate/src/widgets/export.dart';

class ChooseSupportScreen extends StatefulWidget {
  static const String kID = 'choose_support_screen';
  const ChooseSupportScreen({Key? key}) : super(key: key);

  @override
  State<ChooseSupportScreen> createState() => _ChooseSupportScreenState();
}

class _ChooseSupportScreenState extends State<ChooseSupportScreen> {
  @override
  Widget build(BuildContext context) {
    return CenteredScrollView(
      children: [
        GestureDetector(
          child: Card(
            elevation: 4,
            child: Column(
              children: [
                const Text(
                  'Contact a Financial Advisor',
                ),
                Image.asset(
                  'assets/images/Financial Advisor complete profile.png',
                  height: MediaQuery.of(context).size.height * .25,
                ),
                const Text(
                  "If you need financial advice or have any finance related questions, choose this option",
                ),
              ],
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    const PreviousMessagesScreen(chatType: 'finance'),
              ),
            );
          },
        ),
        GestureDetector(
          child: Card(
            elevation: 4,
            child: Column(
              children: [
                const Text(
                  'Contact Support Manager',
                ),
                Image.asset(
                  'assets/images/Support  Manager Complete Profile.png',
                  height: MediaQuery.of(context).size.height * .25,
                ),
                const Text(
                  "If you are having trouble with something in the app, choose this option",
                )
              ],
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    const PreviousMessagesScreen(chatType: 'support'),
              ),
            );
          },
        ),
      ],
    );
  }
}
