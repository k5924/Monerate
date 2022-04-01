import 'package:flutter/material.dart';
import 'package:monerate/src/screens/export.dart';
import 'package:monerate/src/widgets/export.dart';

class FinancialAdvisorTab extends StatefulWidget {
  const FinancialAdvisorTab({Key? key}) : super(key: key);

  @override
  _FinancialAdvisorTabState createState() => _FinancialAdvisorTabState();
}

class _FinancialAdvisorTabState extends State<FinancialAdvisorTab> {
  @override
  Widget build(BuildContext context) {
    return CenteredScrollView(
      children: [
        Text(
          "Financial Advisor",
          style: Theme.of(context).textTheme.headline3,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 25,
        ),
        Image.asset(
          'assets/images/Financial Advisor complete profile.png',
        ),
        const SizedBox(
          height: 25,
        ),
        Text(
          "I want to give individuals financial advice",
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
              CompleteFinancialAdvisorProfile.kID,
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
